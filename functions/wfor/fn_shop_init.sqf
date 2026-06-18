//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, Dec 2019
//////////////////////////////////////////

#define GUI_GRID_WAbs ((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_HAbs (GUI_GRID_WAbs / 1.2)
#define GUI_GRID_W (GUI_GRID_WAbs / 40)
#define GUI_GRID_H (GUI_GRID_HAbs / 25)
#define GUI_GRID_X (safezoneX)
#define GUI_GRID_Y (safezoneY + safezoneH - GUI_GRID_HAbs)
#define GUI_T_W GUI_GRID_W*40
#define GUI_T_H GUI_GRID_H*25
#define GUI_A_X 0.5-(GUI_T_W*0.5)
#define GUI_A_Y 0.5-(GUI_T_H*0.5)

disableSerialization;

params [["_shopLocation", objNull]];

// startLoadingScreen [" "];

_display = findDisplay 46 createDisplay "RscCredits";
_display displayAddEventHandler
[
	"KeyDown",
	{
		gm_wfor_shop_shift = (_this select 2);
		gm_wfor_shop_ctrl = (_this select 3);
		gm_wfor_shop_alt = (_this select 4);
	}
];
_display displayAddEventHandler
[
	"KeyUp",
	{
		gm_wfor_shop_shift = false;
		gm_wfor_shop_ctrl = false;
		gm_wfor_shop_alt = false;
	}
];

uiNameSpace setVariable ["gm_wfor_shop", _display];
_budget = missionNameSpace getVariable ["gm_wfor_budget", gm_wfor_startingBudget];

// Build Backgrounds
_c = [];
_bg = _display ctrlCreate ["RscBackgroundGUI", -1]; _bg ctrlSetPosition [GUI_A_X,GUI_A_Y,GUI_T_W,GUI_T_H]; _c pushBack _bg;
_bg = _display ctrlCreate ["RscBackgroundGUITop", -1];_bg ctrlSetText "Supplies";_bg ctrlSetPosition [GUI_A_X,GUI_A_Y,GUI_T_W,GUI_GRID_H]; _c pushBack _bg;
_bg = _display ctrlCreate ["RscBackgroundGUITop", 500];_bg ctrlSetText format["0 %2 / %1 %2", _budget, gm_wfor_currency_symbol];_bg ctrlSetPosition [GUI_A_X+GUI_GRID_W*20.25,GUI_A_Y+GUI_T_H-GUI_GRID_H*4,GUI_GRID_W*19,GUI_GRID_H]; _c pushBack _bg;
_bg ctrlSetToolTip "Use the SHIFT key to add/remove batches of 10.";
_bg = _display ctrlCreate ["RscBackgroundGUITop", -1];_bg ctrlSetText "Double-Click on items to add them to the basket.";_bg ctrlSetPosition [GUI_A_X+GUI_GRID_W*0.75,GUI_A_Y+GUI_GRID_H*23.5,GUI_GRID_W*19,GUI_GRID_H]; _c pushBack _bg;

_exit = _display ctrlCreate ["RscActivePicture", 2];
_exit ctrlSetText "A3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_exit_cross_ca.paa";
_exit ctrlSetPosition [GUI_A_X+GUI_GRID_W*39,GUI_A_Y,GUI_GRID_W,GUI_GRID_H];
_exit ctrlSetTooltip "Exit";
_c pushBack _exit;

{_x ctrlCommit 0} forEach _c;

// Build controls
[_display,200] call gm_wfor_fnc_shop_cart;
[_display,100,_shopLocation] call gm_wfor_fnc_shop_displayContent;

// endLoadingScreen;
