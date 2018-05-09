<?php
    class cadastreDockableListener extends jEventListener{

        function onmapDockable ($event) {

            $coord = jApp::coord();
            $project = $event->getParam( 'project' );
            if (preg_match('#^cadastre#i', $event->project)){
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

    }

?>
