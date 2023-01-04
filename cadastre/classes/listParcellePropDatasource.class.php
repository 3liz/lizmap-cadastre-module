<?php

require_once JELIX_LIB_PATH . 'forms/jFormsDatasource.class.php';

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

    public function __construct($formid)
    {
    }

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

        if (!empty($commune) && !empty($compte)) {
            $comptecommunal = $commune . $compte;
        }

        if (empty($comptecommunal)) {
            return array();
        }

        $this->profile = cadastreProfile::getWithLayerId($repository, $project, $layerId);

        if ($this->dao === null) {
            $this->dao = jDao::get($this->selector, $this->profile);
        }

        $searchConditions = jDao::createConditions();
        $searchConditions->addCondition('comptecommunal', '=', $comptecommunal);

        $config = cadastreConfig::get($repository, $project);
        $layerConditions = cadastreConfig::getLayerSql($repository, $project, $config->parcelle->id);
        $fblConfig = cadastreConfig::getFilterByLogin($repository, $project, $config->parcelle->id);

        if ($fblConfig !== null) {
            $filterValues = array('all');
            if (jAuth::isConnected()) {
                if (property_exists($fblConfig, 'filterPrivate') && $fblConfig->filterPrivate == 'True') {
                    $user = jAuth::getUserSession();
                    $filterValues[] = $user->login;
                } else {
                    $filterValues = array_merge($filterValues, jAcl2DbUserGroup::getGroups());
                }
            }
            $searchConditions->addCondition($fblConfig->filterAttribute, 'IN', $filterValues);
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
