<?php
/**
 * @author    Michael Douchin
 *
 * @contributor Laurent Jouanneau
 *
 * @copyright 2018-2020 3liz
 *
 * @see      http://3liz.com
 *
 * @license    Mozilla Public Licence
 */
class search
{
    /** @var string[] search terms */
    protected $terms = array();

    /** @var string field, which means, what to search */
    protected $field = 'voie';

    /** @var string commune filter */
    protected $commune = '';

    /** @var string voie filter */
    protected $voie = '';

    /** @var string comptecommunal filter */
    protected $comptecommunal = '';

    /** @var null cadastre config */
    protected $config;

    protected $repository = '';
    protected $project = '';

    public const STOPWORDS = array('ALLEE', 'AQUEDUC', 'ARCEAUX', 'AVENUE', 'AVENUES',
        'BOULEVARD', 'CARREFOUR', 'CARRER', 'CHEMIN', 'CHEMINS', 'CHEMIN RURAL',
        'CLOS', 'COUR', 'COURS', 'DESCENTE', 'ENCLOS', 'ESCALIER', 'ESPACE',
        'ESPLANADE', 'GRAND RUE', 'IMPASSE', 'MAIL', 'MONTEE', 'PARVIS',
        'PASSAGE', 'PASSERELLE', 'PLACE', 'PLAN', 'PONT', 'QUAI', 'ROND-POINT',
        'ROUTE', 'RUE', 'RUISSEAU', 'SENTE', 'SENTIER', 'SQUARE', 'TERRASSE',
        'TRABOULE', 'TRAVERSE', 'TRAVERSEE', 'TRAVERSIER', 'TUNNEL', 'VOIE',
        'VOIE COMMUNALE', 'VIADUC', 'ZONE',
        'ACH', 'ALL', 'ANGL', 'ART', 'AV', 'AVE', 'BD', 'BV', 'CAMP', 'CAR',
        'CC', 'CD', 'CH', 'CHE', 'CHEM', 'CHS ', 'CHV', 'CITE', 'CLOS', 'COTE',
        'COUR', 'CPG', 'CR', 'CRS', 'CRX', 'D', 'DIG', 'DOM', 'ECL', 'ESC',
        'ESP', 'FG', 'FOS', 'FRM', 'GARE', 'GPL', 'GR', 'HAM', 'HLE', 'HLM ',
        'IMP', 'JTE ', 'LOT', 'MAIL', 'MAIS', 'N', 'PARC', 'PAS', 'PCH', 'PL',
        'PLE ', 'PONT', 'PORT', 'PROM', 'PRV', 'PTA', 'PTE', 'PTR', 'PTTE',
        'QUA', 'QUAI', 'REM', 'RES', 'RIVE', 'RLE', 'ROC', 'RPE ', 'RPT ',
        'RTE ', 'RUE', 'RULT', 'SEN', 'SQ', 'TOUR', 'TSSE', 'VAL', 'VC', 'VEN',
        'VLA', 'VOIE', 'VOIR', 'VOY', 'ZONE',
    );

    private function normalizeString($string)
    {
        $in = array('à', 'á', 'â', 'ã', 'ä', 'ç', 'è', 'é', 'ê', 'ë', 'ì', 'í', 'î', 'ï', 'ñ', 'ò', 'ó', 'ô', 'õ', 'ö', 'œ', 'ù', 'ú', 'û', 'ü', 'ý', 'ÿ', 'À', 'Á', 'Â', 'Ã', 'Ä', 'Ç', 'È', 'É', 'Ê', 'Ë', 'Ì', 'Í', 'Î', 'Ï', 'Ñ', 'Ò', 'Ó', 'Ô', 'Õ', 'Ö', 'Ù', 'Ú', 'Û', 'Ü', 'Ý');
        $out = array('a', 'a', 'a', 'a', 'a', 'c', 'e', 'e', 'e', 'e', 'i', 'i', 'i', 'i', 'n', 'o', 'o', 'o', 'o', 'o', 'oe', 'u', 'u', 'u', 'u', 'y', 'y', 'A', 'A', 'A', 'A', 'A', 'C', 'E', 'E', 'E', 'E', 'I', 'I', 'I', 'I', 'N', 'O', 'O', 'O', 'O', 'O', 'U', 'U', 'U', 'U', 'Y');

        return strtoupper(trim(str_replace($in, $out, $string)));
    }

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

    protected function getSql($profile = 'cadastre')
    {
        $cFilterConfig = cadastreConfig::getFilterByLogin($this->repository, $this->project, $this->config->commune->id);
        $pFilterConfig = cadastreConfig::getFilterByLogin($this->repository, $this->project, $this->config->parcelle->id);

        $cnx = jDb::getConnection($profile);
        $firstTerm = $cnx->quote('^' . $this->terms[0]);

        if ($this->field == 'voie') {
            $sql = "
            SELECT DISTINCT
                v.voie AS code,
                trim(concat(
                    trim(c.tex2), ' - ',
                    Coalesce(trim(natvoi) || ' ', ''),
                    trim(libvoi)
                )) AS label,
                trim(libvoi) ~ " . $firstTerm . ' AS b
            FROM voie v
            INNER JOIN geo_commune c ON c.commune = v.commune
            WHERE 2>1
            ';
            $i = 1;
            foreach ($this->terms as $term) {
                $sql .= ' AND libvoi LIKE $' . $i;
                ++$i;
            }
            if (!empty($this->commune)) {
                $sql .= ' AND trim(c.geo_commune) = $' . $i;
                ++$i;
            }
            if ($cFilterConfig !== null) {
                $sql .= ' AND ';
                $sql .= $this->getFilterSql($cFilterConfig, $profile, 'c');
            }
            $sql .= '
            ORDER BY b DESC, label
            ';
            // limit
            $sql .= ' LIMIT $' . $i;
        } elseif ($this->field == 'prop') {
            $sql = "
            SELECT dnuper || ' - ' || trim(ddenom) AS label, string_agg(comptecommunal, ',') AS code, dnuper,
            (dnuper || ' - ' || trim(ddenom)) ~ " . $firstTerm . ' AS b
            FROM proprietaire p
            ';
            $sql .= '
            WHERE 2>1
            ';

            $i = 1;
            foreach ($this->terms as $term) {
                $sql .= ' AND (ddenom LIKE $' . $i . ' OR dnuper LIKE $' . $i . ')';
                ++$i;
            }

            if (!empty($this->voie)) {
                $sql .= ' AND trim(p.comptecommunal) IN (';
                $sql .= 'SELECT DISTINCT comptecommunal FROM parcelle_info WHERE voie = $' . $i;
                if ($pFilterConfig !== null) {
                    $sql .= ' AND ';
                    $sql .= $this->getFilterSql($pFilterConfig, $profile);
                }
                $sql .= ')';
                ++$i;
            }
            if (!empty($this->commune)) {
                $sql .= ' AND trim(p.comptecommunal) IN (';
                $sql .= 'SELECT DISTINCT comptecommunal FROM parcelle_info WHERE geo_parcelle LIKE $' . $i;
                if ($pFilterConfig !== null) {
                    $sql .= ' AND ';
                    $sql .= $this->getFilterSql($pFilterConfig, $profile);
                }
                $sql .= ')';
                ++$i;
            } elseif ($pFilterConfig !== null) {
                $sql .= ' AND trim(p.comptecommunal) IN (';
                $sql .= 'SELECT DISTINCT comptecommunal FROM parcelle_info WHERE 2>1';
                if ($pFilterConfig !== null) {
                    $sql .= ' AND ';
                    $sql .= $this->getFilterSql($pFilterConfig, $profile);
                }
                $sql .= ')';
            }
            $sql .= '
            GROUP BY dnuper, ddenom, dlign4
            ORDER BY b DESC, ddenom
            ';
            // limit
            $sql .= ' LIMIT $' . $i;
        } elseif ($this->field == 'comp' && !empty($this->commune)) {
            $sql = "
            SELECT trim(dnupro) AS label, string_agg(comptecommunal, ',') AS code,
            " . 'true AS b
            FROM proprietaire p
            ';
            $sql .= '
            WHERE 2>1
            ';

            $i = 1;
            foreach ($this->terms as $term) {
                $sql .= ' AND dnupro LIKE $' . $i;
                ++$i;
            }

            $sql .= ' AND trim(p.comptecommunal) IN (';
            $sql .= 'SELECT DISTINCT comptecommunal FROM parcelle_info WHERE geo_parcelle LIKE $' . $i;
            if ($pFilterConfig !== null) {
                $sql .= ' AND ';
                $sql .= $this->getFilterSql($pFilterConfig, $profile);
            }
            $sql .= ')';
            ++$i;
            if (!empty($this->comptecommunal)) {
                $si = array();
                foreach ($this->comptecommunal as $cc) {
                    $si[] = '$' . $i;
                    ++$i;
                }
                $sql .= ' AND trim(p.comptecommunal) IN (';
                $sql .= implode(', ', $si);
                $sql .= ')';
            }

            $sql .= '
            GROUP BY dnupro
            ORDER BY b DESC, dnupro
            ';
            // limit
            $sql .= ' LIMIT $' . $i;
        } else {
            $sql = null;
        }

        return $sql;
    }

    /**
     * Get data from database and return an array.
     *
     * @param string   $sql          Query to run
     * @param string[] $filterParams parameters for the query
     * @param string   $profile      Name of the DB profile
     *
     * @return object[] Result as an array
     */
    protected function query($sql, $filterParams, $profile = 'cadastre')
    {
        $cnx = jDb::getConnection($profile);
        $resultset = $cnx->prepare($sql);

        $resultset->execute($filterParams);

        return $resultset->fetchAll();
    }

    /**
     * Method called by the autocomplete input field for taxon search.
     *
     * @param string $repository
     * @param string $project
     * @param string $parcelleLayer
     * @param string $term             Searched term
     * @param string $field
     * @param array  $extras           Contains commune, voie and comptecommunal param value
     * @param int    $limit
     * @param bool   $get_total_extent
     *
     * @return null|object[] List of matching taxons
     */
    public function getData($repository, $project, $parcelleLayer, $term, $field = 'voie', $extras = array(), $limit = 15, $get_total_extent = false)
    {
        if ($field != 'voie' && $field != 'prop' && $field != 'comp') {
            return null;
        }

        // Access control
        if ($field != 'voie' && !jAcl2::check('cadastre.acces.donnees.proprio')) {
            return null;
        }

        $commune = '';
        if (array_key_exists('commune', $extras)) {
            $commune = $extras['commune'];
        }
        $voie = '';
        if (array_key_exists('voie', $extras)) {
            $voie = $extras['voie'];
        }
        $comptecommunal = '';
        if (array_key_exists('comptecommunal', $extras)) {
            $comptecommunal = $extras['comptecommunal'];
        }

        $profile = cadastreProfile::get($repository, $project, $parcelleLayer);
        $this->repository = $repository;
        $this->project = $project;
        $this->config = cadastreConfig::get($repository, $project);

        // Array to use on the prepared statement
        $pa = array();

        // Search term : explode into words
        $term = $this->normalizeString($term);
        $terms = explode(' ', $term);

        if ($field == 'prop' || $field == 'comp') {
            $stopwords = array();
        } else {
            $stopwords = self::STOPWORDS;
        }

        foreach ($terms as $t) {
            $term = trim($t);
            if (in_array($term, $stopwords)) {
                continue;
            }
            $pa[] = '%' . $term . '%';
            $this->terms[] = $term;
        }

        if (count($this->terms) == 0) {
            return null;
        }

        // Search field
        $this->field = $field;

        // Commune
        $this->commune = trim($commune);
        if (!empty($this->commune)) {
            $pco = trim($commune);
            if ($field == 'prop' || $field == 'comp') {
                $pco .= '%';
            }
            $pa[] = $pco;
        }

        // Voie
        $this->voie = trim($voie);
        if ($field == 'prop' && !empty($this->voie)) {
            $pa[] = trim($voie);
        }

        // Compte communal
        $this->comptecommunal = trim($comptecommunal);
        if ($field == 'comp' && !empty($this->comptecommunal)) {
            $this->comptecommunal = explode(',', $this->comptecommunal);
            $pa = array_merge($pa, $this->comptecommunal);
        }

        // Limit
        $pa[] = $limit;

        // Get only grouped geom extent
        $this->get_total_extent = $get_total_extent;

        // Run query
        $sql = $this->getSql($profile);
        if (!$sql) {
            return null;
        }

        return $this->query($sql, $pa, $profile);
    }

    /**
     * Method called by the autocomplete input field.
     *
     * @param string $term          Searched term
     * @param mixed  $repository
     * @param mixed  $project
     * @param mixed  $parcelleLayer
     * @param mixed  $field
     * @param mixed  $value
     *
     * @return object[] List of matching taxons
     */
    public function getDataExtent($repository, $project, $parcelleLayer, $field = 'voie', $value = '')
    {
        if ($field != 'voie' && $field != 'prop' && $field != 'comp') {
            return null;
        }

        // Access control
        if ($field != 'voie' && !jAcl2::check('cadastre.acces.donnees.proprio')) {
            return null;
        }

        $profile = cadastreProfile::get($repository, $project, $parcelleLayer);
        $this->repository = $repository;
        $this->project = $project;
        $this->config = cadastreConfig::get($repository, $project);

        $pFilterConfig = cadastreConfig::getFilterByLogin($this->repository, $this->project, $this->config->parcelle->id);

        // Search field
        $this->field = $field;

        // Array to use on the prepared statement
        $pa = array();
        $pa[] = trim($value);

        // Get only grouped geometries
        if ($this->field == 'voie') {
            $sql = '
            SELECT ST_AsGeojson(ST_Envelope(ST_Extent(ST_Transform(geom,4326)))) as geom
            FROM parcelle_info p
            WHERE p.voie = $1
            ';
            if ($pFilterConfig !== null) {
                $sql .= ' AND ';
                $sql .= $this->getFilterSql($pFilterConfig, $profile);
            }
        } else {
            $sql = '
            SELECT ST_AsGeojson(ST_Envelope(ST_Extent(ST_Transform(geom,4326)))) AS geom
            FROM parcelle_info p
            WHERE p.comptecommunal = ANY (string_to_array($1, \',\'))
            ';
            if ($pFilterConfig !== null) {
                $sql .= ' AND ';
                $sql .= $this->getFilterSql($pFilterConfig, $profile);
            }
        }

        // Run query
        return $this->query($sql, $pa, $profile);
    }
}
