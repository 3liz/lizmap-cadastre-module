<?php
/**
 * @author    3liz
 * @copyright 2016 3liz
 *
 * @see      http://3liz.com
 *
 * @license Mozilla Public License : http://www.mozilla.org/MPL/
 */
class serviceCtrl extends jController
{
    /**
     * Get PDF generated by QGIS Server Cadastre plugin.
     *
     * @urlparam project Project key
     * @urlparam repository Repository key
     * @urlparam layer Name of the Parcelle layer
     * @urlparam parcelle ID of the parcelle ( field geo_parcellle )
     * @urlparam type Type of export: parcelle or proprietaire
     */
    public function getCadastrePdf()
    {
        $project = $this->param('project');
        $repository = $this->param('repository');

        $rep = $this->getResponse('json');

        if (!jAcl2::check('cadastre.acces.donnees.proprio') && !jAcl2::check('cadastre.acces.donnees.proprio.simple')) {
            $rep->data = array('status' => 'error', 'message' => 'Vous n\'avez pas les droits pour voir les données de propriété.');

            return $rep;
        }

        $services = lizmap::getServices();
        if (version_compare($services->qgisServerVersion, '3.0', '<')
            && !preg_match('#^cadastre#i', $project)) {
            $rep->data = array('status' => 'error', 'message' => 'This is not a cadastre project. Project key must begins with cadastre');

            return $rep;
        }

        $p = lizmap::getProject($repository . '~' . $project);
        if (!$p) {
            $rep->data = array('status' => 'error', 'message' => 'A problem occurred while loading project with Lizmap');

            return $rep;
        }

        jClasses::inc('cadastre~lizmapCadastreRequest');
        if (version_compare($services->qgisServerVersion, '3.0', '>=')) {
            $request = new lizmapCadastreRequest(
                $p,
                array(
                    'service' => 'CADASTRE',
                    'version' => '1.0.0',
                    'request' => 'GetCapabilities',
                )
            );
            $result = $request->process();
            if ($result->code !== 200) {
                $rep->data = array('status' => 'error', 'message' => 'Cadastre module is not well installed.');

                return $rep;
            }
        }

        $config = cadastreConfig::get($repository, $project);
        if ($config === null) {
            $rep->data = array('status' => 'error', 'message' => 'This is not a cadastre project or has not been configured.');

            return $rep;
        }

        $parcelleLayer = $this->param('layer');
        $parcelleId = $this->param('parcelle');
        $type = $this->param('type');
        if (!$parcelleLayer or !$parcelleId or !$type) {
            $rep->data = array('status' => 'error', 'message' => 'layer, parcelle and type parameters are mandatory.');

            return $rep;
        }
        if ($parcelleLayer !== $config->parcelle->name) {
            $rep->data = array('status' => 'error', 'message' => 'The layer has not been identified.');

            return $rep;
        }

        if ($type == 'fiche') {
            $creq = 'getHtml';
        // jLog::log($creq);
        } else {
            $creq = 'createPdf';
        }
        $advanced = jAcl2::check('cadastre.acces.donnees.proprio');
        if ($type == 'parcelle-tiers') {
            $advanced = false;
            $type = 'parcelle';
        }
        $request = new lizmapCadastreRequest(
            $p,
            array(
                'service' => 'CADASTRE',
                'version' => '1.0.0',
                'request' => $creq,
                'layer' => $parcelleLayer,
                'parcelle' => $parcelleId,
                'type' => $type,
                'advanced' => $advanced,
            )
        );
        $result = $request->process();

        // Check errors
        if ($result->mime == 'text/xml') {
            $rep->data = array('status' => 'error', 'message' => trim(preg_replace("#\n#", '', strip_tags($result->data))));

            return $rep;
        }

        if ($type == 'fiche') {
            $rep = $this->getResponse('htmlfragment');
            $rep->addContent($result->data);

            return $rep;
        }

        // Get created PDFs;
        $data = $result->data;
        $pdfs = array();
        $tok = null;
        foreach ($data->data->tokens as $token) {
            $tok = $token;
            $request = new lizmapCadastreRequest(
                $p,
                array(
                    'service' => 'CADASTRE',
                    'version' => '1.0.0',
                    'request' => 'getPdf',
                    'token' => $token,
                )
            );
            $result = $request->process();
            if ($result->mime != 'application/pdf') {
                continue;
            }
            $pdfs[$token] = $result->data;
        }

        if (count($pdfs) == 0) {
            $rep = $this->getResponse('text');
            $rep->content = 'Erreur de création du relevé.';
        } elseif (count($pdfs) == 1) {
            $rep = $this->getResponse('binary');
            $rep->mimeType = 'application/pdf';
            $rep->content = $pdfs[$tok];
            $rep->doDownload = false;
            $rep->setLifetime(300);
            $rep->outputFileName = 'cadastre_' . $tok . '.pdf';
        } else {
            $rep = $this->getResponse('zip');
            $rep->zipFilename = 'releves_cadastre.zip';
            foreach ($pdfs as $token => $pdf) {
                $rep->content->addContentFile('cadastre_' . $token . '.pdf', $pdf);
            }
        }

        return $rep;
    }

    /**
     * Autocompletion search.
     */
    public function autocomplete()
    {
        $rep = $this->getResponse('json');

        $term = $this->param('term');
        $field = $this->param('field', 'voie');
        $extras = array(
            'commune' => $this->param('commune'),
            'voie' => $this->param('voie'),
            'comptecommunal' => $this->param('comptecommunal'),
        );
        $limit = $this->intParam('limit', 30);

        $project = $this->param('project');
        $repository = $this->param('repository');

        // Get profile
        $parcelleLayer = $this->param('layer', 'Parcelles');
        // $profile = cadastreProfile::get($repository, $project, $parcelleLayer);

        $autocomplete = jClasses::getService('cadastre~search');

        try {
            $result = $autocomplete->getData($repository, $project, $parcelleLayer, $term, $field, $extras, $limit);
        } catch (Exception $e) {
            $result = null;
        }

        $rep->data = $result;

        return $rep;
    }

    /**
     * Get total extent for road or owner.
     */
    public function extent()
    {
        $rep = $this->getResponse('json');

        $field = $this->param('field', 'voie');
        $value = $this->param('value');

        $project = $this->param('project');
        $repository = $this->param('repository');

        $parcelleLayer = $this->param('layer', 'Parcelles');

        $autocomplete = jClasses::getService('cadastre~search');
        $result = $autocomplete->getDataExtent($repository, $project, $parcelleLayer, $field, $value);

        $rep->data = $result;

        return $rep;
    }

    /**
     * Export data.
     */
    public function initExport()
    {
        $rep = $this->getResponse('json');
        $services = lizmap::getServices();

        // params
        $project = $this->param('project');
        $repository = $this->param('repository');
        $parcelleLayer = $this->param('layer', 'Parcelles');
        $parcelleId = $this->param('parcelle');
        $type = $this->param('type');

        // Use standard export if the standalone python PDF generator does not exist
        // The Python script, if available, if run asynchronously
        // and a new Export page is shown to show the user the progress
        // If not, use a synchronous call to QGIS Server, which could reach timeouts for big export (commune)
        $standalone_python_script = '/srv/qgis/plugins/cadastre/standalone_export.py';
        if (version_compare($services->qgisServerVersion, '3.0', '>=')) {
            $standalone_python_script = '/srv/qgis/plugins/cadastre/standalone/export.py';
        }
        // Do not use the Python script if we only need to get the HTML content
        // Which is retrieved in AJAX calls. Hence the or $type == fiche call
        if (!is_file($standalone_python_script) or $type != 'proprietaire') {
            return $this->getCadastrePdf();
        }

        // get needed values
        $p = lizmap::getProject($repository . '~' . $project);

        // checks
        if (!jAcl2::check('cadastre.acces.donnees.proprio') && !jAcl2::check('cadastre.acces.donnees.proprio.simple')) {
            $rep->data = array('status' => 'error', 'message' => 'Vous n\'avez pas les droits pour voir les données de propriété.');

            return $rep;
        }
        if (!$p) {
            $rep->data = array('status' => 'error', 'message' => 'A problem occurred while loading project with Lizmap');

            return $rep;
        }

        // Create token
        $token = md5($repository . $project . $parcelleLayer . $parcelleId . $type . microtime(true));
        $_SESSION['cadastre_export_' . $token] = 'wait';

        // Create file path
        $log = jApp::tempPath($token . '.log');

        // Run python code
        $cmd = 'python ' . $standalone_python_script;
        if (version_compare($services->qgisServerVersion, '3.0', '>=')) {
            $cmd = 'python3 ' . $standalone_python_script;
        }
        $cmd .= ' -P ' . $p->getQgisPath();
        $cmd .= ' -L "' . $parcelleLayer . '"';
        $cmd .= ' -I ' . $parcelleId;
        $cmd .= ' -T ' . $type;
        $cmd .= ' -D ' . jApp::tempPath();
        $cmd .= ' -O ' . $log;
        // jLog::log($cmd);
        $this->execInBackground($cmd);

        // Redirect to display page
        $rep = $this->getResponse('redirect');
        $rep->action = 'cadastre~service:waitExport';
        $rep->params = $this->params();
        $rep->params['token'] = $token;

        return $rep;
    }

    private function execInBackground($cmd)
    {
        if (substr(php_uname(), 0, 7) == 'Windows') {
            pclose(popen('start /B ' . $cmd, 'r'));
        } else {
            exec($cmd . ' > /dev/null &');
        }
    }

    public function waitExport()
    {
        $rep = $this->getResponse('json');

        // params
        $project = $this->param('project');
        $repository = $this->param('repository');
        $token = $this->param('token');

        // get needed values
        $p = lizmap::getProject($repository . '~' . $project);

        // checks
        if (!jAcl2::check('cadastre.acces.donnees.proprio') && !jAcl2::check('cadastre.acces.donnees.proprio.simple')) {
            $rep->data = array('status' => 'error', 'message' => 'Vous n\'avez pas les droits pour voir les données de propriété.');

            return $rep;
        }
        if (!$p) {
            $rep->data = array('status' => 'error', 'message' => 'A problem occurred while loading project with Lizmap');

            return $rep;
        }

        $rep = $this->getResponse('html');
        $rep->title = 'Export des données cadastrales';
        $rep->body->assign('repositoryLabel', 'Cadastre');
        $rep->body->assign('isConnected', jAuth::isConnected());
        $rep->body->assign('user', jAuth::getUserSession());

        // Add JS code to refresh
        $rep->addJSCode("var token = '" . $token . "'; ");
        $checkUrl = jUrl::get(
            'cadastre~service:checkExport',
            $this->params()
        );
        $rep->addJSCode("var checkUrl = '" . $checkUrl . "'; ");
        $jslink = jUrl::get(
            'jelix~www:getfile',
            array('targetmodule' => 'cadastre', 'file' => 'cadastre-export.js')
        );
        $rep->addJSLink($jslink);
        $rep->body->assign('MAIN', "<br/><div id=\"waitExport\">L'export est en cours...</div>");

        return $rep;
    }

    public function checkExport()
    {
        $rep = $this->getResponse('json');

        // params
        $project = $this->param('project');
        $repository = $this->param('repository');
        $token = $this->param('token');

        // Get log path
        $log = jApp::tempPath($token . '.log');
        $logcontent = jFile::read($log);
        if (!array_key_exists('cadastre_export_' . $token, $_SESSION)) {
            $data = array(
                'status' => 'error',
                'message' => 'La requête est périmée.',
            );
        } else {
            $ses = $_SESSION['cadastre_export_' . $token];
            if (!empty($logcontent)) {
                $data = array(
                    'status' => 'ok',
                    'url' => jUrl::getFull(
                        'cadastre~service:downloadExport',
                        $this->params()
                    ),
                    'message' => 'Le fichier a bien été créé',
                );
            } else {
                $data = array(
                    'status' => 'wait',
                    'message' => 'L\'export est en cours...',
                );
            }
        }
        $rep->data = $data;

        return $rep;
    }

    public function downloadExport()
    {
        $rep = $this->getResponse('json');

        // params
        $project = $this->param('project');
        $repository = $this->param('repository');
        $token = $this->param('token');

        // get needed values
        $p = lizmap::getProject($repository . '~' . $project);

        // checks
        if (!jAcl2::check('cadastre.acces.donnees.proprio') && !jAcl2::check('cadastre.acces.donnees.proprio.simple')) {
            $rep->data = array('status' => 'error', 'message' => 'Vous n\'avez pas les droits pour voir les données de propriété.');

            return $rep;
        }
        if (!$p) {
            $rep->data = array('status' => 'error', 'message' => 'A problem occurred while loading project with Lizmap');

            return $rep;
        }

        // Get log path
        $log = jApp::tempPath($token . '.log');
        $logcontent = jFile::read($log);
        if (!array_key_exists('cadastre_export_' . $token, $_SESSION)) {
            $data = array(
                'status' => 'error',
                'message' => 'La requête est périmée.',
            );
            $rep->data = $data;

            return $rep;
        }
        if (!empty($logcontent)) {
            if (is_file($logcontent)) {
                $rep = $this->getResponse('binary');
                $rep->mimeType = 'application/pdf';
                $rep->content = jFile::read($logcontent);
                $rep->doDownload = false;
                $rep->setLifetime(300);
                $rep->outputFileName = 'cadastre_' . $token . '.pdf';
                unlink($logcontent);
                unlink($log);
                unset($_SESSION['cadastre_export_' . $token]);

                return $rep;
            }
            $files = explode('.pdf', $logcontent);
            $rep = $this->getResponse('zip');
            $rep->zipFilename = "Export_cadastre_${token}.zip";
            foreach ($files as $file) {
                $fp = $file . '.pdf';
                if (is_file($fp)) {
                    $rep->content->addContentFile(basename($fp), jFile::read($fp));
                    unlink($fp);
                }
            }
            unlink($log);
            unset($_SESSION['cadastre_export_' . $token]);

            return $rep;
        }
        $rep->data = array('status' => 'error', 'message' => 'La requête est périmée.');

        return $rep;
    }

    /**
     * Récupération des locaux et des propriétaires
     * pour toutes les parcelles sélectionnées.
     */
    public function locauxProprios()
    {
        $rep = $this->getResponse('json');

        if (!jAcl2::check('cadastre.acces.donnees.proprio') && !jAcl2::check('cadastre.acces.donnees.proprio.simple')) {
            $rep->data = array(
                'status' => 'error',
                'message' => 'Vous n\'avez pas les droits pour voir les données de propriété.',
            );

            return $rep;
        }

        $project = $this->param('project');
        $repository = $this->param('repository');
        $p = lizmap::getProject($repository . '~' . $project);
        if (!$p) {
            $rep->data = array('status' => 'error', 'message' => 'A problem occurred while loading project with Lizmap');

            return $rep;
        }

        $parcelleIds = $this->param('parcelles');
        $parcelleIds = explode(',', $parcelleIds);
        $withGeom = false;
        $forThirdParty = true;
        if (jAcl2::check('cadastre.acces.donnees.proprio')) {
            $advanced = $this->param('advanced');
            $forThirdParty = ($advanced !== '1');
        }

        /** @var \jResponseBinary $rep */
        $rep = $this->getResponse('binary');
        $rep->mimeType = 'text/csv';

        // Get profile
        $parcelleLayer = $this->param('layer', 'Parcelles');

        /** @var cadastreExtraInfos $extra_infos */
        $extra_infos = jClasses::getService('cadastre~cadastreExtraInfos');
        $path = $extra_infos->getLocauxAndProprioInfos($repository, $project, $parcelleLayer, $parcelleIds, $withGeom, $forThirdParty);

        $rep->fileName = $path;
        $rep->deleteFileAfterSending = true;

        $rep->doDownload = true;
        $rep->outputFileName = 'cadastre_extra_infos.csv';

        return $rep;
    }

    /**
     * Get the needed information on the given QGIS layer.
     *
     * @param string $layerId    The ID of the QGIS layer
     * @param mixed  $repository
     * @param mixed  $project
     * @param mixed  $field
     *
     * @return null|array The layer characteristics
     */
    private function getSpatialLayerInfo($repository, $project, $layerId, $field)
    {
        // Get spatial layer name, table info, fields, etc.
        $p = lizmap::getProject($repository . '~' . $project);
        if ($p === null) {
            return null;
        }

        /** @var \qgisVectorLayer $qgisLayer The QGIS vector layer instance */
        $qgisLayer = $p->getLayer($layerId);
        if (!$qgisLayer) {
            return null;
        }

        // Get the PostgreSQL information
        $dataSourceParameters = $qgisLayer->getDatasourceParameters();
        $spatialLayerSchema = $dataSourceParameters->schema;
        $spatialLayerTable = $dataSourceParameters->tablename;

        // Check that the given field exists
        $fields = $qgisLayer->getFields();
        if (!empty($field) && !in_array($field, $fields)) {
            return null;
        }

        // Get the table primary key field
        // Only one field supported
        $dbFieldsInfo = $qgisLayer->getDbFieldsInfo();
        $spatialLayerPk = null;
        foreach ($dbFieldsInfo->primaryKeys as $key) {
            $spatialLayerPk = $key;

            break;
        }

        return array(
            'schema' => $spatialLayerSchema,
            'table' => $spatialLayerTable,
            'pk' => $spatialLayerPk,
            'field' => $field,
            'geometryColumn' => $dbFieldsInfo->geometryColumn,
        );
    }

    /**
     * Récupération des parcelles et des propriétaires
     * pour toutes les parcelles sélectionnées.
     */
    public function parcellesProprios()
    {
        $rep = $this->getResponse('json');

        if (!jAcl2::check('cadastre.acces.donnees.proprio') && !jAcl2::check('cadastre.acces.donnees.proprio.simple')) {
            $rep->data = array(
                'status' => 'error',
                'message' => 'Vous n\'avez pas les droits pour voir les données de propriété.',
            );

            return $rep;
        }

        $project = $this->param('project');
        $repository = $this->param('repository');
        $p = lizmap::getProject($repository . '~' . $project);
        if (!$p) {
            $rep->data = array('status' => 'error', 'message' => 'A problem occurred while loading project with Lizmap');

            return $rep;
        }

        $parcelleIds = $this->param('parcelles');
        $parcelleIds = explode(',', $parcelleIds);
        $withGeom = false;
        $forThirdParty = true;
        if (jAcl2::check('cadastre.acces.donnees.proprio')) {
            $advanced = $this->param('advanced');
            $forThirdParty = ($advanced !== '1');
        }

        /** @var \jResponseBinary $rep */
        $rep = $this->getResponse('binary');
        $rep->mimeType = 'text/csv';

        // Get profile
        $parcelleLayer = $this->param('layer', 'Parcelles');

        // If we need to compute the list of codes from the intersected layer for each returned line
        $intersectionDataJson = $this->param('additionalData', null);
        $intersectionParams = null;
        $intersectionData = null;
        if ($intersectionDataJson) {
            $intersectionData = json_decode($intersectionDataJson);
        }
        if (!empty($intersectionData)
            && property_exists($intersectionData, 'spatial_layer_id') && !empty($intersectionData->spatial_layer_id)
            && property_exists($intersectionData, 'spatial_layer_field') && !empty($intersectionData->spatial_layer_field)
            && property_exists($intersectionData, 'spatial_layer_buffer') && preg_match('/^[0-9]+$/', $intersectionData->spatial_layer_buffer)
            && property_exists($intersectionData, 'spatial_layer_selected_ids') && !empty($intersectionData->spatial_layer_selected_ids)
        ) {
            // Get the QGIS layer information
            $spatialLayerInfo = $this->getSpatialLayerInfo(
                $repository,
                $project,
                $intersectionData->spatial_layer_id,
                $intersectionData->spatial_layer_field
            );
            if ($spatialLayerInfo !== null) {
                // Format & validate selected Ids
                $ids = explode(',', $intersectionData->spatial_layer_selected_ids);
                $selectedIds = array();
                foreach ($ids as $id) {
                    if (preg_match('/[0-9A-Za-z_]+/', trim($id))) {
                        $selectedIds[] = trim($id);
                    }
                }
                if (count($selectedIds) > 0) {
                    $selectedIdsString = "'" . implode("', '", $selectedIds) . "'";
                    $intersectionParams = array(
                        'field' => $spatialLayerInfo['field'],
                        'schema' => $spatialLayerInfo['schema'],
                        'table' => $spatialLayerInfo['table'],
                        'pk' => $spatialLayerInfo['pk'],
                        'selectedIds' => $selectedIdsString,
                        'geometryColumn' => $spatialLayerInfo['geometryColumn'],
                        'buffer' => (int) $intersectionData->spatial_layer_buffer,
                    );
                }
            }
        }

        /** @var cadastreExtraInfos $extra_infos */
        $extra_infos = jClasses::getService('cadastre~cadastreExtraInfos');
        $path = $extra_infos->getParcellesAndProprioInfos(
            $repository,
            $project,
            $parcelleLayer,
            $parcelleIds,
            $withGeom,
            $forThirdParty,
            $intersectionParams
        );

        $rep->fileName = $path;
        $rep->deleteFileAfterSending = true;

        $rep->doDownload = true;
        $rep->outputFileName = 'cadastre_parcelles_et_proprietaires.csv';

        return $rep;
    }
}
