<?php

class cadastreListener extends jEventListener
{
    public function ongetMapAdditions($event)
    {
        // Check cadastre configuration
        $hasCadastreConfig = false;
        $cadastreConfig = array();
        $services = lizmap::getServices();
        if (version_compare($services->qgisServerVersion, '3.0', '<')) {
            if (preg_match('#^cadastre#i', $event->project)) {
                $hasCadastreConfig = true;
                $cadastreConfig = array(
                    'layer' => 'Parcelles',
                    'pk' => 'geo_parcelle',
                );
            }
        } else {
            $config = cadastreConfig::get($event->repository, $event->project);
            if ($config !== null) {
                $hasCadastreConfig = true;
                $cadastreConfig = array(
                    'layer' => $config->parcelle->name,
                    'pk' => $config->parcelle->unique_field,
                );
                $cadastreConfig = array_merge(
                    $cadastreConfig,
                    (array) $config
                );
            }
        }

        // Add JS and CSS for cadastre module
        $js = array();
        $jscode = array();
        $css = array();

        // Add the cadastre config only if at least one right is granted
        $hasEnoughRights = (
            jAcl2::check('cadastre.use.search.tool')
            || jAcl2::check('cadastre.acces.donnees.proprio')
            || jAcl2::check('cadastre.acces.donnees.proprio.simple')
        );

        if ($hasCadastreConfig && $hasEnoughRights) {
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
        $event->add(
            array(
                'js' => $js,
                'jscode' => $jscode,
                'css' => $css,
            )
        );
    }
}
