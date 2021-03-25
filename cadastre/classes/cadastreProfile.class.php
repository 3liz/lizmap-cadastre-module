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
     * @param project Project key
     * @param repository Repository key
     * @param layerName Name of the Parcelle layer
     * @param profile The default cadastre DB profile
     * @param mixed $repository
     * @param mixed $project
     * @param mixed $layerName
     * @param mixed $profile
     *
     * @return Name of the cadastre DB profile
     */
    public static function get($repository, $project, $layerName, $profile = 'cadastre')
    {
        $p = lizmap::getProject($repository.'~'.$project);
        if ($p === null) {
            throw new Exception("Cadastre profile: Unknown repository/project ${repository}.'~'.${project}");
        }
        $layer = $p->findLayerByName($layerName);
        if ($layer) {
            $layerId = $layer->id;
            $qgisLayer = $p->getLayer($layerId);
            if ($qgisLayer) {
                $profile = $qgisLayer->getDatasourceProfile();
            }
        }
        //jLog::log(json_encode($profile));
        return $profile;
    }

    /**
     * Get the Name of the cadastre DB profile.
     *
     * @param project Project key
     * @param repository Repository key
     * @param layerId Id of the Parcelle layer
     * @param profile The default cadastre DB profile
     * @param mixed $repository
     * @param mixed $project
     * @param mixed $layerId
     * @param mixed $profile
     *
     * @return Name of the cadastre DB profile
     */
    public static function getWithLayerId($repository, $project, $layerId, $profile = 'cadastre')
    {
        $p = lizmap::getProject($repository.'~'.$project);
        if ($p === null) {
            throw new Exception("Cadastre profile: Unknown repository/project ${repository}.'~'.${project}");
        }
        $qgisLayer = $p->getLayer($layerId);
        if ($qgisLayer) {
            $profile = $qgisLayer->getDatasourceProfile();
        }
        //jLog::log(json_encode($profile));
        return $profile;
    }

    /**
     * Check access to table data.
     *
     * @param profile The DB profile to test
     * @param mixed $profile
     *
     * @return true if data is accessible
     */
    public static function checkAccess($profile)
    {
        $ok = false;

        // Access control
        if (!jAcl2::check('cadastre.use.search.tool')) {
            return false;
        }

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
     * @param table Name of the table to test for content
     * @param profile The DB profile to test
     * @param mixed $table
     * @param mixed $profile
     *
     * @return true if data is accessible
     */
    public static function checkTableContent($table, $profile)
    {
        $ok = false;
        // Try to get data from geo_commune
        try {
            // try to get the specific search profile to do not rebuild it
            $cnx = jDb::getConnection($profile);
            $res = $cnx->query('SELECT * FROM "'.$table.'" LIMIT 1');
            foreach ($res as $rec) {
                $ok = true;
            }
        } catch (Exception $e) {
            $ok = false;
        }

        return $ok;
    }
}
