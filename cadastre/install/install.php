<?php
/**
 * @author    Michaël Douchin
 *
 * @contributor Laurent Jouanneau
 *
 * @copyright 2014-2022 3liz
 *
 * @see      http://3liz.com
 *
 * @license Mozilla Public License : http://www.mozilla.org/MPL/
 */
class cadastreModuleInstaller extends \Jelix\Installer\Module\Installer
{
    public function install(Jelix\Installer\Module\API\InstallHelpers $helpers)
    {
        $helpers->database()->useDbProfile('auth');

        // Add rights group
        jAcl2DbManager::addSubjectGroup('cadastre.subject.group', 'cadastre~search.cadastre.subject.group.name');

        // Add right subject
        jAcl2DbManager::addSubject('cadastre.acces.donnees.proprio', 'cadastre~search.cadastre.acces.donnees.proprio', 'cadastre.subject.group');
        jAcl2DbManager::addSubject('cadastre.use.search.tool', 'cadastre~search.cadastre.use.search.tool', 'cadastre.subject.group');

        // Create cadastre group
        jAcl2DbUserGroup::createGroup(
            'Cadastre Lizmap',
            'cadastre_lizmap'
        );

        // Add rights on group
        jAcl2DbManager::setRightsOnGroup(
            'cadastre_lizmap',
            array(
                'cadastre.use.search.tool' => true,
                'cadastre.acces.donnees.proprio' => true,
            )
        );

        // Add admin users to cadastre group
        jAcl2DbUserGroup::addUserToGroup('admin', 'cadastre_lizmap');
    }
}
