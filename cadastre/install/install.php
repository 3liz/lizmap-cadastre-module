<?php
/**
* @package   lizmap
* @subpackage cadastre
* @author    Michaël Douchin
* @copyright 2014 3liz
* @link      http://3liz.com
* @license    All rights reserved
*/


class cadastreModuleInstaller extends jInstallerModule {

    function install() {

        // Copy CSS and JS files
        $this->copyDirectoryContent('www', jApp::wwwPath());

        if ($this->firstExec('acl2') ) {
            $this->useDbProfile('auth');

            //jAcl2DbManager::addSubjectGroup ('cadastre.subject.group', 'cadastre~jacl2.cadastre.subject.group.name');
            //jAcl2DbManager::addSubject( 'cadastre.admin.config.gerer', 'cadastre~jacl2.cadastre.admin.config.gerer', 'cadastre.subject.group');
        }

    }
}
