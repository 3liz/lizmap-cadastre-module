<?php
/**
 * @author    Michael Douchin
 * @copyright 2019 3liz
 *
 * @see      http://3liz.com
 *
 * @license    Mozilla Public Licence
 */
class cadastreConfig
{
    /**
     * Get the cadastre config.
     *
     * @param project Project key
     * @param repository Repository key
     * @param mixed $repository
     * @param mixed $project
     *
     * @return The cadastre config or null
     */
    public static function get($repository, $project)
    {
        $p = lizmap::getProject($repository . '~' . $project);
        if ($p) {
            $request = new lizmapCadastreRequest(
                $p,
                array(
                    'service' => 'CADASTRE',
                    'version' => '1.0.0',
                    'request' => 'GetCapabilities',
                )
            );
            $result = $request->process();
            if ($result->code === 200 && $result->mime !== 'text/xml') {
                $data = json_decode($result->data);
                if ($data->status == 'success') {
                    return $data->data;
                }
            }
        }

        return null;
    }

    public static function getFilterByLogin($repository, $project, $layerId)
    {
        $p = lizmap::getProject($repository . '~' . $project);

        $qgisLayer = $p->getLayer($layerId);
        if (!$qgisLayer) {
            return null;
        }

        $layerName = $qgisLayer->getName();
        $loginFilterConfig = $p->getLoginFilteredConfig($layerName);
        if (!$loginFilterConfig) {
            return null;
        }

        if (jAuth::isConnected() && jAcl2::check('lizmap.tools.loginFilteredLayers.override', $repository)) {
            return null;
        }

        return $loginFilterConfig;
    }
}
