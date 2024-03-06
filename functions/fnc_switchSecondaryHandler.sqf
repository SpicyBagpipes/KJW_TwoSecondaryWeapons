#include "script_component.hpp"
/*
 *  Author: KJW
 * 
 *  Handles switching secondary.
 * 
 *  Arguments:
 *  0: Delay <NUMBER>
 * 
 *  Return Value:
 *  None
 * 
 *  Example:
 *  [1.4] call KJW_TwoSecondaryWeapons_fnc_switchSecondaryHandler
 * 
 *  Public: Yes
 */


params ["_delay"];

private _weapon = handgunWeapon player;
private _systemEnabled = GVAR(Enabled);
private _weaponIsValid = true;
if (_systemEnabled && (_weapon isNotEqualTo "")) then {
	private _weaponLowered = toLowerANSI _weapon;
	private _whitelist = (parseSimpleArray GVAR(whitelistedClasses) apply {toLowerANSI _x});
	private _blacklist = (parseSimpleArray GVAR(blacklistedClasses) apply {toLowerANSI _x});
	private _whitelistHasValues = (count _whitelist) > 0;

	private _matchesWhitelist = (!_whitelistHasValues) || (_weaponLowered in _whitelist);
	private _matchesBlacklist = _weaponLowered in _blacklist;

	_weaponIsValid = (!_matchesBlacklist) && _matchesWhitelist;
};

if ((!_systemEnabled) || (!_weaponIsValid)) exitWith {};

private _secondSecondaryEquipped = player getVariable [QGVAR(secondSecondaryEquipped),false];
if (_secondSecondaryEquipped) then {
	//De-equip second secondary.
	private _secondSecondaryInfo = ((weaponsItems player) select {_x#0 isEqualTo _weapon})#0;
	player action ["SwitchWeapon", player, player, 299]; //Put weapon away action.
	player setVariable [QGVAR(secondSecondaryInfo), _secondSecondaryInfo];
	[
		{
			params ["_weapon"];
			private _primarySecondaryInfo =+ (player getVariable [QGVAR(primarySecondaryInfo),[]]);
			player removeWeaponGlobal _weapon;
			player addWeaponGlobal _primarySecondaryInfo#0;
			_primarySecondaryInfo deleteAt 0;
			private _autoLoadedMagazine = handgunMagazine player;
			private _autoLoadedMagazineCount = player ammo handgunWeapon player;
			{
				if (_x isEqualTo []) then {continue};
				if (typeName _x isEqualTo "ARRAY") then {
					if (_autoLoadedMagazine isEqualTo []) then {
						player addHandgunItem _x#0;
						player setAmmo [handgunWeapon player, _x#1];
					} else {
						[player, _x#0,_x#1, true] call CBA_fnc_addMagazine;
					};
				} else {
					player addHandgunItem _x;
				};
			} forEach _primarySecondaryInfo;
			player setVariable [QGVAR(secondSecondaryEquipped), false];
			if (handgunWeapon player isNotEqualTo "") then {
				private _muzzleIndex = (player weaponsInfo [handgunWeapon player, false])#0#0;
				player action ["SwitchWeapon", player, player, _muzzleIndex];
			};
			if (vehicle player != player) exitWith {}; //Player is in vehicle.
			call FUNC(updateShownWeapon);
		},
		[
			_weapon
		],
		_delay
	] call CBA_fnc_waitAndExecute;
} else {
	//Equip second secondary.
	private _weapon = handgunWeapon player;
	private _primarySecondaryInfo = ((weaponsItems player) select {_x#0 isEqualTo _weapon})#0;
	private _shouldBeshown = getNumber (configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "holsterScale") isNotEqualTo 0;
	player action ["SwitchWeapon", player, player, 299]; //Put weapon away action.
	player setVariable [QGVAR(primarySecondaryInfo), _primarySecondaryInfo];
	[
		{
			params["_weapon"];
			private _secondSecondaryInfo =+ (player getVariable [QGVAR(secondSecondaryInfo),[]]);
			player removeWeaponGlobal _weapon;
			player addWeaponGlobal _secondSecondaryInfo#0;
			_secondSecondaryInfo deleteAt 0;
			private _autoLoadedMagazine = handgunMagazine player;
			private _autoLoadedMagazineCount = player ammo handgunWeapon player;
			{
				if (_x isEqualTo []) then {continue};
				if (typeName _x isEqualTo "ARRAY") then {
					if (_autoLoadedMagazine isEqualTo []) then {
						player addHandgunItem _x#0;
						player setAmmo [handgunWeapon player, _x#1];
					} else {
						[player, _x#0,_x#1, true] call CBA_fnc_addMagazine;
					};
				} else {
					player addHandgunItem _x;
				};
			} forEach _secondSecondaryInfo;
			player setVariable [QGVAR(secondSecondaryEquipped), true];
			if (handgunWeapon player isNotEqualTo "") then {
				private _muzzleIndex = (player weaponsInfo [handgunWeapon player, false])#0#0;
				player action ["SwitchWeapon", player, player, _muzzleIndex];
			};
			if (vehicle player != player) exitWith {}; //Player is in vehicle.
			call FUNC(updateShownWeapon);
		},
		[
			_weapon
		],
		_delay
	] call CBA_fnc_waitAndExecute;
};
