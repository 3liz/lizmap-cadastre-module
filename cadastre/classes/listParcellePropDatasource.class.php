<?php

class listParcellePropDatasource extends jFormsDynamicDatasource
{
    protected $selector = 'cadastre~parcelle_info';
    protected $method = 'findByConditions';

    protected $labelProperty = array('name');
    protected $labelSeparator;
    public $labelMethod = 'get';
    protected $keyProperty = 'ogc_fid';
    protected $valueProperty = 'geo_parcelle';

    protected $profile;
    protected $dao;

    public function __construct($formid) {}

    public function getData($form)
    {
        if (!jAcl2::check('cadastre.acces.donnees.proprio') && !jAcl2::check('cadastre.acces.donnees.proprio.simple')) {
            return array();
        }
        $repository = $form->getData($this->criteriaFrom[0]);
        $project = $form->getData($this->criteriaFrom[1]);
        $layerId = $form->getData($this->criteriaFrom[2]);
        $commune = $form->getData($this->criteriaFrom[3]);
        $comptecommunal = $form->getData($this->criteriaFrom[4]);
        $compte = $form->getData($this->criteriaFrom[5]);

        if (empty($commune) && empty($comptecommunal)) {
            return array();
        }

        if (!empty($commune) && !empty($comptecommunal
            && substr($comptecommunal, 0, 6) !== $commune)) {
            return array();
        }

        if (!empty($commune) && !empty($compte)) {
            $comptecommunal = $commune . $compte;
        }

        if (empty($comptecommunal)) {
            return array();
        }
        $comptescommunaux = explode(',', $comptecommunal);
        $comptescommunaux = array_map('trim', $comptescommunaux);

        $this->profile = cadastreProfile::getWithLayerId($repository, $project, $layerId);

        if ($this->dao === null) {
            $this->dao = jDao::get($this->selector, $this->profile);
        }

        $searchConditions = jDao::createConditions();
        $searchConditions->addCondition('comptecommunal', 'IN', $comptescommunaux);

        $config = cadastreConfig::get($repository, $project);
        $layerConditions = null;
        $layerSql = cadastreConfig::getLayerSql($repository, $project, $config->parcelle->id);
        $polygonFilter = cadastreConfig::getPolygonFilter($repository, $project, $config->parcelle->id);
        $loginFilter = cadastreConfig::getLoginFilter($repository, $project, $config->parcelle->id);
        $layerFilters = array();
        if ($layerSql !== null) {
            $layerFilters[] = $layerSql;
        }
        if ($polygonFilter !== null) {
            $layerFilters[] = $polygonFilter;
        }
        if ($loginFilter !== null) {
            $layerFilters[] = $loginFilter;
        }
        if (count($layerFilters) != 0) {
            if (count($layerFilters) == 1) {
                $layerConditions = $layerFilters[0];
            } else {
                $layerConditions = '(' . implode(') AND (', $layerFilters) . ')';
            }
        }

        foreach ((array) $this->labelProperty as $property) {
            $searchConditions->addItemOrder($property, 'asc');
        }

        $found = $this->dao->{$this->method}($layerConditions, $searchConditions);

        $result = array();

        foreach ($found as $obj) {
            $label = $this->buildLabel($obj);
            $value = $obj->{$this->valueProperty};

            $result[$value] = $label;
        }

        return $result;
    }

    public function getLabel2($key, $form)
    {
        if ($key === null || $key == '') {
            return null;
        }

        $repository = $form->getData($this->criteriaFrom[0]);
        $project = $form->getData($this->criteriaFrom[1]);
        $layerId = $form->getData($this->criteriaFrom[2]);
        $this->profile = cadastreProfile::getWithLayerId($repository, $project, $layerId);

        if ($this->dao === null) {
            $this->dao = jDao::get($this->selector, $this->profile);
        }

        $method = $this->labelMethod;

        $rec = $this->dao->{$method}($key);

        if ($rec) {
            return $this->buildLabel($rec);
        }

        return null;
    }

    protected function buildLabel($rec)
    {
        $label = '';
        foreach ((array) $this->labelProperty as $property) {
            if ((string) $rec->{$property} !== '') {
                $label .= $rec->{$property} . $this->labelSeparator;
            }
        }
        if ($this->labelSeparator != '') {
            $label = substr($label, 0, -strlen($this->labelSeparator));
        }

        return $label;
    }

    public function setCriteriaControls($criteriaFrom = null)
    {
        if (count($criteriaFrom) !== 6) {
            throw new Exception('6 criterias needed: repository, project, parcelleLayerId, commune_prop, comptecommunal, compte');
        }
        $this->criteriaFrom = $criteriaFrom;
    }
}
