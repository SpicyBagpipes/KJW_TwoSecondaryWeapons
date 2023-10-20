#include "macro_general.hpp"
/*
 *  Author: KJW
 * 
 *  Handles relevant code to be run post init.
 * 
 *  Arguments:
 *	None
 * 
 *  Return Value:
 *  None
 * 
 *  Example:
 *  call KJW_TwoSecondaryWeapons_XEH_PostInit
 * 
 *  Public: No
 */


call FUNC(addEventHandlers);
call FUNC(addSettings);
call FUNC(addCBAKeybinds);

GVAR(primariesLoaded) = isClass (configFile >> "CfgPatches" >> "KJW_TwoPrimaryWeapons");


[[1], QGVAR(arsenalActions), "KJW's Two Weapons", [
	["text", "Text", {true}, "Swap Secondary Weapons"],
	["statement", "Statement", {true}, ""],
	["button", "Switch", {true}, "", {}, {[0.1] call FUNC(switchSecondaryHandler); [true] call ace_arsenal_fnc_refresh;}]
]] call ace_arsenal_fnc_addAction;