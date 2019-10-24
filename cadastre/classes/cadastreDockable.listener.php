<?php
    class cadastreDockableListener extends jEventListener{

        function onmapDockable ($event) {
            $isCadastreProject = false;
            $services = lizmap::getServices();
            $parcelleId = null;
            if (version_compare($services->qgisServerVersion, '3.0', '<')) {
                if (preg_match('#^cadastre#i', $event->project) ) {
                    $isCadastreProject = true;
                }
            } else {
                $p = lizmap::getProject($event->repository.'~'.$event->project);
                if ($p) {
                    jClasses::inc('cadastre~lizmapCadastreRequest');
                    $request = new lizmapCadastreRequest(
                        $p,
                        array(
                            'service'=>'CADASTRE',
                            'request'=>'GetCapabilities'
                        )
                    );
                    $result = $request->process();
                    if ($result->code === 200 && $result->mime !== 'text/xml'){
                        $data = json_decode($result->data);
                        if ($data->status == 'success') {
                            $isCadastreProject = true;
                            $parcelleId = $data->data->parcelle->id;
                        }
                    }
                }
            }

            // Check profile
            $profile = 'cadastre';
            try {
                // try to get the specific search profile to do not rebuild it
                jProfiles::get('jdb', $profile, true);
            } catch (Exception $e) {
                // else use default or virtual profile
                $repository = $event->repository;
                $project = $event->project;
                if (!empty($parcelleId)) {
                    $project = lizmap::getProject($repository . '~' .$project);
                    $qgisLayer = $project->getLayer($parcelleId);
                    $profile = $qgisLayer->getDatasourceProfile();
                } else {
                    $profile = Null;
                }
            }

            if ($isCadastreProject
                and $this->checkCadastre($profile, $parcelleId)
            ) {
                $lproj = lizmap::getProject( $event->repository . '~' .$event->project );
                $configOptions = $lproj->getOptions();
                $bp = jApp::config()->urlengine['basePath'];

                // cadastre dock
                // Create search form
                $searchForm = jForms::create("cadastre~search");
                $form->setData('repository', $event->repository);
                $form->setData('project', $event->project);
                $assign = array(
                    'form' => $searchForm
                );
                $content = array( 'cadastre~cadastre_search', $assign );

                $dock = new lizmapMapDockItem(
                    'cadastre',
                    jLocale::get("cadastre~search.dock.title"),
                    $content,
                    9,
                    Null,
                    Null
                );
                $event->add($dock);
            }
        }


        function onmapMiniDockable ( $event ) {
        }

        function onmapRightDockable ( $event ) {
        }

        function onmapBottomDockable ( $event ) {
        }

        protected function checkCadastre($profile, $parcelleId){
            $ok = False;

            // Access control
            if( !jAcl2::check("cadastre.use.search.tool") ){
                return False;
            }

            // Try to get data from geo_commune
            try {
                // try to get the specific search profile to do not rebuild it
                $cnx = jDb::getConnection( $profile );
                $cnx->query('SELECT geo_commune FROM geo_commune LIMIT 0;');
                $ok = True;
            } catch (Exception $e) {
                $ok = False;
            }
            return $ok;
        }

    }

?>
