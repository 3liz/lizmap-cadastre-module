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
                $lproj = lizmap::getProject($event->repository.'~'.$event->project);
                $configOptions = $lproj->getOptions();
                $bp = jApp::config()->urlengine['basePath'];

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
                if ($hasProprietaire and jAcl2::check('cadastre.acces.donnees.proprio')) {
                    $hasMajic = '1';
                }
                $searchForm->setData('has_majic', $hasMajic);
                $assign = array(
                    'form' => $searchForm,
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

        public function onmapMiniDockable($event)
        {
        }

        public function onmapRightDockable($event)
        {
        }

        public function onmapBottomDockable($event)
        {
        }
    }
