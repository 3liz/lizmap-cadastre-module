<?php

/**
 * Rights of the cadastre module.
 *
 * * Access to the owners (names and addresses): search by owner, CSV exports, fiche;
 * * sensitive data, like the options of the QGIS plugin: birth date and place, revenues, exonerations;
 * * features: relevé parcellaire, relevé de propriété, tabs of the detailed information in the popup.
 *
 * The rights are global: they are not checked on a repository.
 *
 * @author    3liz
 * @copyright 2026 3liz
 *
 * @see      http://3liz.com
 *
 * @license Mozilla Public License : http://www.mozilla.org/MPL/
 */
class cadastreRights
{
    /** Access to the data of the owners: names and addresses */
    public const OWNERS = 'cadastre.acces.donnees.proprio.simple';

    /** Access to the birth date and place of the owners */
    public const BIRTH = 'cadastre.acces.donnees.naissance';

    /** Access to the revenues */
    public const REVENUE = 'cadastre.acces.donnees.revenus';

    /** Access to the tax exonerations */
    public const EXONERATION = 'cadastre.acces.donnees.exonerations';

    /** Access to the relevé parcellaire (PDF) */
    public const RELEVE_PARCELLAIRE = 'cadastre.releve.parcellaire';

    /** Access to the relevé de propriété (PDF) */
    public const RELEVE_PROPRIETE = 'cadastre.releve.propriete';

    /** Access to the tabs of the detailed information in the popup of the parcelles, and to their print */
    public const POPUP_TABS = 'cadastre.popup.onglets';

    /** Sensitive data, with their right: the names are those of the parameters of the QGIS plugin */
    public const SENSITIVE = array(
        'birth' => self::BIRTH,
        'revenue' => self::REVENUE,
        'exoneration' => self::EXONERATION,
    );

    /**
     * Check if the user can see the data of the owners.
     *
     * @return bool
     */
    public static function hasOwnersAccess()
    {
        return jAcl2::check(self::OWNERS);
    }

    /**
     * Get the sensitive data the user can see, optionally restricted to the ones he asked for.
     *
     * @param null|array $requested For each sensitive data (birth, revenue, exoneration), true if the user
     *                              asked for it, for example with the check boxes of the CSV exports.
     *                              Null to get all the sensitive data allowed by his rights.
     *
     * @return array For each sensitive data, true if it can be given to the user
     */
    public static function sensitiveData($requested = null)
    {
        $result = array();
        foreach (self::SENSITIVE as $name => $right) {
            $asked = ($requested === null) || !empty($requested[$name]);
            $result[$name] = $asked && jAcl2::check($right);
        }

        return $result;
    }

    /**
     * Check if the user has at least one right on the sensitive data.
     *
     * Otherwise his exports are the same as those for a third party: the box "pour un tiers" is not displayed.
     *
     * @return bool
     */
    public static function hasSensitiveDataRight()
    {
        return in_array(true, self::sensitiveData(), true);
    }

    /**
     * Get the sensitive data given in an export: CSV file or relevé.
     *
     * @param bool $forThirdParty True if the user checked the box "pour un tiers"
     *
     * @return array For each sensitive data, true if it is exported: none for a third party,
     *               otherwise the ones allowed by the rights of the user
     */
    public static function exportSensitiveData($forThirdParty)
    {
        if ($forThirdParty) {
            return self::sensitiveData(array());
        }

        return self::sensitiveData();
    }

    /**
     * Get the parameters of a request to the QGIS plugin for the sensitive data.
     *
     * The plugin accepts BIRTH, REVENUE and EXONERATION. ADVANCED is also given when all the sensitive data
     * are allowed, for the versions of the plugin which only know it.
     *
     * @param array $sensitive For each sensitive data, true if it can be given, see sensitiveData()
     *
     * @return array The parameters
     */
    public static function pluginParameters($sensitive)
    {
        $params = array();
        foreach (array_keys(self::SENSITIVE) as $name) {
            $params[$name] = !empty($sensitive[$name]) ? '1' : '0';
        }
        $params['advanced'] = !in_array('0', $params, true) ? '1' : '0';

        return $params;
    }

    /**
     * Get the rights given to the JavaScript of the module, to display the buttons and the tabs.
     *
     * @return array The rights, as booleans
     */
    public static function forJavaScript()
    {
        return array(
            'owners' => self::hasOwnersAccess(),
            'birth' => jAcl2::check(self::BIRTH),
            'revenue' => jAcl2::check(self::REVENUE),
            'exoneration' => jAcl2::check(self::EXONERATION),
            'releveParcellaire' => jAcl2::check(self::RELEVE_PARCELLAIRE),
            'relevePropriete' => jAcl2::check(self::RELEVE_PROPRIETE),
            'popupTabs' => jAcl2::check(self::POPUP_TABS),
            'exportSensitive' => self::hasSensitiveDataRight(),
        );
    }
}
