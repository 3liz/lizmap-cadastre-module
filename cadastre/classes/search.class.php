<?php
/**
* @package   lizmap
* @subpackage cadastre
* @author    Michael Douchin
* @copyright 2018 3liz
* @link      http://3liz.com
* @license    Mozilla Public Licence
*/

class search {

    // search terms
    protected $terms = array();

    // field, which means, what to search
    protected $field = 'voie';

    // commune filter
    protected $commune = '';

    // voie filter
    protected $voie = '';


    private function normalizeString($string){
        $in = array('à','á','â','ã','ä', 'ç', 'è','é','ê','ë', 'ì','í','î','ï', 'ñ', 'ò','ó','ô','õ','ö','œ','ù','ú','û','ü', 'ý','ÿ', 'À','Á','Â','Ã','Ä', 'Ç', 'È','É','Ê','Ë', 'Ì','Í','Î','Ï', 'Ñ', 'Ò','Ó','Ô','Õ','Ö', 'Ù','Ú','Û','Ü', 'Ý' );
        $out= array('a','a','a','a','a', 'c', 'e','e','e','e', 'i','i','i','i', 'n', 'o','o','o','o','o','oe','u','u','u','u', 'y','y', 'A','A','A','A','A', 'C', 'E','E','E','E', 'I','I','I','I', 'N', 'O','O','O','O','O', 'U','U','U','U', 'Y' );
        return strtoupper(trim(str_replace($in, $out, $string)));
    }

    protected function getSql() {
        if($this->field == 'voie'){
            $sql = "
            SELECT DISTINCT
                v.voie AS code,
                trim(concat(
                    trim(c.tex2), ' - ',
                    Coalesce(trim(natvoi) || ' ', ''),
                    trim(libvoi)
                )) AS label,
                trim(libvoi) ~ '^" . $this->terms[0] . "' AS b
            FROM voie v
            INNER JOIN geo_commune c ON c.commune = v.commune
            WHERE 2>1
            ";
            $i = 1;
            foreach($this->terms as $term){
                $sql.= " AND libvoi LIKE $" . $i;
                $i++;
            }
            if(!empty($this->commune)){
                $sql.=" AND trim(c.geo_commune) = $" . $i;
                $i++;
            }
            $sql.= "
            ORDER BY b DESC, label
            ";
            // limit
            $sql.= " LIMIT $" . $i;
        }
        elseif($this->field == 'prop'){
            $sql = "
            SELECT trim(ddenom) AS label, string_agg(comptecommunal, ',') AS code, dnuper,
            trim(ddenom) ~ '^" . $this->terms[0] . "' AS b
            FROM proprietaire p
            ";
            $sql.= "
            WHERE 2>1
            ";

            $i=1;
            foreach($this->terms as $term){
                $sql.= " AND ddenom LIKE $" . $i;
                $i++;
            }

            if(!empty($this->voie)){
                $sql.=" AND trim(p.comptecommunal) IN (SELECT DISTINCT comptecommunal FROM parcelle_info WHERE voie = $" . $i . ")";
                $i++;
            }
            if(!empty($this->commune)){
                $sql.=" AND trim(p.comptecommunal) IN (SELECT DISTINCT comptecommunal FROM parcelle_info WHERE geo_parcelle LIKE $" . $i . ")";
                $i++;
            }
            $sql.= "
            GROUP BY dnuper, ddenom, dlign4
            ORDER BY b DESC, ddenom
            ";
            // limit
            $sql.= " LIMIT $" . $i;
        }
        else{
            $sql = Null;
        }
//jLog::log($sql);
        return $sql;
    }

    /**
    * Get data from database and return an array
    * @param $sql Query to run
    * @param $profile Name of the DB profile
    * @return Result as an array
    */
    function query( $sql, $filterParams, $profile='cadastre' ) {
        $cnx = jDb::getConnection( $profile );
        $resultset = $cnx->prepare( $sql );

        $resultset->execute( $filterParams );
        return $resultset->fetchAll();
    }

    /**
    * Method called by the autocomplete input field for taxon search
    * @param $term Searched term
    * @return List of matching taxons
    */
    function getData($term, $field="voie", $commune='', $voie='', $limit=15, $get_total_extent=False) {

        // Access control
        if( $field != 'voie' and !jAcl2::check("cadastre.acces.donnees.proprio") ){
            return Null;
        }

        // Array to use on the prepared statement
        $pa = array();

        // Search term : explode into words
        $term = $this->normalizeString($term);
        $terms = explode(' ', $term);

        $stopwords = array('ALLEE', 'AQUEDUC', 'ARCEAUX', 'AVENUE', 'AVENUES', 'BOULEVARD', 'CARREFOUR', 'CARRER', 'CHEMIN', 'CHEMINS', 'CHEMIN RURAL', 'CLOS', 'COUR', 'COURS', 'DESCENTE', 'ENCLOS', 'ESCALIER', 'ESPACE', 'ESPLANADE', 'GRAND RUE', 'IMPASSE', 'MAIL', 'MONTEE', 'PARVIS', 'PASSAGE', 'PASSERELLE', 'PLACE', 'PLAN', 'PONT', 'QUAI', 'ROND-POINT', 'ROUTE', 'RUE', 'RUISSEAU', 'SENTE', 'SENTIER', 'SQUARE', 'TERRASSE', 'TRABOULE', 'TRAVERSE', 'TRAVERSEE', 'TRAVERSIER', 'TUNNEL', 'VOIE', 'VOIE COMMUNALE', 'VIADUC', 'ZONE',
            'ACH', 'ALL', 'ANGL', 'ART', 'AV', 'AVE', 'BD', 'BV', 'CAMP', 'CAR', 'CC', 'CD', 'CH', 'CHE', 'CHEM', 'CHS ', 'CHV', 'CITE', 'CLOS', 'COTE', 'COUR', 'CPG', 'CR', 'CRS', 'CRX', 'D', 'DIG', 'DOM', 'ECL', 'ESC', 'ESP', 'FG', 'FOS', 'FRM', 'GARE', 'GPL', 'GR', 'HAM', 'HLE', 'HLM ', 'IMP', 'JTE ', 'LOT', 'MAIL', 'MAIS', 'N', 'PARC', 'PAS', 'PCH', 'PL', 'PLE ', 'PONT', 'PORT', 'PROM', 'PRV', 'PTA', 'PTE', 'PTR', 'PTTE', 'QUA', 'QUAI', 'REM', 'RES', 'RIVE', 'RLE', 'ROC', 'RPE ', 'RPT ', 'RTE ', 'RUE', 'RULT', 'SEN', 'SQ', 'TOUR', 'TSSE', 'VAL', 'VC', 'VEN', 'VLA', 'VOIE', 'VOIR', 'VOY', 'ZONE'
        );
        if($field == 'prop')
            $stopwords = array();

        foreach($terms as $t){
            $term = trim($t);
            if( in_array($term, $stopwords) )
                continue;
            $pa[] = '%' . $term . '%';
            $this->terms[] = $term;
        }

        // Search field
        $this->field = $field;

        // Commune
        $this->commune = trim($commune);
        if(!empty($this->commune)){
            $pco = trim($commune);
            if($field == 'prop')
                $pco.='%';
            $pa[] = $pco;
        }

        // Voie
        $this->voie = trim($voie);
        if($field == 'prop' and !empty($this->voie))
            $pa[] = trim($voie);

        // Limit
        $pa[] = $limit;

        // Get only grouped geom extent
        $this->get_total_extent = $get_total_extent;

        // Run query
        $sql = $this->getSql();
        if(!$sql)
            return Null;

        return $this->query( $sql, $pa );
    }

    /**
    * Method called by the autocomplete input field
    * @param $term Searched term
    * @return List of matching taxons
    */
    function getDataExtent($field="voie", $value='') {

        // Access control
        if( $field != 'voie' and !jAcl2::check("cadastre.acces.donnees.proprio") ){
            return Null;
        }

        // Array to use on the prepared statement
        $pa = array();

        // Search field
        $this->field = $field;

        // Voie
        if($field == 'voie')
            $pa[] = trim($value);

        if($field == 'prop')
            $pa[] = trim($value);

        // Get only grouped geometries
        if( $this->field == 'voie'){
            $sql = "
            SELECT ST_AsGeojson(ST_Envelope(ST_Extent(ST_Transform(geom,4326)))) as geom
            FROM parcelle_info p
            WHERE p.voie = $1
            ";
        }
        if( $this->field == 'prop'){
            $sql = "
            SELECT ST_AsGeojson(ST_Envelope(ST_Extent(ST_Transform(geom,4326)))) AS geom
            FROM parcelle_info p
            WHERE p.comptecommunal = ANY (string_to_array($1, ','))
            ";
        }

        // Run query
        return $this->query( $sql, $pa );
    }

}
