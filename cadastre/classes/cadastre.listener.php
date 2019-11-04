<?php
class cadastreListener extends jEventListener{

    function ongetMapAdditions ($event) {
        # Check cadastre configuration
        $hasCadastreConfig = false;
        $cadastreConfig = array();
        $services = lizmap::getServices();
        if (version_compare($services->qgisServerVersion, '3.0', '<')) {
            if (preg_match('#^cadastre#i', $event->project) ) {
                $hasCadastreConfig = true;
                $cadastreConfig = array(
                    'layer' => 'Parcelles',
                    'pk' => 'geo_parcelle'
                );
            }
        } else {
            $config = cadastreConfig::get($event->repository, $event->project);
            if ($config !== Null) {
                $hasCadastreConfig = true;
                $cadastreConfig = array(
                    'layer' => $config->parcelle->name,
                    'pk' => $config->parcelle->unique_field
                );
            }
        }

        // Add JS and CSS for cadastre module
        $js = array();
        $jscode = array();
        $css = array();

        if ($hasCadastreConfig){
            $bp = jApp::config()->urlengine['basePath'];

            $js = array(
                jUrl::get('jelix~www:getfile', array('targetmodule'=>'cadastre', 'file'=>'cadastre.js'))
            );

            // Access control
            if( jAcl2::check("cadastre.acces.donnees.proprio") ){
                $cadastreConfig['url'] = jUrl::get('cadastre~service:initExport');
            }else{
                $cadastreConfig['url'] = Null;
            }

            $jscode = array(
                'var cadastreConfig = ' . json_encode($cadastreConfig)
            );
            $css = array(
                jUrl::get('jelix~www:getfile', array('targetmodule'=>'cadastre', 'file'=>'cadastre.css'))
            );
        }
        $event->add(
            array(
                'js' => $js,
                'jscode' => $jscode,
                'css' => $css
            )
        );
    }
}
?>
