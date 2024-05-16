#include "script_component.hpp"
/*
 *  Author: KJW
 * 
 *  Format of
 *  private _weapon = handgun player;
 *  private _weaponInfo = ((weaponsItems player) select {_x#0 isEqualTo _weapon})#0;
 * 
 *  Arguments:
 *  0: Objects <ARRAY>
 *  1: All <BOOL>
 * 
 *  Return Value:
 *  None
 * 
 *  Example:
 *  [_weaponInfo] call KJW_TwoSecondaryWeapons_fnc_addSecondWeapon
 * 
 *  Public: Yes
 */

params ["_weaponInfo"];

private _secondSecondaryEquipped = player getVariable [QGVAR(secondSecondaryEquipped),false];

if (_secondSecondaryEquipped) then {
    player setVariable [QGVAR(primarySecondaryInfo),_weaponInfo,true];
} else {
    player setVariable [QGVAR(secondSecondaryInfo),_weaponInfo,true];
};

call FUNC(updateShownWeapon);