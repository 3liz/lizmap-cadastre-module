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
     * Get the SQL expression of the code of a voie, to compare the voies of the parcelles and of the table voie.
     *
     * The code is ccodep, ccodir, ccocom, ccovoi and ccoriv. The table voie, built from the file TOPO,
     * does not know ccovoi ("00000"), unlike the parcelles and the locaux: only the commune (6 first characters)
     * and the code Rivoli (4 last characters) are compared, like the QGIS plugin.
     *
     * @param string $code Column or parameter giving the code of the voie, like p.voie or $1
     *
     * @return string The SQL expression
     */
    public static function voieSql($code)
    {
        return 'SUBSTR(' . $code . ', 1, 6) || SUBSTR(' . $code . ', 12, 4)';
    }

    /**
     * Get the cadastre config.
     *
     * @param string project Project key
     * @param string repository Repository key
     * @param mixed $repository
     * @param mixed $project
     *
     * @return null|object The cadastre config or null
     */
    public static function get($repository, $project)
    {
        $p = lizmap::getProject($repository . '~' . $project);
        if (!$p) {
            return null;
        }
        $customVariables = $p->getCustomProjectVariables();
        if (!$customVariables) {
            return null;
        }
        if (!array_key_exists('cadastre_parcelle_layer_id', $customVariables)
            || !array_key_exists('cadastre_parcelle_unique_field', $customVariables)) {
            return null;
        }

        $parcelleLayerId = $customVariables['cadastre_parcelle_layer_id'];
        $parcelleLayerUniqueField = $customVariables['cadastre_parcelle_unique_field'];

        $parcelleLayer = $p->getLayer($parcelleLayerId);
        if (!$parcelleLayer) {
            return null;
        }

        $capabilities = array(
            'parcelle' => array(
                'id' => $parcelleLayerId,
                'name' => $parcelleLayer->getName(),
                'title' => $parcelleLayer->getTitle(),
                'shortName' => $parcelleLayer->getShortName(),
                'unique_field' => $customVariables['cadastre_parcelle_unique_field'],
            ),
        );
        $capabilities['parcelle'] = (object) $capabilities['parcelle'];

        if (array_key_exists('cadastre_section_layer_id', $customVariables)) {
            $layer = $p->getLayer($customVariables['cadastre_section_layer_id']);
            if ($layer) {
                $capabilities['section'] = array(
                    'id' => $layer->getId(),
                    'name' => $layer->getName(),
                    'title' => $layer->getTitle(),
                    'shortName' => $layer->getShortName(),
                );
                if (array_key_exists('cadastre_section_unique_field', $customVariables)) {
                    $capabilities['section']['unique_field'] = $customVariables['cadastre_section_unique_field'];
                }
                $capabilities['section'] = (object) $capabilities['section'];
            }
        }

        if (array_key_exists('cadastre_commune_layer_id', $customVariables)) {
            $layer = $p->getLayer($customVariables['cadastre_commune_layer_id']);
            if ($layer) {
                $capabilities['commune'] = array(
                    'id' => $layer->getId(),
                    'name' => $layer->getName(),
                    'title' => $layer->getTitle(),
                    'shortName' => $layer->getShortName(),
                );
                if (array_key_exists('cadastre_commune_unique_field', $customVariables)) {
                    $capabilities['commune']['unique_field'] = $customVariables['cadastre_commune_unique_field'];
                }
                $capabilities['commune'] = (object) $capabilities['commune'];
            }
        }

        return (object) $capabilities;
    }

    public static function getLayerSql($repository, $project, $layerId)
    {
        $p = lizmap::getProject($repository . '~' . $project);

        $qgisLayer = $p->getLayer($layerId);
        if (!$qgisLayer) {
            return null;
        }

        $dtParams = $qgisLayer->getDatasourceParameters();
        if (!$dtParams->sql) {
            return null;
        }

        return $dtParams->sql;
    }

    public static function getFilterByLogin($repository, $project, $layerId)
    {
        if (jAuth::isConnected() && jAcl2::check('lizmap.tools.loginFilteredLayers.override', $repository)) {
            return null;
        }

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

        return $loginFilterConfig;
    }

    public static function getLoginFilter($repository, $project, $layerId)
    {
        if (jAuth::isConnected() && jAcl2::check('lizmap.tools.loginFilteredLayers.override', $repository)) {
            return null;
        }

        $p = lizmap::getProject($repository . '~' . $project);

        $qgisLayer = $p->getLayer($layerId);
        if (!$qgisLayer) {
            return null;
        }

        $loginFilterObj = $p->getLoginFilter($qgisLayer->getName());
        if (!empty($loginFilterObj) && array_key_exists('filter', $loginFilterObj)) {
            return $loginFilterObj['filter'];
        }

        return null;
    }

    public static function getPolygonFilter($repository, $project, $layerId)
    {
        if (jAuth::isConnected() && jAcl2::check('lizmap.tools.loginFilteredLayers.override', $repository)) {
            return null;
        }

        $p = lizmap::getProject($repository . '~' . $project);

        $qgisLayer = $p->getLayer($layerId);
        if (!$qgisLayer) {
            return null;
        }

        $polygonFilter = $qgisLayer->getPolygonFilter();
        if (!$polygonFilter) {
            return null;
        }

        return $polygonFilter;
    }
}
