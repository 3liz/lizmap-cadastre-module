<?php

/**
 * @author    Michael Douchin
 * @copyright 2019 3liz
 *
 * @see      http://3liz.com
 *
 * @license    Mozilla Public Licence
 */
class cadastreProfile
{
    /**
     * Get the Name of the cadastre DB profile.
     *
     * @param string $project    Project key
     * @param string $repository Repository key
     * @param string $layerName  Name of the Parcelle layer
     * @param string $profile    The default cadastre DB profile
     *
     * @return string Name of the cadastre DB profile
     */
    public static function get($repository, $project, $layerName, $profile = 'cadastre')
    {
        $p = lizmap::getProject($repository . '~' . $project);
        if ($p === null) {
            throw new Exception("Cadastre profile: Unknown repository/project ${repository}.'~'.${project}");
        }
        $layer = $p->findLayerByName($layerName);
        if ($layer) {
            $layerId = $layer->id;
            $qgisLayer = $p->getLayer($layerId);
            if ($qgisLayer) {
                $profile = $qgisLayer->getDatasourceProfile(31);
            }
        }

        // \jLog::log(json_encode($profile));
        return $profile;
    }

    /**
     * Get the Name of the cadastre DB profile.
     *
     * @param string $project    Project key
     * @param string $repository Repository key
     * @param string $layerId    Id of the Parcelle layer
     * @param string $profile    The default cadastre DB profile
     *
     * @return string Name of the cadastre DB profile
     */
    public static function getWithLayerId($repository, $project, $layerId, $profile = 'cadastre')
    {
        $p = lizmap::getProject($repository . '~' . $project);
        if ($p === null) {
            throw new Exception("Cadastre profile: Unknown repository/project ${repository}.'~'.${project}");
        }
        $qgisLayer = $p->getLayer($layerId);
        if ($qgisLayer) {
            $profile = $qgisLayer->getDatasourceProfile(31);
        }

        // \jLog::log(json_encode($profile));
        return $profile;
    }

    /**
     * Check access to table data.
     *
     * @param string $profile The DB profile to test
     *
     * @return bool true if data is accessible
     */
    public static function checkAccess($profile)
    {
        // Access control
        if (!jAcl2::check('cadastre.use.search.tool')) {
            return false;
        }

        $ok = false;

        // Try to get data from geo_commune
        try {
            // try to get the specific search profile to do not rebuild it
            $cnx = jDb::getConnection($profile);
            $cnx->query('SELECT geo_commune FROM geo_commune LIMIT 0;');
            $ok = true;
        } catch (Exception $e) {
            $ok = false;
        }

        return $ok;
    }

    /**
     * Check access to table data.
     *
     * @param string $table   Name of the table to test for content
     * @param string $profile The DB profile to test
     *
     * @return bool true if data is accessible
     */
    public static function checkTableContent($table, $profile)
    {
        $ok = false;

        // Try to get data from geo_commune
        try {
            // try to get the specific search profile to do not rebuild it
            $cnx = jDb::getConnection($profile);
            $res = $cnx->query('SELECT * FROM "' . $table . '" LIMIT 1');
            foreach ($res as $rec) {
                $ok = true;
            }
        } catch (Exception $e) {
            $ok = false;
        }

        return $ok;
    }
}
