#include "..\macro_general.hpp"
/*
 *  Author: KJW
 * 
 *  Adds CBA Settings required for the mod to function.
 * 
 *  Arguments:
 *  None
 * 
 *  Return Value:
 *  None
 * 
 *  Example:
 *  call KJW_TwoSecondaryWeapons_fnc_addSettings
 * 
 *  Public: No
 */

private _arr = [];
private _componentBeautified = QUOTE(COMPONENT_BEAUTIFIED);

[
	QGVAR(Enabled), //Setting classname
	"CHECKBOX", //Setting type. Can be CHECKBOX, LIST, SLIDER, COLOR, EDITBOX, TIME
	[
		"Enable Two Secondary Weapons", //Display name
		"Stops keybind from working. Does NOT remove currently equipped second secondary." //Tooltip
	],
	_componentBeautified, //Category
	true, //Setting properties. Varies based on type
	1, //1: all clients share the same setting, 2: setting can’t be overwritten
	{}, //Code to execute upon setting change
	false //Requires restart?
] call CBA_fnc_addSetting;

[
	QGVAR(blacklistedClasses), //Setting classname
	"EDITBOX", //Setting type. Can be CHECKBOX, LIST, SLIDER, COLOR, EDITBOX, TIME
	[
		"Blacklisted Classes", //Display name
		"Secondaries will not be able to be equipped as second secondaries if they are in this array. Array of string classnames." //Tooltip
	],
	_componentBeautified, //Category
	str _arr, //Setting properties. Varies based on type
	1, //1: all clients share the same setting, 2: setting can’t be overwritten
	{}, //Code to execute upon setting change
	false //Requires restart?
] call CBA_fnc_addSetting;

[
	QGVAR(whitelistedClasses), //Setting classname
	"EDITBOX", //Setting type. Can be CHECKBOX, LIST, SLIDER, COLOR, EDITBOX, TIME
	[
		"Whitelisted Classes", //Display name
		"Secondaries will be able to be equipped as second secondaries if they are in this array. Array of string classnames. If empty, all weapons not blacklisted will be allowed" //Tooltip
	],
	_componentBeautified, //Category
	str _arr, //Setting properties. Varies based on type
	1, //1: all clients share the same setting, 2: setting can’t be overwritten
	{}, //Code to execute upon setting change
	false //Requires restart?
] call CBA_fnc_addSetting;

[
	QGVAR(selectedPositionPrimary), //Setting classname
	"LIST", //Setting type. Can be CHECKBOX, LIST, SLIDER, COLOR, EDITBOX, TIME
	[
		"Selected Position (First Secondary)", //Display name
		"Selected Position for first Secondary to appear." //Tooltip
	],
	_componentBeautified, //Category
	[
		GVAR(positions), //Values
		GVAR(displayNames),
		0
	], //Setting properties. Varies based on type
	0, //1: all clients share the same setting, 2: setting can’t be overwritten
	{call FUNC(updateShownWeapon)}, //Code to execute upon setting change
	false //Requires restart?
] call CBA_fnc_addSetting;

[
	QGVAR(selectedPositionSecondary), //Setting classname
	"LIST", //Setting type. Can be CHECKBOX, LIST, SLIDER, COLOR, EDITBOX, TIME
	[
		"Selected Position (Second Secondary)", //Display name
		"Selected Position for second Secondary to appear." //Tooltip
	],
	_componentBeautified, //Category
	[
		GVAR(positions), //Values
		GVAR(displayNames),
		0
	], //Setting properties. Varies based on type
	0, //1: all clients share the same setting, 2: setting can’t be overwritten
	{call FUNC(updateShownWeapon)}, //Code to execute upon setting change
	false //Requires restart?
] call CBA_fnc_addSetting;