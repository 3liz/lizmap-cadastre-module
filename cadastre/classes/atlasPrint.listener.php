<?php

/**
 * Log lizmap actions.
 *
 * @author    3liz
 * @copyright 2012 3liz
 *
 * @see      http://3liz.com
 *
 * @license    Mozilla Public License : http://www.mozilla.org/MPL/
 */
class atlasPrintListener extends jEventListener
{
    /**
     * When a user logs in.
     *
     * @param mixed $event
     */
    public function onBeforePdfCreation($event)
    {
        $cadastreConfig = array();
        $profile = 'cadastre';
        $services = lizmap::getServices();
        if (version_compare($services->qgisServerVersion, '3.0', '<')) {
            if (!preg_match('#^cadastre#i', $event->project)) {
                return null;
            }
            $cadastreConfig = array(
                'layer' => 'Parcelles',
                'pk' => 'geo_parcelle',
            );
        } else {
            $config = cadastreConfig::get($event->repository, $event->project);
            if ($config == null) {
                return null;
            }
            $cadastreConfig = array(
                'layer' => $config->parcelle->name,
                'pk' => $config->parcelle->unique_field,
            );
            if ($config->parcelle->shortName && strlen($config->parcelle->shortName)) {
                $cadastreConfig['layer'] = $config->parcelle->shortName;
            }
            $profile = cadastreProfile::getWithLayerId(
                $event->repository,
                $event->project,
                $config->parcelle->id
            );
        }

        try {
            // try to get the specific search profile to do not rebuild it
            jProfiles::get('jdb', $profile, true);
        } catch (Exception $e) {
            return null;
        }

        $status = 'error';
        $file = null;

        // We must generate a HTML file in the temp folder with the parcelle detail
        $params = $event->params;
        if (!array_key_exists('layer', $params)
            or !array_key_exists('exp_filter', $params)
        ) {
            $event->add(
                array('status' => $status, 'file' => $file)
            );

            return null;
        }

        $layer = $params['layer'];
        $exp_filter = $params['exp_filter'];
        if (!$layer or $layer != $cadastreConfig['layer'] or !$exp_filter) {
            $event->add(
                array('status' => $status, 'file' => $file)
            );

            return null;
        }

        // Récupération de la parcelle
        // $id IN (29746)
        $match = array();
        $get_fid = preg_match('(\d+)', $exp_filter, $match);
        $fid = intval($match[0]);

        if ($fid < 1) {
            $event->add(
                array('status' => $status, 'file' => $file)
            );

            return null;
        }

        // Try to get data from geo_commune
        try {
            $sql = 'SELECT geo_parcelle FROM parcelle_info WHERE ogc_fid = ' . $fid;
            $cnx = jDb::getConnection($profile);
            $result = $cnx->query($sql);
            $geo_parcelle = -1;
            foreach ($result as $line) {
                $geo_parcelle = $line->geo_parcelle;
            }
            $p = lizmap::getProject($event->repository . '~' . $event->project);
            $request = new lizmapCadastreRequest(
                $p,
                array(
                    'service' => 'CADASTRE',
                    'version' => '1.0.0',
                    'request' => 'getHtml',
                    'layer' => $layer,
                    'parcelle' => $geo_parcelle,
                    'type' => 'fiche',
                )
            );
            $result = $request->process();

            // File path. Needs to be made from geo_parcelle
            // so that atlas composer can call it via
            // concat(
            // '/var/www/LIZMAP/release_3_2/temp/lizmap/www/fiche_cadastre_',
            // "geo_parcelle" ,
            // '.html'
            // )
            $path = jApp::tempPath('fiche_cadastre_' . $geo_parcelle . '.html');
            if (file_exists($path)) {
                unlink($path);
            }

            // Check errors
            if ($result->mime == 'text/xml') {
                $event->add(
                    array('status' => $status, 'file' => $file)
                );

                return null;
            }

            $content = $result->data;

            $file = fopen($path, 'w');
            $pieces = str_split($content, 1024 * 4);
            foreach ($pieces as $piece) {
                fwrite($file, $piece, strlen($piece));
            }
            fclose($file);
            // \jLog::log($path);
            $file = $path;
            $status = 'success';
        } catch (Exception $e) {
            jLog::log('Cadastre :: ' . $e->getMessage());
        }

        $event->add(
            array('status' => $status, 'file' => $file)
        );
    }
}
