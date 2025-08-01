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
            ltrim(l.dnvoiri, '0') || l.dindic AS l_numero_voirie,
            CASE WHEN v.libvoi IS NOT NULL THEN coalesce(v.natvoi || ' ') || v.libvoi ELSE p.cconvo || ' ' || p.dvoilib END AS l_adresse,

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
            ltrim(trim(coalesce(pr.dlign4, '')), '0') || trim(coalesce(pr.dlign5, '')) || ' ' || trim(coalesce(pr.dlign6, '')) AS p_adresse,
        ";
        if (!$forThirdParty) {
            $sql .= "
            coalesce( trim(cast(pr.jdatnss AS text) ), '-') AS p_date_naissance,
            coalesce(trim(pr.dldnss), '-') AS p_lieu_naissance,
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

        $pids = array();
        foreach ($parcelle_ids as $pid) {
            $pids[] = "'" . $pid . "'";
        }

        $sql .= '
        WHERE
            p.parcelle IN ( ' . implode(', ', $pids) . ' )
        ';

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

        // Ajout des informations de naissance
        if (!$forThirdParty) {
            $sql .= "
                coalesce( trim(cast(pr.jdatnss AS text) ), '-') AS date_naissance,
                coalesce(trim(pr.dldnss), '-') AS lieu_naissance,
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
            $sql .= '
            -- Code objet
            ,
            string_agg(DISTINCT z."' . $intersectionData['field'] . '"::text, \', \' ORDER BY z."' . $intersectionData['field'] . '"::text)
            FILTER (WHERE z."' . $intersectionData['field'] . '" IS NOT NULL) AS code_objet
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
            LEFT JOIN "' . $intersectionData['schema'] . '"."' . $intersectionData['table'] . '" AS z
            ON z."' . $intersectionData['pk'] . '" IN (' . $intersectionData['selectedIds'] . ')
            AND ST_DWithin(z."' . $intersectionData['geometryColumn'] . '", gp.geom, ' . $intersectionData['buffer'] . ')
            ';
        }

        $pids = array();
        foreach ($parcelle_ids as $pid) {
            $pids[] = "'" . $pid . "'";
        }

        $sql .= '
        WHERE
            p.parcelle IN ( ' . implode(', ', $pids) . ' )
        ';

        // Questions
        // Seulement le principal ou les usufruitiers ?
        // Seulement les peronnes physiques ou tout le monde ?

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

        $sql = $this->getLocauxAndProprioSql($parcelle_ids, $withGeom, $forThirdParty);

        $profile = cadastreProfile::get($repository, $project, $parcelleLayer);
        $rows = $this->query($sql, array(), $profile);

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
        $sql = $this->getParcellesAndProprioSql($parcelle_ids, $withGeom, $forThirdParty, $intersectionData);

        $profile = cadastreProfile::get($repository, $project, $parcelleLayer);

        $parameters = array();
        $rows = $this->query($sql, $parameters, $profile);

        return $this->buildCsv($rows);
    }
}
