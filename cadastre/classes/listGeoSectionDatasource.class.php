<?php

require_once JELIX_LIB_PATH . 'forms/jFormsDatasource.class.php';

class listGeoSectionDatasource extends jFormsDynamicDatasource
{
    protected $selector = 'cadastre~geo_section';
    protected $method = 'findByConditions';

    protected $labelProperty = array('name');
    protected $labelSeparator;
    public $labelMethod = 'get';
    protected $keyProperty = 'geo_section';

    protected $profile;

    protected $dao;

    public function __construct($formid) {}

    public function getData($form)
    {
        $repository = $form->getData($this->criteriaFrom[0]);
        $project = $form->getData($this->criteriaFrom[1]);
        $layerId = $form->getData($this->criteriaFrom[2]);
        $commune = $form->getData($this->criteriaFrom[3]);

        if (empty($commune)) {
            return array();
        }

        $this->profile = cadastreProfile::getWithLayerId($repository, $project, $layerId);

        if ($this->dao === null) {
            $this->dao = jDao::get($this->selector, $this->profile);
        }

        $searchConditions = jDao::createConditions();
        $searchConditions->addCondition('geo_commune', '=', $commune);

        $config = cadastreConfig::get($repository, $project);
        $layerConditions = null;
        $layerSql = cadastreConfig::getLayerSql($repository, $project, $config->section->id);
        $polygonFilter = cadastreConfig::getPolygonFilter($repository, $project, $config->section->id);
        $loginFilter = cadastreConfig::getLoginFilter($repository, $project, $config->section->id);
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
            $value = $obj->{$this->keyProperty};

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
        if (count($criteriaFrom) !== 4) {
            throw new Exception('4 criteria needed: repository, project, parcelleLayerId, commune');
        }
        $this->criteriaFrom = $criteriaFrom;
    }
}
