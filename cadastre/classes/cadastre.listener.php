<?php

class cadastreListener extends jEventListener
{
    public function ongetMapAdditions($event)
    {
        // Add JS and CSS for cadastre module
        $js = array();
        $jscode = array();
        $css = array();

        $config = cadastreConfig::get($event->repository, $event->project);
        if ($config === null) {
            $event->add(array(
                'js' => $js,
                'jscode' => $jscode,
                'css' => $css,
            );
            return;
        }

        // Check cadastre configuration
        $cadastreConfig = array(
            'layer' => $config->parcelle->name,
            'pk' => $config->parcelle->unique_field,
        );
        $cadastreConfig = array_merge(
            $cadastreConfig,
            (array) $config
        );

        // Add the cadastre config only if at least one right is granted
        $hasEnoughRights = (
            jAcl2::check('cadastre.use.search.tool')
            || jAcl2::check('cadastre.acces.donnees.proprio')
            || jAcl2::check('cadastre.acces.donnees.proprio.simple')
        );
        if (!hasEnoughRights) {
            $event->add(array(
                'js' => $js,
                'jscode' => $jscode,
                'css' => $css,
            );
            return;
        }

        $js = array(
            jUrl::get('jelix~www:getfile', array('targetmodule' => 'cadastre', 'file' => 'cadastre.js')),
        );

        $cadastreConfig['url'] = jUrl::get('cadastre~service:initExport');
        $cadastreConfig['advanced'] = jAcl2::check('cadastre.acces.donnees.proprio');

        $jscode = array(
            'var cadastreConfig = ' . json_encode($cadastreConfig),
        );
        $css = array(
            jUrl::get('jelix~www:getfile', array('targetmodule' => 'cadastre', 'file' => 'cadastre.css')),
        );
    }
}
