<?php
/**
* @package   lizmap
* @subpackage cadastre
* @author    Michael Douchin
* @copyright 2019 3liz
* @link      http://3liz.com
* @license    Mozilla Public Licence
*/

class cadastreConfig {

    /**
    * Get the cadastre config
    * @param project Project key
    * @param repository Repository key
    * @return The cadastre config or null
    */
    public static function get($repository, $project) {
        $p = lizmap::getProject($repository.'~'.$project);
        if ($p) {
            $request = new lizmapCadastreRequest(
                $p,
                array(
                    'service'=>'CADASTRE',
                    'request'=>'GetCapabilities'
                )
            );
            $result = $request->process();
            if ($result->code === 200 && $result->mime !== 'text/xml'){
                $data = json_decode($result->data);
                if ($data->status == 'success') {
                    return $data->data;
                }
            }
        }
        return Null;
    }

    public static function getFilterByLogin($repository, $project, $layerId) {
        $p = lizmap::getProject($repository.'~'.$project);
        if ( !$p->hasLoginFilteredLayers() ) {
            return Null;
        }

        $pConfig = $p->getFullCfg();
        if ( !$pConfig->loginFilteredLayers ) {
            return Null;
        }

        $qgisLayer = $p->getLayer($layerId);
        if ( !$qgisLayer ) {
            return Null;
        }

        $layerName = $qgisLayer->getName();
        if ( !property_exists($pConfig->loginFilteredLayers, $layerName) ) {
            return Null;
        }

        if ( jAuth::isConnected() && jAcl2::check('lizmap.tools.loginFilteredLayers.override', $repository) ) {
            return Null;
        }

        return $pConfig->loginFilteredLayers->{$layerName};
    }

}
