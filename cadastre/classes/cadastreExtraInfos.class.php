<?php

/**
 * @author    Rene-Luc Dhont
 * @copyright 2019 3liz
 *
 * @see      http://3liz.com
 *
 * @license    Mozilla Public Licence
 */
class cadastreExtraInfos
{
    protected function getFilterSql($filterConfig, $profile = 'cadastre', $tableAlias = '')
    {
        $cnx = jDb::getConnection($profile);
        $field = $filterConfig->filterAttribute;
        $value = null;
        if (jAuth::isConnected()) {
            if (property_exists($filterConfig, 'filterPrivate') && $filterConfig->filterPrivate == 'True') {
                $user = jAuth::getUserSession();
                $value = $user->login;
            } else {
                $value = jAcl2DbUserGroup::getGroups();
            }
        }

        $sql = '';

        if (is_array($value)) {
            $preparedValues = array();
            foreach ($value as $v) {
                $preparedValues[] = $cnx->quote(trim($v));
            }
            $sql .= '"' . $field . '" IN (' . implode(', ', $preparedValues) . ', ' . $cnx->quote('all') . ')';
        } elseif (is_string($value) || is_numeric($value)) {
            $sql .= '"' . $field . '" IN (' . $cnx->quote(trim($value)) . ', ' . $cnx->quote('all') . ')';
        } else {
            $sql .= '"' . $field . '" = ' . $cnx->quote('all');
        }
        if ($tableAlias !== '') {
            $sql = $tableAlias . '.' . $sql;
        }

        return $sql;
    }

    /**
     * Regular expression of a valid parcelle id, the field geo_parcelle, like 1320290000A0107.
     */
    public const PARCELLE_ID_PATTERN = '/^[0-9A-Z]{1,20}$/';

    /**
     * Regular expression of a valid id of an object selected in the spatial search.
     */
    public const OBJECT_ID_PATTERN = '/^[0-9A-Za-z_-]{1,100}$/';

    /**
     * Parse and validate a comma separated list of parcelle ids, given by the user.
     *
     * @param null|string $parcelles The ids of the parcelles, separated by commas
     *
     * @return null|array The ids, or null if the list is empty or if one id is not valid
     */
    public static function parseParcelleIds($parcelles)
    {
        if (!is_string($parcelles) || trim($parcelles) === '') {
            return null;
        }
        $ids = array_map('trim', explode(',', $parcelles));
        foreach ($ids as $id) {
            if (!preg_match(self::PARCELLE_ID_PATTERN, $id)) {
                return null;
            }
        }

        return $ids;
    }

    /**
     * Parse and validate a comma separated list of ids of objects selected in the spatial search.
     *
     * @param null|string $ids The ids of the objects, separated by commas
     *
     * @return null|array The ids, or null if the list is empty or if one id is not valid
     */
    public static function parseObjectIds($ids)
    {
        if (!is_string($ids) || trim($ids) === '') {
            return null;
        }
        $result = array_map('trim', explode(',', $ids));
        foreach ($result as $id) {
            if (!preg_match(self::OBJECT_ID_PATTERN, $id)) {
                return null;
            }
        }

        return $result;
    }

    /**
     * Get the SQL list of the parcelle ids, to be used in an IN clause.
     *
     * The ids are checked again here, so that no SQL query can be built with an invalid id.
     *
     * @param array $parcelle_ids The ids of the parcelles
     *
     * @return string The quoted ids, separated by commas
     *
     * @throws Exception if an id is not valid
     */
    protected function getParcelleIdsSql($parcelle_ids)
    {
        foreach ($parcelle_ids as $id) {
            if (!is_string($id) || !preg_match(self::PARCELLE_ID_PATTERN, $id)) {
                throw new Exception('Invalid parcelle id');
            }
        }

        return $this->getQuotedValuesSql($parcelle_ids);
    }

    /**
     * Get the SQL list of quoted values, to be used in an IN clause.
     *
     * @param array $values The values
     *
     * @return string The quoted values, separated by commas
     */
    protected function getQuotedValuesSql($values)
    {
        $cnx = jDb::getConnection($this->profile);
        $quoted = array();
        foreach ($values as $value) {
            $quoted[] = $cnx->quote((string) $value);
        }

        return implode(', ', $quoted);
    }

    /**
     * Quote a schema, table or field name, read from the QGIS project.
     *
     * @param string $name The name
     *
     * @return string The name between double quotes
     */
    protected function quoteIdentifier($name)
    {
        return '"' . str_replace('"', '""', (string) $name) . '"';
    }

    /**
     * Get the SQL conditions of the parcelle layer: filter by login, SQL filter of the layer and filter by polygon.
     *
     * @return string The conditions, each one beginning with AND, or an empty string
     */
    protected function getLayerFiltersSql()
    {
        $sql = '';
        $filterConfig = cadastreConfig::getFilterByLogin($this->repository, $this->project, $this->config->parcelle->id);
        $layerSql = cadastreConfig::getLayerSql($this->repository, $this->project, $this->config->parcelle->id);
        $polygonFilter = cadastreConfig::getPolygonFilter($this->repository, $this->project, $this->config->parcelle->id);

        if ($filterConfig !== null) {
            $sql .= ' AND ';
            $sql .= $this->getFilterSql($filterConfig);
        }
        if ($layerSql) {
            $sql .= ' AND (' . $layerSql . ')';
        }
        if ($polygonFilter) {
            $sql .= ' AND (' . $polygonFilter . ')';
        }

        return $sql;
    }

    /**
     * Get the parcelles the user can see among the given ones, with the filters of the parcelle layer.
     *
     * @param array $parcelle_ids The ids of the parcelles, already validated
     *
     * @return array The ids of the parcelles the user can see
     */
    protected function getFilteredParcelleIds($parcelle_ids)
    {
        $sql = 'SELECT geo_parcelle FROM parcelle_info WHERE geo_parcelle IN ( ' . $this->getParcelleIdsSql($parcelle_ids) . ' )';
        $sql .= $this->getLayerFiltersSql();
        $ids = array();
        foreach ($this->query($sql, array(), $this->profile) as $row) {
            $ids[] = $row->geo_parcelle;
        }

        return $ids;
    }

    /**
     * Check if the QGIS plugin cadastre of QGIS Server has the request GetExport.
     *
     * @param object $p The Lizmap project
     *
     * @return bool True if the exports can be done by the plugin
     */
    protected function hasPluginExport($p)
    {
        $request = new lizmapCadastreRequest(
            $p,
            array(
                'service' => 'CADASTRE',
                'version' => '1.0.0',
                'request' => 'GetCapabilities',
            )
        );
        $result = $request->process();
        if ($result->code != 200) {
            return false;
        }
        $capabilities = json_decode($result->data);

        return $capabilities
            && isset($capabilities->data->requests)
            && in_array('GetExport', $capabilities->data->requests);
    }

    /**
     * Get the rows of an export from the QGIS plugin cadastre, request GetExport.
     *
     * @param object     $p                The Lizmap project
     * @param string     $type             The type of export: locaux or proprietaires
     * @param array      $parcelle_ids     The ids of the parcelles the user can see
     * @param bool       $forThirdParty    Without the birth data, which are masked
     * @param null|array $intersectionData The objects selected by the spatial search (optional)
     *
     * @return array The rows, as objects with the names of the columns as properties
     *
     * @throws Exception if the plugin did not return the export
     */
    protected function getPluginExportRows($p, $type, $parcelle_ids, $forThirdParty, $intersectionData = null)
    {
        if (count($parcelle_ids) == 0) {
            return array();
        }
        $params = array(
            'service' => 'CADASTRE',
            'version' => '1.0.0',
            'request' => 'GetExport',
            'layer' => $this->config->parcelle->name,
            'type' => $type,
            'parcelles' => implode(',', $parcelle_ids),
            'birth' => $forThirdParty ? '0' : '1',
        );
        if ($intersectionData !== null && is_array($intersectionData)) {
            $params['spatial_layer'] = $intersectionData['layerId'];
            $params['spatial_field'] = $intersectionData['field'];
            $params['spatial_objects'] = implode(',', $intersectionData['selectedIds']);
            $params['spatial_distance'] = $intersectionData['buffer'];
        }

        jClasses::inc('cadastre~lizmapCadastreRequest');
        $request = new lizmapCadastreRequest($p, $params);
        $result = $request->process();
        $data = $result->data;
        if ($result->code != 200 || !is_object($data) || $data->status !== 'success') {
            throw new Exception('Cadastre - GetExport error: ' . (is_object($data) ? $data->message : $result->code));
        }

        $rows = array();
        foreach ($data->data->rows as $row) {
            $rows[] = (object) array_combine($data->data->columns, $row);
        }

        return $rows;
    }

    /**
     * Get the rows of an export: from the QGIS plugin if it can, otherwise with the SQL queries of the module.
     *
     * The plugin is used for the parcelles the user can see, and gives the same columns and values.
     *
     * @param string     $type             The type of export: locaux or proprietaires
     * @param array      $parcelle_ids     The ids of parcelles
     * @param bool       $withGeom         With geometry data, only with the SQL queries of the module
     * @param bool       $forThirdParty    Without infos for third party
     * @param null|array $intersectionData The objects selected by the spatial search (optional)
     *
     * @return array The rows
     */
    protected function getExportRows($type, $parcelle_ids, $withGeom, $forThirdParty, $intersectionData = null)
    {
        $p = lizmap::getProject($this->repository . '~' . $this->project);
        jClasses::inc('cadastre~lizmapCadastreRequest');
        if (!$withGeom && $p && $this->hasPluginExport($p)) {
            try {
                $ids = $this->getFilteredParcelleIds($parcelle_ids);

                return $this->getPluginExportRows($p, $type, $ids, $forThirdParty, $intersectionData);
            } catch (Exception $e) {
                // Use the SQL queries of the module
                jLog::logEx($e, 'error');
            }
        }

        if ($type == 'locaux') {
            $sql = $this->getLocauxAndProprioSql($parcelle_ids, $withGeom, $forThirdParty);
        } else {
            $sql = $this->getParcellesAndProprioSql($parcelle_ids, $withGeom, $forThirdParty, $intersectionData);
        }

        return $this->query($sql, array(), $this->profile);
    }

    /**
     * Get SQL request to get locaux and proprios data for parcelle ids.
     *
     * @param array $parcelle_ids  The ids of parcelles
     * @param bool  $withGeom      With geometry data (optional)
     * @param bool  $forThirdParty Without infos for third party (optional)
     *
     * @return string The SQL
     */
    protected function getLocauxAndProprioSql($parcelle_ids, $withGeom = false, $forThirdParty = false)
    {
        $sql = "
        --SET SEARCH_PATH TO cadastre_caen, public;

        SELECT
            p.parcelle,
            -- identification
            l.dnubat AS l_batiment,
            l.descr AS l_numero_entree,
            l.dniv AS l_niveau_etage,
            l.dpor AS l_numero_local,
            l.invar AS l_invariant,
            (l.dnubat || '-' || l.descr || '-' || l.dniv || '-' || l.dpor) AS l_identifiant,

            -- adresse
            -- the index of repetition and the nature of the street are optional
            ltrim(l.dnvoiri, '0') || coalesce(l.dindic, '') AS l_numero_voirie,
            CASE WHEN v.libvoi IS NOT NULL THEN coalesce(v.natvoi || ' ', '') || v.libvoi ELSE p.cconvo || ' ' || p.dvoilib END AS l_adresse,

            -- local
            (l10.ccodep || l10.ccocom || '-' ||l10.dnupro) AS l10_compte_proprietaire,
            l10.dteloc AS l10_type_local,
            dteloc_lib AS l10_type_local_lib,
            l10.cconlc AS l10_nature_local,
            cconlc_lib AS l10_nature_local_lib,
            l10.ccoplc AS l10_nature_construction_particuliere,
            ccoplc_lib AS l10_nature_construction_particuliere_lib,
            l10.jannat AS l10_annee_construction,
            l10.dnbniv AS l10_nombre_niveaux,
            l10.dnatlc AS l10_nature_occupation,
            dnatlc_lib AS l10_nature_occupation_lib,

            -- proprio et acte
            pr.dnulp AS p_ordre,
            pr.dnuper AS p_numero,
            trim(coalesce(pr.dqualp, '')) || ' ' ||
                CASE WHEN trim(pr.dnomus) != trim(pr.dnomlp) THEN Coalesce( trim(pr.dnomus) || '/' || trim(pr.dprnus) || ', née ', '' ) ELSE '' END ||
                trim(coalesce(pr.ddenom, ''))
                    AS p_nom,
            -- the lines 4 to 6 of the address separated by spaces, without the empty ones
            concat_ws(
                ' ',
                nullif(ltrim(trim(pr.dlign4), '0'), ''), nullif(trim(pr.dlign5), ''), nullif(trim(pr.dlign6), '')
            ) AS p_adresse,
        ";
        // Birth data, masked like in the fiche parcellaire without the right to see them
        if (!$forThirdParty) {
            $sql .= "
            coalesce( trim(cast(pr.jdatnss AS text) ), '-') AS p_date_naissance,
            coalesce(trim(pr.dldnss), '-') AS p_lieu_naissance,
            ";
        } else {
            $sql .= "
            'XX/XX/XXXX' AS p_date_naissance,
            'XXX' AS p_lieu_naissance,
            ";
        }
        $sql .= "
            pr.ccodro AS p_code_droit,
            coalesce(ccodro_lib, '') AS p_code_droit_lib,
            pr.ccodem AS p_code_demembrement,
            coalesce(ccodem_lib, '') AS p_code_demembrement_lib
        ";

        if ($withGeom) {
            $sql .= ',
                -- geometrie
                ST_Centroid(geom)::geometry(point,2154) AS geom
            ';
        }

        $sql .= '
        FROM parcelle p
            INNER JOIN parcelle_info gp ON gp.geo_parcelle = p.parcelle
            INNER JOIN local00 l ON l.parcelle = p.parcelle
            INNER JOIN local10 l10 ON l10.local00 = l.local00
            LEFT JOIN voie v
                ON SUBSTR(l.voie, 1, 6) || SUBSTR(l.voie, 12, 4) = SUBSTR(v.voie, 1, 6) || SUBSTR(v.voie, 12, 4)
            LEFT JOIN dteloc ON l10.dteloc = dteloc.dteloc
            LEFT JOIN cconlc ON l10.cconlc = cconlc.cconlc
            LEFT JOIN ccoplc ON l10.ccoplc = ccoplc.ccoplc
            LEFT JOIN dnatlc ON l10.dnatlc = dnatlc.dnatlc
            LEFT JOIN proprietaire AS pr ON pr.comptecommunal = l10.comptecommunal
            LEFT JOIN ccodro c2 ON pr.ccodro = c2.ccodro
            LEFT JOIN ccodem c3 ON pr.ccodem = c3.ccodem
        ';

        $sql .= '
        WHERE
            p.parcelle IN ( ' . $this->getParcelleIdsSql($parcelle_ids) . ' )
        ';

        $sql .= $this->getLayerFiltersSql();

        return $sql;
    }

    /**
     * Get SQL request to get parcelles and proprios data for parcelle ids.
     *
     * @param array      $parcelle_ids     The ids of parcelles
     * @param bool       $withGeom         With geometry data (optional)
     * @param bool       $forThirdParty    Without infos for third party (optional)
     * @param null|array $intersectionData If the query must compute list of item codes from the intersected layer
     *
     * @return string The SQL
     */
    protected function getParcellesAndProprioSql($parcelle_ids, $withGeom = false, $forThirdParty = false, $intersectionData = null)
    {
        $hasIntersectionData = ($intersectionData !== null && is_array($intersectionData));

        $sql = "
        --SET SEARCH_PATH TO cadastre_caen, public;

        SELECT
            -- commune
            c.libcom AS commune,
            -- proprio
            pr.dnuper AS code_proprietaire,
            trim(pr.dqualp) AS qualite,
            trim(pr.dnomus) AS nom,
            trim(pr.dprnus) AS prenom,
            -- on ne garde que le nom d'usage
            --trim(pr.dnomlp) AS nom,
            --trim(pr.dprnlp) AS prenom,
            trim(pr.ddenom) AS denomination,

            -- adresse du propriétaire
            ltrim(trim(coalesce(pr.dlign4, '')), '0') AS adresse,
            trim(coalesce(pr.dlign5, '')) AS complement_adresse,
            trim(coalesce(pr.ccopos, '')) AS code_postal,
            replace(
                trim(coalesce(pr.dlign6, '')),
                trim(coalesce(pr.ccopos, '')),
                ''
            ) AS ville,
            replace(
                ltrim(trim(coalesce(pr.dlign4, ' ')), '0') || ' ' || trim(coalesce(pr.dlign5, ' ')) || ' ' || trim(coalesce(pr.dlign6, ' ')),
                '  ',
                ' '
            ) AS adresse_complete,
        ";

        // Ajout des informations de naissance, masquées sans le droit comme dans la fiche parcellaire
        if (!$forThirdParty) {
            $sql .= "
                coalesce( trim(cast(pr.jdatnss AS text) ), '-') AS date_naissance,
                coalesce(trim(pr.dldnss), '-') AS lieu_naissance,
                ";
        } else {
            $sql .= "
                'XX/XX/XXXX' AS date_naissance,
                'XXX' AS lieu_naissance,
                ";
        }
        $sql .= "
            -- parcelles
            string_agg(DISTINCT p.parcelle, ', ' ORDER BY p.parcelle) AS parcelles
        ";

        // Ajout de la géométrie
        if ($withGeom) {
            $sql .= ',
                -- geometrie
                ST_Centroid(geom)::geometry(point,2154) AS geom
            ';
        }

        // Ajout des objets intersectés
        // Ceux qui ont été sélectionnés dans l'onglet "Recherche spatiale"
        // du panneau de recherche
        if ($hasIntersectionData) {
            $field = $this->quoteIdentifier($intersectionData['field']);
            $sql .= '
            -- Code objet
            ,
            string_agg(DISTINCT z.' . $field . '::text, \', \' ORDER BY z.' . $field . '::text)
            FILTER (WHERE z.' . $field . ' IS NOT NULL) AS code_objet
            ';
        }

        $sql .= '
        FROM parcelle p
        INNER JOIN parcelle_info gp ON gp.geo_parcelle = p.parcelle
        LEFT JOIN proprietaire AS pr ON pr.comptecommunal = p.comptecommunal
        LEFT JOIN commune AS c ON c.commune = concat(pr.ccodep, pr.ccodir, pr.ccocom)
        ';

        // Ajout des objets intersectés
        // Ceux qui ont été sélectionnés dans l'onglet "Recherche spatiale"
        // du panneau de recherche
        if ($hasIntersectionData) {
            $sql .= '
            -- Code objet
            LEFT JOIN ' . $this->quoteIdentifier($intersectionData['schema']) . '.' . $this->quoteIdentifier($intersectionData['table']) . ' AS z
            ON z.' . $this->quoteIdentifier($intersectionData['pk']) . ' IN (' . $this->getQuotedValuesSql($intersectionData['selectedIds']) . ')
            AND ST_DWithin(z.' . $this->quoteIdentifier($intersectionData['geometryColumn']) . ', gp.geom, ' . (int) $intersectionData['buffer'] . ')
            ';
        }

        $sql .= '
        WHERE
            p.parcelle IN ( ' . $this->getParcelleIdsSql($parcelle_ids) . ' )
        ';

        // Questions
        // Seulement le principal ou les usufruitiers ?
        // Seulement les peronnes physiques ou tout le monde ?

        $sql .= $this->getLayerFiltersSql();

        // Regroupement par propriétaire
        $sql .= '
        GROUP BY
            c.libcom,
            pr.dnuper, pr.dqualp,
            pr.dnomus, pr.dprnus,
            -- pr.dnomlp, pr.dprnlp,
            pr.ddenom,
            pr.dlign4, pr.dlign5, pr.dlign6, pr.ccopos
            ';
        if (!$forThirdParty) {
            $sql .= '
            , pr.jdatnss, pr.dldnss
            ';
        }
        if ($withGeom) {
            $sql .= ',
            , geom
            ';
        }

        $sql .= '
        ORDER BY c.libcom, pr.ddenom
        ';

        return $sql;
    }

    /**
     * Get data from database and return an array.
     *
     * @param string     $sql          Query to run
     * @param null|array $filterParams
     * @param string     $profile      Name of the DB profile
     *
     * @return array Result as an array
     */
    protected function query($sql, $filterParams, $profile = 'cadastre')
    {
        $cnx = jDb::getConnection($profile);
        $resultset = $cnx->prepare($sql);

        $resultset->execute($filterParams);

        return $resultset->fetchAll();
    }

    /**
     * Build CSV file and return its path.
     *
     * @param array $rows The rows to write to CSV
     *
     * @return string The CSV file path
     */
    protected function buildCsv($rows)
    {
        $path = tempnam(sys_get_temp_dir(), 'cadastre_' . session_id() . '_');

        $fd = fopen($path, 'w');
        $headers = array_keys((array) reset($rows));
        if (count($headers) < 2) {
            $headers = array('Aucun local pour ces parcelles');
        }
        fputcsv($fd, $headers);
        foreach ($rows as $row) {
            fputcsv($fd, (array) $row);
        }
        fclose($fd);

        return $path;
    }

    /** @var string */
    protected $repository;

    /** @var string */
    protected $project;

    /** @var object */
    protected $config;

    /** @var string Name of the database profile of the parcelle layer */
    protected $profile = 'cadastre';

    /**
     * Build the locaux and proprios CSV file and return its path.
     *
     * @param string $repository
     * @param string $project
     * @param mixed  $parcelleLayer
     * @param array  $parcelle_ids  The ids of parcelles
     * @param bool   $withGeom      With geometry data (optional)
     * @param bool   $forThirdParty Without infos for third party (optional)
     *
     * @return string The CSV file path
     */
    public function getLocauxAndProprioInfos($repository, $project, $parcelleLayer, $parcelle_ids, $withGeom = false, $forThirdParty = false)
    {
        $this->repository = $repository;
        $this->project = $project;
        $this->config = cadastreConfig::get($repository, $project);

        $profile = cadastreProfile::get($repository, $project, $parcelleLayer);
        $this->profile = $profile;
        $rows = $this->getExportRows('locaux', $parcelle_ids, $withGeom, $forThirdParty);

        return $this->buildCsv($rows);
    }

    /**
     * Build the parcelles and proprios CSV file and return its path.
     *
     * @param string     $repository
     * @param string     $project
     * @param mixed      $parcelleLayer
     * @param array      $parcelle_ids     The ids of parcelles
     * @param bool       $withGeom         With geometry data (optional)
     * @param bool       $forThirdParty    Without infos for third party (optional)
     * @param null|array $intersectionData Array containing needed parameters used to get intersected layer data
     *
     * @return string The CSV file path
     */
    public function getParcellesAndProprioInfos($repository, $project, $parcelleLayer, $parcelle_ids, $withGeom = false, $forThirdParty = false, $intersectionData = null)
    {
        $this->repository = $repository;
        $this->project = $project;
        $this->config = cadastreConfig::get($repository, $project);
        $profile = cadastreProfile::get($repository, $project, $parcelleLayer);
        $this->profile = $profile;
        $rows = $this->getExportRows('proprietaires', $parcelle_ids, $withGeom, $forThirdParty, $intersectionData);

        return $this->buildCsv($rows);
    }
}
