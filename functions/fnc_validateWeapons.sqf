#include "script_component.hpp"
/*
 *  Author: Jenna
 *
 *  Updates shown weapon based on player's currently equipped primary.
 *
 *  Arguments:
 *  0: Unit <OBJECT>
 *
 *
 *  Return Value:
 *  None
 *
 *  Example:
 *  [ace_player] call KJW_TwoSecondaryWeapons_fnc_validateWeapons
 *
 *  Public: No
 */

params ["_unit"];

private _primarySecondaryWeapon = (_unit getVariable [QGVAR(primarySecondaryInfo),[]]) select 0;
private _secondSecondaryWeapon = (_unit getVariable [QGVAR(secondSecondaryInfo),[]]) select 0;

private _primaryIsValid = true;
private _secondaryIsValid = true;
if (!(isNil {_primarySecondaryWeapon})) then {
	private _weaponLowered = toLowerANSI _primarySecondaryWeapon;
	private _whitelist = (parseSimpleArray GVAR(whitelistedClasses) apply {toLowerANSI _x});
	private _blacklist = (parseSimpleArray GVAR(blacklistedClasses) apply {toLowerANSI _x});
	private _whitelistHasValues = (count _whitelist) > 0;

	private _matchesWhitelist = (!_whitelistHasValues) || (_weaponLowered in _whitelist);
	private _matchesBlacklist = _weaponLowered in _blacklist;

	_primaryIsValid = (!_matchesBlacklist) && _matchesWhitelist;
};

if (!(isNil {_secondSecondaryWeapon})) then {
	private _weaponLowered = toLowerANSI _secondSecondaryWeapon;
	private _whitelist = (parseSimpleArray GVAR(whitelistedClasses) apply {toLowerANSI _x});
	private _blacklist = (parseSimpleArray GVAR(blacklistedClasses) apply {toLowerANSI _x});
	private _whitelistHasValues = (count _whitelist) > 0;

	private _matchesWhitelist = (!_whitelistHasValues) || (_weaponLowered in _whitelist);
	private _matchesBlacklist = _weaponLowered in _blacklist;

	_secondaryIsValid = (!_matchesBlacklist) && _matchesWhitelist;
};

if !_primaryIsValid then {
	_unit setVariable [QGVAR(primarySecondaryInfo),nil]
};

if !_secondaryIsValid then {
	_unit setVariable [QGVAR(secondSecondaryInfo),nil]
};
