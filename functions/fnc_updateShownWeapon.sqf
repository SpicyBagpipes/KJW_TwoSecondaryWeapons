#include "script_component.hpp"
/*
 *  Author: KJW
 * 
 *  Updates shown weapon based on player's currently equipped secondary.
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


private _currentWeaponObjects = player getVariable [QGVAR(currentWeaponObjects),[]];
private _secondSecondaryEquipped = player getVariable [QGVAR(secondSecondaryEquipped),false];
private _weaponInfo = if (_secondSecondaryEquipped) then {
	player getVariable [QGVAR(primarySecondaryInfo),[]];
} else {
	player getVariable [QGVAR(secondSecondaryInfo),[]];
};
private _currentPositionSelection = if (_secondSecondaryEquipped) then {
	GVAR(selectedPositionPrimary);	
} else {
	GVAR(selectedPositionSecondary);
};

if (_currentPositionSelection isEqualTo [[]]) exitWith {};

private _objects = [];

{
	if (GVAR(addACEweight)) then {
		private _weaponMass = _x getVariable [QGVAR(mass), 0];
		[player, player, -_weaponMass] call ace_movement_fnc_addLoadToUnitContainer;
	};
	deleteVehicle _x;
} forEach _currentWeaponObjects;

if (count _weaponInfo isNotEqualTo 7) exitWith {diag_log "KJW's Two Weapons | Tried to update shown weapon but weapon data was incorrectly format."; diag_log "KJW's Two Weapons | " + str _weaponInfo};

{
	private _class = if (GVAR(primariesLoaded)) then {
		"KJW_TwoPrimaryWeapons_GWH"
	} else {
		QGVAR(GWH)
	};
	private _holder = createVehicle [_class,[0,0,0]];
	_holder addWeaponWithAttachmentsCargoGlobal [_weaponInfo, 1];
	if (GVAR(addACEweight)) then {
		private _weaponMass = loadAbs _holder;
		_holder setVariable [QGVAR(mass), _weaponMass];
		[player, player, _weaponMass] call ace_movement_fnc_addLoadToUnitContainer;
	};
	_holder setDamage 1;
	_holder attachTo [player, _x#2, _x#0, true];
	_holder setVectorDirAndUp _x#1;
	_objects pushBack _holder;
} forEach _currentPositionSelection;
player setVariable [QGVAR(currentWeaponObjects), _objects, true];

/*
	Positions array:
	[mempoint,vectordirandup,position]
*/