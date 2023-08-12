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
		[0.171263,0.488181,0.160453] //Position relative to player 
	],
	[
		"pelvis", //Mempoint
		[
			[-0.936274,-0.066636,0.344852], //VectorDir
			[-0.125986,0.980204,-0.152648]  //VectorUp
		],
		[-0.0667754,0.734279,-0.0288749] //Position relative to player
	],
	[
		"rightupleg",
		[
			[-0.501943,0.851872,0.149468],
			[0.840361,0.521234,-0.1486]
		],
		[0.611241,0.381639,-0.0639336]
	],
	[
		"spine3", //Mempoint
		[
			[-0.166655,-0.496812,0.851691], //VectorDir
			[-0.9607,-0.112603,-0.25367]  //VectorUp
		],
		[-0.773477,0.0096439,-0.084554] //Position relative to player
	],
	[
		"spine3", //Mempoint
		[
			[-0.775624,0.621418,0.110659],
			[-0.630396,-0.771462,-0.086297]
		],  //VectorUp
		[-0.621984,-0.59026,-0.299307] //Position relative to player
	],
	[
		"pelvis", //Mempoint
		[
			[-0.706214,0.702444,-0.0883572], //VectorDir
			[0.703818,0.710086,0.019806] //VectorUp
		],
		[0.273846,0.279029,-0.0831146] //Position relative to player
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
	QGVAR(ShowHolstered), //Setting classname
	"CHECKBOX", //Setting type. Can be CHECKBOX, LIST, SLIDER, COLOR, EDITBOX, TIME
	[
		"Show Holstered Secondaries", //Display name
		"Stops holstered second secondaries from showing." //Tooltip
	],
	_componentBeautified, //Category
	true, //Setting properties. Varies based on type
	1, //1: all clients share the same setting, 2: setting can’t be overwritten
	{call FUNC(updateShownWeapon)}, //Code to execute upon setting change
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
		["Small of Back","Appendix","Pocket","Boomer", "Second Rifle", "Breacher"], //Displaynames.
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
		["Small of Back","Appendix","Pocket","Boomer", "Second Rifle", "Breacher"], //Displaynames.
		0
	], //Setting properties. Varies based on type
	0, //1: all clients share the same setting, 2: setting can’t be overwritten
	{call FUNC(updateShownWeapon)}, //Code to execute upon setting change
	false //Requires restart?
] call CBA_fnc_addSetting;