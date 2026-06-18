//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, June 2020
//////////////////////////////////////////

#define GUI_GRID_WAbs ((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_HAbs (GUI_GRID_WAbs / 1.2)
#define GUI_GRID_W (GUI_GRID_WAbs / 40)
#define GUI_GRID_H (GUI_GRID_HAbs / 25)
#define GUI_GRID_X (safezoneX)
#define GUI_GRID_Y (safezoneY + safezoneH - GUI_GRID_HAbs)
#define GUI_T_W GUI_GRID_W*30
#define GUI_T_H GUI_GRID_H*6
#define GUI_A_X 0.5-(GUI_T_W*0.5)
#define GUI_A_Y 0.5-(GUI_T_H*0.5)

disableSerialization;

// startLoadingScreen [" "];

_2nddisplay = ((uiNameSpace getVariable "gm_wfor_squadManagementDisplay") createDisplay "RscCredits");

uiNameSpace setVariable ["gm_wfor_squadManagement_createDisplay", _2nddisplay];

// Build Backgrounds
_c = [];
_bg = _2nddisplay ctrlCreate ["RscBackgroundGUI", -1]; _bg ctrlSetPosition [GUI_A_X,GUI_A_Y,GUI_T_W,GUI_T_H]; _c pushBack _bg;
_bg = _2nddisplay ctrlCreate ["RscBackgroundGUITop", -1];_bg ctrlSetText "Enter Group Callsign";_bg ctrlSetPosition [GUI_A_X,GUI_A_Y,GUI_T_W,GUI_GRID_H]; _c pushBack _bg;

// vic attributes array
_edit = _2nddisplay ctrlCreate ["RscEdit", 250];
_edit ctrlSetPosition [GUI_A_X+GUI_GRID_W*5,GUI_A_Y+GUI_GRID_H*1.5,GUI_GRID_W*20,GUI_GRID_H];
_edit ctrlSetBackgroundColor [0,0,0,1];
_edit ctrlCommit 0;
_edit ctrlSetText format ["New %1 Group", gm_wfor_shopSide];
_edit ctrlSetTooltip "Enter a group callsign.";
ctrlSetFocus _edit;

_exit = _2nddisplay ctrlCreate ["RscActivePicture", 2];
_exit ctrlSetText "A3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_exit_cross_ca.paa";
_exit ctrlSetPosition [GUI_A_X+GUI_T_W-GUI_GRID_W,GUI_A_Y,GUI_GRID_W,GUI_GRID_H];
_exit ctrlSetTooltip "Exit";
_c pushBack _exit;

// Create Button
_joinBut = _2nddisplay ctrlCreate ["RscButton", 1];
_joinBut ctrlSetPosition [GUI_A_X+GUI_GRID_W*10.25,GUI_A_Y+GUI_T_H-GUI_GRID_H*2.5,GUI_GRID_W*9.25,GUI_GRID_H*2];
_joinBut ctrlSetText "Create";
_joinBut ctrlSetTooltip "Create a new group.";

// buttonaction doesnt allow the uiNamespace to be accessed for some reason, very strange behaviour
_joinBut ctrlAddEventhandler
[
	"ButtonClick",
	{
		_oldGroup = group player;
		_group = createGroup [side player, true];
		[player] joinSilent _group;
		if ((count (units _oldGroup)) == 0) then {deleteGroup _oldGroup};
		_t = ctrlText ((uiNameSpace getVariable "gm_wfor_squadManagement_createDisplay") displayCtrl 250);
		if (_t == '') then
		{
			_t = format ['New %1 Group', gm_wfor_shopSide]
		};
		[_group, [_t]] remoteExecCall ["setGroupID", 0, true];
		gm_temp_squadManagement_forceUpdate = true;
	}
];

_c pushBack _joinBut;

{_x ctrlCommit 0} forEach _c;