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
if ((!(GVAR(Enabled))) || {_weapon in parseSimpleArray (GVAR(blacklistedClasses))}) exitWith {};

private _secondSecondaryEquipped = player getVariable [QGVAR(secondSecondaryEquipped),false];
if (_secondSecondaryEquipped) then {
	//De-equip second secondary.
	private _secondSecondaryInfo = ((weaponsItems player) select {_x#0 isEqualTo _weapon})#0;
	player action ["SwitchWeapon", player, player, 299]; //Put weapon away action.
	player setVariable [QGVAR(secondSecondaryInfo), _secondSecondaryInfo];
	[
		{
			params ["_weapon"];
			private _primarySecondaryInfo = player getVariable [QGVAR(primarySecondaryInfo),[]];
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
				private _secondSecondaryInfo = player getVariable [QGVAR(secondSecondaryInfo),[]];
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
				call FUNC(updateShownWeapon);
			},
			[
				_weapon
			],
			_delay
		] call CBA_fnc_waitAndExecute;
};