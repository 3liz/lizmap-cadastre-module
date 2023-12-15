<?php

require_once JELIX_LIB_PATH . 'forms/jFormsDatasource.class.php';

class listGeoCommuneDatasource extends jFormsDynamicDatasource
{
    protected $selector = 'cadastre~geo_commune';
    protected $method = 'findByConditions';

    protected $labelProperty = array('nom_court');
    protected $labelSeparator;
    public $labelMethod = 'get';
    protected $keyProperty = 'geo_commune';

    protected $profile;
    protected $dao;

    public function __construct($formid)
    {
    }

    public function getData($form)
    {
        $repository = $form->getData($this->criteriaFrom[0]);
        $project = $form->getData($this->criteriaFrom[1]);
        $layerId = $form->getData($this->criteriaFrom[2]);
        $this->profile = cadastreProfile::getWithLayerId($repository, $project, $layerId);

        if ($this->dao === null) {
            $this->dao = jDao::get($this->selector, $this->profile);
        }

        $config = cadastreConfig::get($repository, $project);
        $layerConditions = null;
        $layerSql = cadastreConfig::getLayerSql($repository, $project, $config->commune->id);
        $polygonFilter = cadastreConfig::getPolygonFilter($repository, $project, $config->commune->id);
        $loginFilter = cadastreConfig::getLoginFilter($repository, $project, $config->commune->id);
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

        $searchConditions = jDao::createConditions();
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
        if (count($criteriaFrom) !== 3) {
            throw new Exception('3 criteria needed: repository, project, parcelleLayerId');
        }
        $this->criteriaFrom = $criteriaFrom;
    }
}
