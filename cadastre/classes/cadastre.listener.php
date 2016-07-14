<?php
class cadastreListener extends jEventListener{

    function ongetMapAdditions ($event) {
        $bp = jApp::config()->urlengine['basePath'];

        // Add JS and CSS for cadastre module
        $js = array();
        $jscode = array();
        $css = array();

        if (preg_match('#^cadastre#i', $event->project)){
            $js = array(
                $bp.'js/cadastre/cadastre.js'
            );
            $cadastreConfig = array(
                'url' => jUrl::get('cadastre~service:getCadastrePdf'),
                'layer' => 'Parcelles',
                'pk' => 'geo_parcelle'
            );
            $jscode = array(
                'var cadastreConfig = ' . json_encode($cadastreConfig)
            );
            $css = array(
                $bp.'css/cadastre/cadastre.css'
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
