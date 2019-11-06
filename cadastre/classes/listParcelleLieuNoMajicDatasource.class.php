<?php

require_once (JELIX_LIB_PATH.'forms/jFormsDatasource.class.php');

class listParcelleLieuNoMajicDatasource extends jFormsDynamicDatasource
{
    protected $selector = 'cadastre~parcelle_info_no_majic';
    protected $method = 'findBySection';

    protected $labelProperty = array('name');
    protected $labelSeparator;
    public $labelMethod = 'get';
    protected $keyProperty = 'ogc_fid';
    protected $valueProperty = 'geo_parcelle';

    protected $profile;
    protected $dao = null;

    public function __construct($formid) {
    }

    public function getData($form) {
        $repository = $form->getData($this->criteriaFrom[0]);
        $project = $form->getData($this->criteriaFrom[1]);
        $layerId = $form->getData($this->criteriaFrom[2]);
        $section = $form->getData($this->criteriaFrom[3]);
        $this->profile = cadastreProfile::getWithLayerId($repository, $project, $layerId);

        if($this->dao === null)
            $this->dao = jDao::get($this->selector, $this->profile);

        $found = $this->dao->{$this->method}($section);

        $result = array();

        foreach($found as $obj){
            $label = $this->buildLabel($obj);
            $value = $obj->{$this->valueProperty};

            $result[$value] = $label;
        }
        return $result;
    }

    public function getLabel2($key, $form) {
        if ($key === null || $key == "")
            return null;

        $repository = $form->getData($this->criteriaFrom[0]);
        $project = $form->getData($this->criteriaFrom[1]);
        $layerId = $form->getData($this->criteriaFrom[2]);
        $this->profile = cadastreProfile::getWithLayerId($repository, $project, $layerId);

        if($this->dao === null)
            $this->dao = jDao::get($this->selector, $this->profile);

        $method = $this->labelMethod;

        $rec = $this->dao->{$method}($key);

        if ($rec) {
            return $this->buildLabel($rec);
        }
        else {
            return null;
        }
    }

    protected function buildLabel($rec) {
        $label = '' ;
        foreach( (array)$this->labelProperty as $property ) {
            if ((string)$rec->{$property} !== '')
                $label .= $rec->{$property}.$this->labelSeparator;
        }
        if ($this->labelSeparator != '')
            $label = substr($label, 0, -strlen($this->labelSeparator));
        return $label ;
    }

    public function setCriteriaControls($criteriaFrom = null){
        if ( count($criteriaFrom) !== 4 ) {
            throw new Exception("4 criterias needed: repository, project, parcelleLayerId,section");
        }
        $this->criteriaFrom = $criteriaFrom;
    }

}
