#include "script_component.hpp"
/*
 *  Author: KJW
 * 
 *  Adds event handlers required for the mod to function.
 * 
 *  Arguments:
 *  None
 * 
 *  Return Value:
 *  None
 * 
 *  Example:
 *  call KJW_TwoSecondaryWeapons_fnc_addEventHandlers
 * 
 *  Public: No
 */


[
	"loadout",
	{
		private _secondSecondaryEquipped = player getVariable [QGVAR(secondSecondaryEquipped),false];
		private _weapon = handgunWeapon player;
		if (_secondSecondaryEquipped) then {
			//If player has second secondary weapon equipped, update second secondary weapon info variable.
			private _secondSecondaryInfo = ((weaponsItems player) select {_x#0 isEqualTo _weapon})#0;
			player setVariable [QGVAR(secondSecondaryInfo),_secondSecondaryInfo,true];
		} else {
			//If player has primary secondary weapon equipped, update primary secondary weapon info variable.
			private _primarySecondaryInfo = ((weaponsItems player) select {_x#0 isEqualTo _weapon})#0;
			player setVariable [QGVAR(primarySecondaryInfo),_primarySecondaryInfo,true];
		};
	}
] call CBA_fnc_addPlayerEventHandler;

player addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	if (_unit isNotEqualTo player) exitWith {};
	private _secondSecondaryEquipped = player getVariable [QGVAR(secondSecondaryEquipped),false];
	private _weaponInfo = if (_secondSecondaryEquipped) then {
		player getVariable [QGVAR(primarySecondaryInfo),[]];
	} else {
		player getVariable [QGVAR(secondSecondaryInfo),[]];
	};
	player setVariable [QGVAR(secondSecondaryInfo),[],true];
	player setVariable [QGVAR(primarySecondaryInfo),[],true];
	player setVariable [QGVAR(secondSecondaryEquipped),false,true];
	private _objects = player getVariable [QGVAR(currentWeaponObjects),[]];
	if (_objects isEqualTo []) exitWith {}; // No other guns.
	{
		if (GVAR(addACEweight)) then {
			private _weaponMass = _x getVariable [QGVAR(mass), 0];
			[player, player, -_weaponMass] call ace_movement_fnc_addLoadToUnitContainer;
		};
		deleteVehicle _x;
	} forEach _objects;
	player setVariable [QGVAR(currentWeaponObjects),[]];
	private _holder = createVehicle ["WeaponHolderSimulated",[0,0,0]];
	_holder addWeaponWithAttachmentsCargoGlobal [_weaponInfo, 1];
	_holder setPosASL (getPosASL _unit);
}];

["CBA_loadoutSet", {
	if (is3DEN) exitWith {};
	params ["_unit", "_loadout", "_extradata"];
	private _secondSecondaryInfo = _extradata getOrDefault [QGVAR(secondSecondaryInfo),[]];
	private _primarySecondaryInfo = _extradata getOrDefault [QGVAR(primarySecondaryInfo),[]];
	private _secondSecondaryEquipped = _extradata getOrDefault [QGVAR(secondSecondaryEquipped),false];
	_unit setVariable [QGVAR(secondSecondaryInfo), _secondSecondaryInfo,true];
	_unit setVariable [QGVAR(primarySecondaryInfo), _primarySecondaryInfo,true];
	_unit setVariable [QGVAR(secondSecondaryEquipped),_secondSecondaryEquipped,true];
	call FUNC(validateWeapons);
	call FUNC(updateShownWeapon);
}] call CBA_fnc_addEventHandler;

["CBA_loadoutGet", {
	if (is3DEN) exitWith {};
	params ["_unit", "_loadout", "_extradata"];
	private _primarySecondaryInfo =+ (_unit getVariable [QGVAR(primarySecondaryInfo), []]);
	private _secondSecondaryInfo =+ (_unit getVariable [QGVAR(secondSecondaryInfo), []]);
	private _secondSecondaryEquipped = _unit getVariable [QGVAR(secondSecondaryEquipped),false];
	_extradata set [QGVAR(primarySecondaryInfo), _primarySecondaryInfo];
	_extradata set [QGVAR(secondSecondaryInfo), _secondSecondaryInfo];
	_extradata set [QGVAR(secondSecondaryEquipped), _secondSecondaryEquipped];
}] call CBA_fnc_addEventHandler;

player addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	private _currentWeaponObjects = player getVariable [QGVAR(currentWeaponObjects),[]];
	{
		if (GVAR(addACEweight)) then {
			private _weaponMass = _x getVariable [QGVAR(mass), 0];
			[player, player, -_weaponMass] call ace_movement_fnc_addLoadToUnitContainer;
		};
		deleteVehicle _x;
	} forEach _currentWeaponObjects;
}];

player addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	call FUNC(updateShownWeapon);
}];

if (isServer) then {
	addMissionEventHandler ["HandleDisconnect", {
		params ["_unit", "_id", "_uid", "_name"];
		private _weaps = _unit getVariable [QGVAR(currentWeaponObjects), []];
		{
			deleteVehicle _x;
		} forEach _weaps;
	}];
};

["ace_arsenal_loadoutVerified", {
    params ["", "_extendedInfo"];
    private _kjwVarToCheck = [QGVAR(secondSecondaryInfo), QGVAR(primarySecondaryInfo)] select (_extendedInfo getOrDefault [QGVAR(secondSecondaryEquipped), false]);
    private _weaponData = _extendedInfo getOrDefault [_kjwVarToCheck, []];
    if (_weaponData isNotEqualTo []) then {
        if !((_weaponData select 0) call ace_arsenal_fnc_baseWeapon in ace_arsenal_virtualItemsFlat) then {
            _extendedInfo deleteAt _kjwVarToCheck;
        } else {
            {
                private _class = _x param [0, ""];
                private _defaultValue = ["", []] select (_x isEqualType []);
                if (_class != "" && {!(_class in ace_arsenal_virtualItemsFlat)}) then {
                    _weaponData set [_forEachIndex + 1, _defaultValue];
                };
            } forEach (_weaponData select [1]);
        };
    };
}] call CBA_fnc_addEventHandler;