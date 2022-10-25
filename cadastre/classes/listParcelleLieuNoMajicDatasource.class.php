<?php

require_once JELIX_LIB_PATH . 'forms/jFormsDatasource.class.php';

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
    protected $dao;

    public function __construct($formid)
    {
    }

    public function getData($form)
    {
        $repository = $form->getData($this->criteriaFrom[0]);
        $project = $form->getData($this->criteriaFrom[1]);
        $layerId = $form->getData($this->criteriaFrom[2]);
        $section = $form->getData($this->criteriaFrom[3]);
        $this->profile = cadastreProfile::getWithLayerId($repository, $project, $layerId);

        if ($this->dao === null) {
            $this->dao = jDao::get($this->selector, $this->profile);
        }

        $args = array();
        array_push($args, $section);

        $config = cadastreConfig::get($repository, $project);
        $fblConfig = cadastreConfig::getFilterByLogin($repository, $project, $config->parcelle->id);

        $found = array();
        if ($fblConfig === null) {
            $found = call_user_func_array(array($this->dao, $this->method), $args);
        } else {
            $method = $this->method . 'AndFieldIn';
            array_push($args, $fblConfig->filterAttribute);
            if (!jAuth::isConnected()) {
                array_push($args, null);
            } else {
                if (property_exists($fblConfig, 'filterPrivate') && $fblConfig->filterPrivate == 'True') {
                    $user = jAuth::getUserSession();
                    array_push($args, $user->login);
                } else {
                    array_push($args, jAcl2DbUserGroup::getGroups());
                }
            }
            $found = call_user_func_array(array($this->dao, $method), $args);
        }

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
        if (count($criteriaFrom) !== 4) {
            throw new Exception('4 criterias needed: repository, project, parcelleLayerId,section');
        }
        $this->criteriaFrom = $criteriaFrom;
    }
}
