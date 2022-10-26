<?php
/**
 * @author    René-Luc Dhont
 * @copyright 2022 3liz
 *
 * @see      http://3liz.com
 *
 * @license Mozilla Public License : http://www.mozilla.org/MPL/
 */
class cadastreModuleUpgrader_v183 extends jInstallerModule
{
    public $targetVersions = array('1.8.3');
    public $date = '2022-11-16';

    public function install()
    {
        if ($this->firstExec('acl2')) {
            $this->useDbProfile('auth');

            jAcl2DbManager::addSubject('cadastre.acces.donnees.proprio.simple', 'cadastre~search.cadastre.acces.donnees.proprio.simple', 'cadastre.subject.group');

            // Add rights on group
            jAcl2DbManager::setRightsOnGroup(
                'cadastre_lizmap',
                array(
                    'cadastre.acces.donnees.proprio.simple' => true,
                )
            );
        }
    }
}
