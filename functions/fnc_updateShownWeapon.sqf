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
private _currentPositionSelection = GVAR(selectedPosition);
private _positions = [_currentPositionSelection];
private _objects = [];

{
	deleteVehicle _x;
} forEach _currentWeaponObjects;
if (_weaponInfo isEqualTo [] || {(!(GVAR(showHolstered)))}) exitWith {};
{
	private _holder = createVehicle ["GroundWeaponHolder",[0,0,0]];
	_holder addWeaponWithAttachmentsCargoGlobal [_weaponInfo, 1];
	_holder setDamage 1;
	_holder attachTo [player, _x#2, _x#0, true];
	_holder setVectorDirAndUp _x#1;
	_objects pushBack _holder;
} forEach _positions;
player setVariable [QGVAR(currentWeaponObjects),_objects];

/*
	Positions array:
	[mempoint,vectordirandup,position]
*/