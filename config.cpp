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

/*
    Backend:
    press 6
    get pistol animation plays
    current pistol data is saved
    data is attachto'd on all pistol proxies on ur vest
    data from your second secondary is set to ur current weapon
    press 6
    put pistol animation plays
    pistol data loaded back to ur secondary



*/