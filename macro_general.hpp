#define COMPONENT KJW_TwoSecondaryWeapons
#define COMPONENT_GENERAL KJW_TwoSecondaryWeapons
#define COMPONENT_SHORT KJW_TSW
#define COMPONENT_BEAUTIFIED KJW's Two Secondary Weapons
#define COMPONENT_POSTINIT COMPONENT##_PostInit
#define COMPONENT_PREINIT COMPONENT##_PreInit

#define QUOTE(P1) #P1
#define QQUOTE(P1) QUOTE(QUOTE(P1))

#define GVAR(P1) COMPONENT##_##P1
#define QGVAR(P1) QUOTE(GVAR(P1))
#define QQVAR(P1) QQUOTE(GVAR(P1))

#define EGVAR(P1,P2) P1##_##P2
#define QEGVAR(P1,P2) QUOTE(EGVAR(P1))
#define QQEGVAR(P1,P2) QQUOTE(EGVAR(P1))

#define FUNC(P1) COMPONENT_GENERAL##_fnc_##P1
#define QFUNC(P1) QUOTE(FUNC(P1))
#define QQFUNC(P1) QQUOTE(FUNC(P1))