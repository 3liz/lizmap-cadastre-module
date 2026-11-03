<?php

use Jelix\Installer\Module\API\InstallHelpers;
use Jelix\Installer\Module\Installer;

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
class cadastreModuleInstaller extends Installer
{
    /** Rights of the module on the data and the features, besides the search tool */
    public const RIGHTS = array(
        'cadastre.acces.donnees.proprio.simple',
        'cadastre.acces.donnees.naissance',
        'cadastre.acces.donnees.revenus',
        'cadastre.acces.donnees.exonerations',
        'cadastre.releve.parcellaire',
        'cadastre.releve.propriete',
        'cadastre.popup.onglets',
    );

    public function install(InstallHelpers $helpers)
    {
        $helpers->database()->useDbProfile('auth');

        // Add rights group
        jAcl2DbManager::addSubjectGroup('cadastre.subject.group', 'cadastre~search.cadastre.subject.group.name');

        // Add the rights, see cadastreRights
        jAcl2DbManager::addSubject('cadastre.use.search.tool', 'cadastre~search.cadastre.use.search.tool', 'cadastre.subject.group');
        foreach (self::RIGHTS as $right) {
            jAcl2DbManager::addSubject($right, 'cadastre~search.' . $right, 'cadastre.subject.group');
        }

        // Create cadastre group
        jAcl2DbUserGroup::createGroup(
            'Cadastre Lizmap',
            'cadastre_lizmap'
        );

        // All the rights for the cadastre group
        $rights = array('cadastre.use.search.tool' => true);
        foreach (self::RIGHTS as $right) {
            $rights[$right] = true;
        }
        jAcl2DbManager::setRightsOnGroup('cadastre_lizmap', $rights);

        // Add admin users to cadastre group
        jAcl2DbUserGroup::addUserToGroup('admin', 'cadastre_lizmap');
    }
}
