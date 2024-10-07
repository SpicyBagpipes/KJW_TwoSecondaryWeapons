#include "script_component.hpp"
/*
 *  Author: Jenna
 *
 *  Updates shown weapon based on player's currently equipped primary.
 *
 *  Arguments:
 *  None
 *
 *  Return Value:
 *  None
 *
 *  Example:
 *  call KJW_TwoSecondaryWeapons_fnc_updateShownWeapon
 *
 *  Public: No
 */


private _primarySecondaryWeapon = (player getVariable [QGVAR(primarySecondaryInfo),[""]])#0;
private _secondSecondaryWeapon = (player getVariable [QGVAR(secondSecondaryInfo),[""]])#0;

private _primaryIsValid = true;
private _secondaryIsValid = true;
if ((_primarySecondaryWeapon isNotEqualTo "")) then {
	private _weaponLowered = toLowerANSI _primarySecondaryWeapon;
	private _whitelist = (parseSimpleArray GVAR(whitelistedClasses) apply {toLowerANSI _x});
	private _blacklist = (parseSimpleArray GVAR(blacklistedClasses) apply {toLowerANSI _x});
	private _whitelistHasValues = (count _whitelist) > 0;

	private _matchesWhitelist = (!_whitelistHasValues) || (_weaponLowered in _whitelist);
	private _matchesBlacklist = _weaponLowered in _blacklist;

	_primaryIsValid = (!_matchesBlacklist) && _matchesWhitelist;
};

if ((_secondSecondaryWeapon isNotEqualTo "")) then {
	private _weaponLowered = toLowerANSI _secondSecondaryWeapon;
	private _whitelist = (parseSimpleArray GVAR(whitelistedClasses) apply {toLowerANSI _x});
	private _blacklist = (parseSimpleArray GVAR(blacklistedClasses) apply {toLowerANSI _x});
	private _whitelistHasValues = (count _whitelist) > 0;

	private _matchesWhitelist = (!_whitelistHasValues) || (_weaponLowered in _whitelist);
	private _matchesBlacklist = _weaponLowered in _blacklist;

	_secondaryIsValid = (!_matchesBlacklist) && _matchesWhitelist;
};

if !_primaryIsValid then {
	player setVariable [QGVAR(primarySecondaryInfo),nil]
};

if !_secondaryIsValid then {
	player setVariable [QGVAR(secondSecondaryInfo),nil]
};
