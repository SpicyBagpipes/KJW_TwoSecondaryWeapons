#include "script_component.hpp"
/*
 *  Author: KJW
 * 
 *  Adds CBA keybindings required for the mod to function.
 * 
 *  Arguments:
 *  None
 * 
 *  Return Value:
 *  None
 * 
 *  Example:
 *  call KJW_TwoSecondaryWeapons_fnc_addCBAKeybinds
 * 
 *  Public: No
 */


#include "\a3\ui_f\hpp\defineDIKCodes.inc"

[
	QUOTE(COMPONENT_BEAUTIFIED),
	QGVAR(SwitchToSecondary),
	[
		"Switch to Second Secondary",
		"Switch to second secondary weapon"
	],
	{
		if (commandingMenu isNotEqualTo "") exitWith {};
    	private _delay = if (currentWeapon player isEqualTo "") then {
			0.1
		} else {
			1.4
		};
		[_delay] call FUNC(switchSecondaryHandler)
	},
	{
    	//Keyup
	},
	[
		DIK_5,
		[
			false,
			false,
			false
		]
	]
] call CBA_fnc_addKeybind;