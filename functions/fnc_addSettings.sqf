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
private _positions = [
	[ 
		"pelvis", //Mempoint 
		[ 
			[-0.770787,-0.0117306,0.636797], //VectorDir 
			[0.095098,0.986385,0.133278]  //VectorUp 
		], 
		[0.001263,-0.098181,0.000453] //Position relative to player 
	],
	[
		"pelvis", //Mempoint
		[
			[-0.936274,-0.066636,0.344852], //VectorDir
			[-0.125986,0.980204,-0.152648]  //VectorUp
		],
		[-0.0007754,0.120279,-0.0288749] //Position relative to player
	],
	[
		"rightupleg",
		[
			[-0.501943,0.851872,0.149468],
			[0.840361,0.521234,-0.1486]
		],
		[0.041241,0.081639,-0.0639336]
	],
	[
		"spine3", //Mempoint
		[
			[-0.166655,-0.496812,0.851691], //VectorDir
			[-0.9607,-0.112603,-0.25367]  //VectorUp
		],
		[-0.193477,-0.0006439,-0.004554] //Position relative to player
	],
	[
		"spine3", //Mempoint
		[
			[-0.942853,0.330874,0.0362221], //VectorDir
			[-0.33272,-0.939935,-0.0747082] //VectorUp
		],
		[-0.215057,-0.176157,-0.136247] //Position relative to player
	],
	[
		"pelvis", //Mempoint
		[
			[-0.713304,0.700795,-0.00756299], //VectorDir
			[0.698764,0.710324,-0.0845198]  //VectorUp
		],
		[-0.163846,-0.163029,-0.1981146] //Position relative to player
	],
	[
		[]
	]
];

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
		_positions, //Values
		["Small of Back","Appendix","Pocket","Boomer", "Second Rifle", "Breacher", "Disabled"], //Displaynames.
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
		_positions, //Values
		["Small of Back","Appendix","Pocket","Boomer", "Second Rifle", "Breacher", "Disabled"], //Displaynames.
		0
	], //Setting properties. Varies based on type
	0, //1: all clients share the same setting, 2: setting can’t be overwritten
	{call FUNC(updateShownWeapon)}, //Code to execute upon setting change
	false //Requires restart?
] call CBA_fnc_addSetting;