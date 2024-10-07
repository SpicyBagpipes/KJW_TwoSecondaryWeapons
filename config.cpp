#include "macro_function.hpp"

class CfgPatches {
    class COMPONENT {
        author="KJW";
        requiredAddons[]=
        {
            "A3_Data_F",
            "A3_Weapons_F",
            "A3_Characters_F",
            "A3_Data_F_AoW_Loadorder"
        };
        requiredVersion=1;
		units[] = {""};
		weapons[] = {""};
		vehicles[] = {""};
	};
};

class CfgFunctions {
    class KJW_TwoSecondaryWeapons {
        class functions {
            FUNCTION_DECLARE(addCBAKeybinds)
            FUNCTION_DECLARE(addSettings)
            FUNCTION_DECLARE(addEventHandlers)
            FUNCTION_DECLARE(switchSecondaryHandler)
            FUNCTION_DECLARE(updateShownWeapon)
            FUNCTION_DECLARE(addSecondWeapon)
            FUNCTION_DECLARE(validateWeapons)
        };
    };
};

class Extended_PostInit_EventHandlers {
	class COMPONENT_POSTINIT {
		init = QUOTE(call compileScript ['COMPONENT\XEH_PostInit.sqf']);
	};
};

class Extended_PreInit_EventHandlers {
	class COMPONENT_PREINIT {
		init = QUOTE(call compileScript ['COMPONENT\XEH_PreInit.sqf']);
	};
};

class CfgVehicles
{
	class CargoNet_01_box_F;
	class GVAR(GWH): CargoNet_01_box_F
	{
        scope = 1;
		model="\A3\Weapons_f\DummyWeapon_Single.p3d";
		showWeaponCargo=1;
	};
};