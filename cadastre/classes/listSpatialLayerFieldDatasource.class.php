<?php

require_once JELIX_LIB_PATH . 'forms/jFormsDatasource.class.php';

class listSpatialLayerFieldDatasource extends jFormsDynamicDatasource
{
    protected $labelProperty = array();
    protected $labelSeparator;
    public $labelMethod = 'get';
    protected $keyProperty = 'ogc_fid';
    protected $valueProperty = 'geo_parcelle';

    protected $fields;
    protected $aliases;

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
        $spatialLayerId = $form->getData($this->criteriaFrom[2]);
        if (empty($spatialLayerId)) {
            return array();
        }

        // Get spatial layer name, table info, fields, etc.
        $p = lizmap::getProject($repository . '~' . $project);
        if ($p === null) {
            throw new Exception("Spatial search: Unknown repository/project {$repository}.'~'.{$project}");
        }

        /** @var \qgisVectorLayer $qgisLayer The QGIS vector layer instance */
        $qgisLayer = $p->getLayer($spatialLayerId);
        if (!$qgisLayer) {
            throw new Exception("Spatial search: Unknown layer {$spatialLayerId} used in spatial search");
        }

        // Get fields and aliases
        $this->fields = $qgisLayer->getFields();
        $this->aliases = $qgisLayer->getAliasFields();
        $result = array();
        foreach ($this->fields as $field) {
            $label = $field;
            if (array_key_exists($field, $this->aliases) && !empty($this->aliases[$field])) {
                $label = $this->aliases[$field];
            }
            $result[$field] = $label;
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
        $spatialLayerId = $form->getData($this->criteriaFrom[2]);

        return $key;

        return null;
    }

    protected function buildLabel($key)
    {
        return $key;
    }

    public function setCriteriaControls($criteriaFrom = null)
    {
        if (count($criteriaFrom) !== 3) {
            throw new Exception(
                '3 criterias needed: repository, project, spatial_layer_id'
            );
        }
        $this->criteriaFrom = $criteriaFrom;
    }
}
