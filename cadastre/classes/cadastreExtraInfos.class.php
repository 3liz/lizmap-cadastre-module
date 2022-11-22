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
     * @param array $parcelle_ids The ids of parcelles
     * @param boolean $withGeom With geometry data (optional)
     *
     * @return string The SQL
     */
    protected function getLocauxAndProprioSql($parcelle_ids, $withGeom = false)
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
            CASE WHEN v.libvoi IS NOT NULL THEN v.natvoi || v.libvoi ELSE p.cconvo || p.dvoilib END AS l_adresse,

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
            Coalesce( trim(cast(pr.jdatnss AS text) ), '-') AS p_date_naissance,
            coalesce(trim(pr.dldnss), '-') AS p_lieu_naissance,
            pr.ccodro AS p_code_droit,
            Coalesce(ccodro_lib, '') AS p_code_droit_lib,
            pr.ccodem AS p_code_demembrement,
            Coalesce(ccodem_lib, '') AS p_code_demembrement_lib
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
            LEFT JOIN voie v ON v.voie = l.voie
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
        $condition = cadastreConfig::getLayerSql($this->repository, $this->project, $this->config->parcelle->id);

        if ($filterConfig !== null) {
            $sql .= ' AND ';
            $sql .= $this->getFilterSql($filterConfig);
        }
        if ($condition) {
            $sql .= ' AND (' . $condition . ')';
        }

        return $sql;
    }

    /**
     * Get data from database and return an array.
     *
     * @param string $sql Query to run
     * @param array|null $filterParams
     * @param string $profile Name of the DB profile
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
        fputcsv($fd, array_keys((array) reset($rows)));
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
     * @param mixed $parcelleLayer
     * @param array $parcelle_ids The ids of parcelles
     * @param boolean $withGeom With geometry data (optional)
     *
     * @return string The CSV file path
     */
    public function getLocauxAndProprioInfos($repository, $project, $parcelleLayer, $parcelle_ids, $withGeom = false)
    {
        $this->repository = $repository;
        $this->project = $project;
        $this->config = cadastreConfig::get($repository, $project);

        $sql = $this->getLocauxAndProprioSql($parcelle_ids, $withGeom);

        $profile = cadastreProfile::get($repository, $project, $parcelleLayer);
        $rows = $this->query($sql, array(), $profile);

        return $this->buildCsv($rows);
    }
}
