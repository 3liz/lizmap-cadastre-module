<?php
/**
* Manage Cadastre request.
* @package   lizmap
* @subpackage cadastre
* @author    3liz
* @copyright 2015 3liz
* @link      http://3liz.com
* @license Mozilla Public License : http://www.mozilla.org/MPL/
*/

jClasses::inc('lizmap~lizmapProxy');
jClasses::inc('lizmap~lizmapOGCRequest');
class lizmapCadastreRequest extends lizmapOGCRequest {

    protected $tplExceptions = 'cadastre~cadastre_exception';

    function createPdf(){

        // Access control
        if( !jAcl2::check("cadastre.acces.donnees.proprio") ){
            jMessage::add('Cadastre - Droits insuffisants pour accéder aux données de propriété', 'Error');
            return $this->serviceException();
        }

        $querystring = $this->constructUrl();
//jLog::log( $querystring );
        // Get remote data
        $getRemoteData = lizmapProxy::getRemoteData(
          $querystring,
          $this->services->proxyMethod,
          $this->services->debugMode
        );
        $data = $getRemoteData[0];
        $mime = $getRemoteData[1];
        $code = $getRemoteData[2];

        jMessage::clearAll();

        // Check mime type
        if( $mime != 'text/json' ){
            jMessage::add('QGIS Server has not returned expected response', 'Error');
            return $this->serviceException();
        }

        // Check for expected errors
        $data = json_decode($data);
        if( $data->status == 'fail' ){
            jMessage::add($data->message, 'Error');
            return $this->serviceException();
        }

        return (object) array(
            'code' => $code,
            'mime' => $mime,
            'data' => $data,
            'cached' => False
        );
    }


    function getPdf(){
        // Access control
        if( !jAcl2::check("cadastre.acces.donnees.proprio") ){
            jMessage::add('Cadastre - Droits insuffisants pour accéder aux données de propriété', 'Error');
            return $this->serviceException();
        }

        $querystring = $this->constructUrl();
//jLog::log($querystring);
        // Get remote data
        $getRemoteData = lizmapProxy::getRemoteData(
          $querystring,
          $this->services->proxyMethod,
          $this->services->debugMode
        );
        $data = $getRemoteData[0];
        $mime = $getRemoteData[1];
        $code = $getRemoteData[2];

        jMessage::clearAll();

        return (object) array(
            'code' => $code,
            'mime' => $mime,
            'data' => $data,
            'cached' => False
        );
    }


    function getHtml(){
        // Access control
        if( !jAcl2::check("cadastre.acces.donnees.proprio") ){
            jMessage::add('Cadastre - Droits insuffisants pour accéder aux données de propriété', 'Error');
            return $this->serviceException();
        }

        $querystring = $this->constructUrl();
//jLog::log($querystring);
        // Get remote data
        $getRemoteData = lizmapProxy::getRemoteData(
          $querystring,
          $this->services->proxyMethod,
          $this->services->debugMode
        );
        $data = json_decode($getRemoteData[0]);
        $data = $data->data;
        $mime = $getRemoteData[1];
        $code = $getRemoteData[2];

        jMessage::clearAll();

        return (object) array(
            'code' => $code,
            'mime' => $mime,
            'data' => $data,
            'cached' => False
        );
    }

}
