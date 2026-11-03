<?php

use Lizmap\Request\OGCRequest;
use Lizmap\Request\Proxy;

/**
 * Manage Cadastre request.
 *
 * @author    3liz
 * @copyright 2015 3liz
 *
 * @see      http://3liz.com
 *
 * @license Mozilla Public License : http://www.mozilla.org/MPL/
 */
class lizmapCadastreRequest extends OGCRequest
{
    protected $tplExceptions = 'cadastre~cadastre_exception';

    /**
     * Constructor, with the Lizmap services of the instance.
     *
     * The deprecated class lizmapOGCRequest, which did the same, does not exist anymore in Lizmap 3.10.
     *
     * @param lizmapProject $project    The project
     * @param array         $params     The parameters of the request
     * @param null|string   $requestXml The XML request
     */
    public function __construct($project, $params, $requestXml = null)
    {
        parent::__construct($project, $params, lizmap::getServices(), $requestXml);
    }

    public function process_getcapabilities()
    {
        return $this->getcapabilities();
    }

    protected function getcapabilities()
    {
        $appContext = $this->appContext;
        // Get cached session
        // the cache should be unique between each user/service because the
        // request content depends on rights of the user
        $key = session_id() . '-' . $this->param('service');
        $version = $this->param('version');
        if ($version) {
            $key .= '-' . $version;
        }
        if ($appContext->UserIsConnected()) {
            $juser = $appContext->getUserSession();
            $key .= '-' . $juser->login;
        }
        $key = 'getcapabilities-' . sha1($key);
        $cached = false;

        try {
            $cached = $this->project->getCacheHandler()->getProjectRelatedDataCache($key);
        } catch (Exception $e) {
            // if qgisprojects profile does not exist, or if there is an
            // other error about the cache, let's log it
            jLog::logEx($e, 'error');
        }
        // return cached data
        if ($cached !== false) {
            return (object) array(
                'code' => $cached['code'],
                'mime' => $cached['mime'],
                'data' => $cached['data'],
                'cached' => true,
            );
        }

        // Get remote data
        $response = $this->request();

        // Retry if 500 error ( hackish, but QGIS Server segfault sometimes with cache issue )
        if ($response->code == 500) {
            // Get remote data
            $response = $this->request();
        }

        if ($response->mime != 'text/json' && $response->mime != 'application/json') {
            return (object) array(
                'code' => 400,
                'mime' => 'application/json',
                'data' => json_encode((object) array(
                    'status' => 'fail',
                    'message' => 'Cadastre - Plugin non disponible',
                )),
                'cached' => false,
            );
        }

        if ($response->code == 200) {
            $cachedContent = array(
                'code' => $response->code,
                'mime' => $response->mime,
                'data' => $response->data,
            );
            $cached = $this->project->getCacheHandler()->setProjectRelatedDataCache($key, $cachedContent, 3600);
        }

        return (object) array(
            'code' => $response->code,
            'mime' => $response->mime,
            'data' => $response->data,
            'cached' => $cached,
        );
    }

    public function process_createPdf()
    {
        return $this->createPdf();
    }

    public function createPdf()
    {
        // Access control
        if (!jAcl2::check('cadastre.acces.donnees.proprio') && !jAcl2::check('cadastre.acces.donnees.proprio.simple')) {
            jMessage::add('Cadastre - Droits insuffisants pour accéder aux données de propriété', 'Error');

            return $this->serviceException();
        }

        $querystring = $this->constructUrl();
        // \jLog::log( $querystring );
        // Get remote data
        list($data, $mime, $code) = Proxy::getRemoteData($querystring);

        jMessage::clearAll();

        // Check mime type
        if ($mime != 'text/json' && $mime != 'application/json') {
            jMessage::add('QGIS Server has not returned expected response', 'Error');

            return $this->serviceException();
        }

        // Check for expected errors
        $data = json_decode($data);
        if ($data->status == 'fail') {
            jMessage::add($data->message, 'Error');

            return $this->serviceException();
        }

        return (object) array(
            'code' => $code,
            'mime' => $mime,
            'data' => $data,
            'cached' => false,
        );
    }

    public function process_getPdf()
    {
        return $this->getPdf();
    }

    public function getPdf()
    {
        // Access control
        if (!jAcl2::check('cadastre.acces.donnees.proprio') && !jAcl2::check('cadastre.acces.donnees.proprio.simple')) {
            jMessage::add('Cadastre - Droits insuffisants pour accéder aux données de propriété', 'Error');

            return $this->serviceException();
        }

        $querystring = $this->constructUrl();
        // \jLog::log($querystring);
        // Get remote data
        list($data, $mime, $code) = Proxy::getRemoteData($querystring);

        jMessage::clearAll();

        return (object) array(
            'code' => $code,
            'mime' => $mime,
            'data' => $data,
            'cached' => false,
        );
    }

    public function process_getHtml()
    {
        return $this->getHtml();
    }

    public function getHtml()
    {
        // Access control
        if (!jAcl2::check('cadastre.acces.donnees.proprio') && !jAcl2::check('cadastre.acces.donnees.proprio.simple')) {
            jMessage::add('Cadastre - Droits insuffisants pour accéder aux données de propriété', 'Error');

            return $this->serviceException();
        }

        $querystring = $this->constructUrl();
        // \jLog::log($querystring);
        // Get remote data
        list($data, $mime, $code) = Proxy::getRemoteData($querystring);
        $data = json_decode($data);
        $data = $data->data;

        jMessage::clearAll();

        return (object) array(
            'code' => $code,
            'mime' => $mime,
            'data' => $data,
            'cached' => false,
        );
    }

    public function process_getExport()
    {
        return $this->getExport();
    }

    /**
     * Get the data of a CSV export from the QGIS plugin: the names of the columns and the rows.
     *
     * The request is sent with POST, the list of the parcelles can be long.
     *
     * @return object The response, with the decoded JSON as data
     */
    public function getExport()
    {
        // Access control
        if (!jAcl2::check('cadastre.acces.donnees.proprio') && !jAcl2::check('cadastre.acces.donnees.proprio.simple')) {
            jMessage::add('Cadastre - Droits insuffisants pour accéder aux données de propriété', 'Error');

            return $this->serviceException();
        }

        $response = $this->request(true);

        return (object) array(
            'code' => $response->code,
            'mime' => $response->mime,
            'data' => json_decode($response->data),
            'cached' => false,
        );
    }
}
