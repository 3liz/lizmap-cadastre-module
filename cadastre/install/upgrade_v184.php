<?php

/**
 * @author    René-Luc Dhont
 * @copyright 2022 3liz
 *
 * @see      http://3liz.com
 *
 * @license Mozilla Public License : http://www.mozilla.org/MPL/
 */
class cadastreModuleUpgrader_v184 extends jInstallerModule
{
    public $targetVersions = array('1.8.4');
    public $date = '2022-11-29';

    public function install()
    {
        if ($this->firstExec('acl2')) {
            $this->useDbProfile('auth');

            jAcl2DbManager::addSubject('cadastre.acces.donnees.proprio.simple', 'cadastre~search.cadastre.acces.donnees.proprio.simple', 'cadastre.subject.group');

            // Add rights on group
            if (jAcl2DbUserGroup::getGroup('cadastre_lizmap')) {
                // reset rights
                jAcl2DbManager::addRight(
                    'cadastre_lizmap',
                    'cadastre.use.search.tool'
                );
                jAcl2DbManager::addRight(
                    'cadastre_lizmap',
                    'cadastre.acces.donnees.proprio.simple'
                );
                jAcl2DbManager::addRight(
                    'cadastre_lizmap',
                    'cadastre.acces.donnees.proprio'
                );
            }
        }
    }
}
