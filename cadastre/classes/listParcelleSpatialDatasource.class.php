<?php

class listParcelleSpatialDatasource extends jFormsDynamicDatasource
{
    protected $selector = 'cadastre~parcelle_info';
    protected $method = 'findBySpatialIntersection';

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
        $spatialLayerId = $form->getData($this->criteriaFrom[3]);
        // $spatialLayerUseSelected = $form->getData($this->criteriaFrom[4]);
        $spatialLayerSelectedIds = $form->getData($this->criteriaFrom[4]);
        $spatialLayerField = $form->getData($this->criteriaFrom[5]);
        $spatialLayerBuffer = $form->getData($this->criteriaFrom[6]);

        if (empty($spatialLayerId)) {
            return array();
        }
        $this->profile = cadastreProfile::getWithLayerId($repository, $project, $layerId);

        if ($this->dao === null) {
            $this->dao = jDao::get($this->selector, $this->profile);
        }

        $searchConditions = jDao::createConditions();

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

        // Get spatial layer name, table info, fields, etc.
        $p = lizmap::getProject($repository . '~' . $project);
        if ($p === null) {
            throw new Exception("Spatial search: Unknown repository/project {$repository}.'~'.{$project}");
        }

        /** @var \qgisVectorLayer $qgisLayer The QGIS vector layer instance */
        $qgisLayer = $p->getLayer($spatialLayerId);
        if (!$qgisLayer) {
            throw new Exception("Spatial search: Unknown layer {$layerId} used in spatial search");
        }

        // Get the PostgreSQL information
        $dataSourceParameters = $qgisLayer->getDatasourceParameters();
        $spatialLayerSchema = $dataSourceParameters->schema;
        $spatialLayerTable = $dataSourceParameters->tablename;

        // Check that the given field exists
        $fields = $qgisLayer->getFields();
        if (!empty($spatialLayerField) && !in_array($spatialLayerField, $fields)) {
            throw new Exception("Spatial search: the field {$spatialLayerField} does not exist in the table ");
        }

        // Get the table primary key field
        // Only one field supported
        $dbFieldsInfo = $qgisLayer->getDbFieldsInfo();
        $spatialLayerPk = null;
        foreach ($dbFieldsInfo->primaryKeys as $key) {
            $spatialLayerPk = $key;

            break;
        }

        // Get the optional selection
        // JS 3.6 : lizMap.config.layers["Parcelles"]['selectedFeatures']
        // JS 3.7 : lizMap.mainLizmap.config.layers["Parcelles"]['selectedFeatures']
        $selectedIds = array();
        if (!empty($spatialLayerSelectedIds)) {
            $selectedIds = explode(',', $spatialLayerSelectedIds);
        } else {
            $selectedIds = array('-9999999');
        }

        // Run the query by using the DAO method
        $found = $this->dao->{$this->method}(
            $layerConditions,
            $searchConditions,
            $spatialLayerSchema,
            $spatialLayerTable,
            $spatialLayerPk,
            $selectedIds,
            $spatialLayerField,
            $spatialLayerBuffer,
            $dbFieldsInfo->geometryColumn,
            $dbFieldsInfo->geometryType
        );

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
        if (count($criteriaFrom) !== 7) {
            throw new Exception(
                '7 criterias needed: repository, project, parcelleLayerId, spatial_layer_id, spatial_layer_selected_ids, spatial_layer_field, spatial_layer_buffer'
            );
        }
        $this->criteriaFrom = $criteriaFrom;
    }
}
