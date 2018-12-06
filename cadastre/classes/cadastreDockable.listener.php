<?php
    class cadastreDockableListener extends jEventListener{

        function onmapDockable ($event) {

            $coord = jApp::coord();
            $project = $event->getParam( 'project' );
            if( preg_match('#^cadastre#i', $event->project) and $this->checkCadastre() ){
                $repository = $event->getParam( 'repository' );
                $lproj = lizmap::getProject( $repository . '~' .$project );
                $configOptions = $lproj->getOptions();
                $bp = jApp::config()->urlengine['basePath'];

                // cadastre dock
                // Create search form
                $searchForm = jForms::create("cadastre~search");
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

        protected function checkCadastre(){
            $ok = False;

            // Access control
            if( !jAcl2::check("cadastre.use.search.tool") ){
                return False;
            }

            $profile = 'cadastre';
            try {
                // try to get the specific search profile to do not rebuild it
                jProfiles::get('jdb', $profile, true);
            } catch (Exception $e) {
                // else use default
                $profile = Null;
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
