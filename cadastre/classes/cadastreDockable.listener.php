<?php

class cadastreDockableListener extends jEventListener
{
    public function onmapDockable($event)
    {
        $isCadastreProject = false;
        $services = lizmap::getServices();
        $parcelleId = null;
        if (version_compare($services->qgisServerVersion, '3.0', '<')) {
            if (preg_match('#^cadastre#i', $event->project)) {
                $isCadastreProject = true;
            }
        } else {
            $config = cadastreConfig::get($event->repository, $event->project);
            if ($config !== null) {
                $isCadastreProject = true;
                $parcelleId = $config->parcelle->id;
            }
        }

        // Check profile
        $profile = 'cadastre';
        if (!empty($parcelleId)) {
            $profile = cadastreProfile::getWithLayerId(
                $event->repository,
                $event->project,
                $parcelleId
            );
        } else {
            try {
                // try to get the specific search profile to do not rebuild it
                jProfiles::get('jdb', $profile, true);
            } catch (Exception $e) {
                $profile = null;
            }
        }

        if ($isCadastreProject
            and cadastreProfile::checkAccess($profile)
        ) {
            // Check if database has MAJIC content or not
            $hasProprietaire = cadastreProfile::checkTableContent('proprietaire', $profile);
            $form_name = 'cadastre~search';
            if (!$hasProprietaire) {
                $form_name = 'cadastre~search_no_majic';
            }

            // cadastre dock
            // Create search form
            $searchForm = jForms::create($form_name);
            $searchForm->setData('repository', $event->repository);
            $searchForm->setData('project', $event->project);
            $searchForm->setData('parcelleLayerId', $parcelleId);
            $hasMajic = '0';
            if ($hasProprietaire
                && (jAcl2::check('cadastre.acces.donnees.proprio') || jAcl2::check('cadastre.acces.donnees.proprio.simple'))) {
                $hasMajic = '1';
            }
            $searchForm->setData('has_majic', $hasMajic);

            // Add the PostgreSQL layers of the same database in the 3rd search tab "Spatial"
            if ($hasMajic == '1') {
                // Get the project
                $p = lizmap::getProject($event->repository . '~' . $event->project);
                if ($p === null) {
                    throw new Exception("Spatial search: Unknown repository/project {$event->repository}.'~'.{$event->project}");
                }

                // Get the PostgreSQL database info of the Parcelle layer
                /** @var \qgisVectorLayer $parcelleLayer The QGIS vector layer instance */
                $parcelleLayer = $p->getLayer($parcelleId);
                $parcelleProfile = $parcelleLayer->getDatasourceProfile(30, false);

                // Get the list of PostgreSQL layers
                $layers = array();
                foreach ($p->getLayers() as $layer) {
                    /** @var \qgisVectorLayer $qgisLayer The QGIS vector layer instance */
                    $qgisLayer = $p->getLayer($layer->id);
                    // Only for existing layers
                    if (!$qgisLayer) {
                        continue;
                    }
                    // Not the parcelle layer itself
                    if ($qgisLayer->getId() == $parcelleId) {
                        continue;
                    }
                    // Only PostgreSQL layers
                    if ($qgisLayer->getProvider() != 'postgres') {
                        continue;
                    }
                    // Only Layers in attribute table to be able to select features
                    if (!$p->hasAttributeLayersForLayer($qgisLayer->getName())) {
                        continue;
                    }
                    // Check if the database is the same as the Parcelle layer
                    if ($qgisLayer->getDatasourceProfile(30, false) != $parcelleProfile) {
                        continue;
                    }
                    $layers[$layer->id] = $layer->name;
                }

                // Add the list of spatial layers in the combobox
                $datasource = new \jFormsStaticDatasource();
                $datasource->data = $layers;
                $searchForm->getControl('spatial_layer_id')->datasource = $datasource;
            }

            $assign = array(
                'form' => $searchForm,
                'has_majic' => $hasMajic,
            );
            $content = array('cadastre~cadastre_search', $assign);

            $dock = new lizmapMapDockItem(
                'cadastre',
                jLocale::get('cadastre~search.dock.title'),
                $content,
                9,
                null,
                null
            );
            $event->add($dock);
        }
    }

    public function onmapMiniDockable($event) {}

    public function onmapRightDockable($event) {}

    public function onmapBottomDockable($event) {}
}
