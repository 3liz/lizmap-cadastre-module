<?php

class cadastreListener extends jEventListener
{
    public function ongetMapAdditions($event)
    {
        // Check cadastre configuration
        $config = cadastreConfig::get($event->repository, $event->project);
        if ($config === null) {
            return;
        }

        // Add the cadastre config only if at least one right is granted
        // Check if the user has enough rights
        if (!(
            jAcl2::check('cadastre.use.search.tool')
            || cadastreRights::hasOwnersAccess()
        )) {
            return;
        }

        $cadastreConfig = array(
            'layer' => $config->parcelle->name,
            'pk' => $config->parcelle->unique_field,
        );
        $cadastreConfig = array_merge(
            $cadastreConfig,
            (array) $config
        );

        // Add JS and CSS for cadastre module
        $js = array(
            jUrl::get('jelix~www:getfile', array('targetmodule' => 'cadastre', 'file' => 'cadastre.js')),
        );

        $cadastreConfig['url'] = jUrl::get('cadastre~service:initExport');
        // Rights of the user, to display the buttons, the check boxes and the tabs
        $cadastreConfig['rights'] = cadastreRights::forJavaScript();
        // Maximum number of parcelles of a CSV export, checked before the request
        jClasses::inc('cadastre~cadastreExtraInfos');
        $cadastreConfig['exportMaxParcelles'] = cadastreExtraInfos::MAX_EXPORT_PARCELLES;

        $jscode = array(
            'var cadastreConfig = ' . json_encode($cadastreConfig),
        );
        $css = array(
            jUrl::get('jelix~www:getfile', array('targetmodule' => 'cadastre', 'file' => 'cadastre.css')),
        );

        $event->add(
            array(
                'js' => $js,
                'jscode' => $jscode,
                'css' => $css,
            )
        );
    }
}
