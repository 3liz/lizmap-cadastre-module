<?php

use Jelix\Installer\Module\API\InstallHelpers;
use Jelix\Installer\Module\Installer;

/**
 * Replace the right "access to the advanced data of the owners" by detailed rights.
 *
 * The groups with the old right get all the new rights, with the same resources and the same
 * forbidden rights, so that nothing changes for the users:
 *
 * * access to the owners (the right of the simplified data, which is kept);
 * * birth date and place, revenues, exonerations;
 * * relevé parcellaire, relevé de propriété, tabs of the detailed information in the popup.
 *
 * The groups with only the simplified data keep it: they still have no PDF and no tab in the popup.
 * The old right is then deleted.
 *
 * @author    3liz
 * @copyright 2026 3liz
 *
 * @see      http://3liz.com
 *
 * @license Mozilla Public License : http://www.mozilla.org/MPL/
 */
class cadastreModuleUpgrader_v230 extends Installer
{
    protected $targetVersions = array('2.3.0-pre');
    protected $date = '2026-11-03';

    /** The right replaced by the new ones */
    public const OLD_RIGHT = 'cadastre.acces.donnees.proprio';

    /** The new rights, given to the groups of the old right */
    public const NEW_RIGHTS = array(
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

        foreach (self::NEW_RIGHTS as $right) {
            jAcl2DbManager::addSubject($right, 'cadastre~search.' . $right, 'cadastre.subject.group');
            jAcl2DbManager::copyRightSettings(self::OLD_RIGHT, $right);
        }
        // The groups of the old right also get the access to the owners, which was implied by it
        jAcl2DbManager::copyRightSettings(self::OLD_RIGHT, 'cadastre.acces.donnees.proprio.simple');

        jAcl2DbManager::removeSubject(self::OLD_RIGHT);
    }
}
