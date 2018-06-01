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
                jUrl::get('jelix~www:getfile', array('targetmodule'=>'cadastre', 'file'=>'cadastre.js'))
            );
            $cadastreConfig = array(
                'layer' => 'Parcelles',
                'pk' => 'geo_parcelle'
            );

            // Access control
            if( jAcl2::check("cadastre.acces.donnees.proprio") ){
                $cadastreConfig['url'] = jUrl::get('cadastre~service:getCadastrePdf');
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
