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
#define GUI_T_W GUI_GRID_W*20
#define GUI_T_H ((safeZoneH*0.5)-GUI_GRID_H*1.5)
#define GUI_A_X (safezoneX + GUI_GRID_W)
#define GUI_A_Y (safezoneY + GUI_GRID_H)

disableSerialization;

_display = findDisplay 46 createDisplay "RscCredits";

uiNameSpace setVariable ["gm_wfor_peronalCustomizer", _display];

gm_wfor_pc_camera = "camera" camCreate (player modelToWorld [-1,1,1.8]);
gm_wfor_pc_camera camSetTarget player;
gm_wfor_pc_camera cameraEffect ["internal", "BACK"];
gm_wfor_pc_camera camCommit 0;
showCinemaBorder false;

player playAction "Civil";

// local saver for respawn persistance
if isNil "gm_wfor_pc_data" then {gm_wfor_pc_data = [face player, ""]};

_display displayAddEventHandler
[
	"Unload",
	{
		gm_wfor_pc_camera cameraEffect ["terminate","back"];
		camDestroy gm_wfor_pc_camera;
	}
];

// Build Backgrounds
_c = [];
_bg = _display ctrlCreate ["RscBackgroundGUI", -1]; _bg ctrlSetPosition [GUI_A_X,GUI_A_Y,GUI_T_W,GUI_T_H]; _c pushBack _bg;
_bg = _display ctrlCreate ["RscBackgroundGUITop", -1];_bg ctrlSetText "Select Face";_bg ctrlSetPosition [GUI_A_X,GUI_A_Y,GUI_T_W,GUI_GRID_H]; _c pushBack _bg;

_bg = _display ctrlCreate ["RscBackgroundGUI", -1]; _bg ctrlSetPosition [GUI_A_X,GUI_A_Y+GUI_T_H+GUI_GRID_H,GUI_T_W,GUI_T_H]; _c pushBack _bg;
_bg = _display ctrlCreate ["RscBackgroundGUITop", -1];_bg ctrlSetText "Select Armpatch";_bg ctrlSetPosition [GUI_A_X,GUI_A_Y+GUI_T_H+GUI_GRID_H,GUI_T_W,GUI_GRID_H]; _c pushBack _bg;


_exit = _display ctrlCreate ["RscActivePicture", 2];
_exit ctrlSetText "A3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_exit_cross_ca.paa";
_exit ctrlSetPosition [GUI_A_X+GUI_T_W-GUI_GRID_W,GUI_A_Y,GUI_GRID_W,GUI_GRID_H];
_exit ctrlSetTooltip "Exit";
_c pushBack _exit;

// list of faces
_lbFaces = _display ctrlCreate ["RscListBox", 55];
_lbFaces ctrlSetPosition [GUI_A_X+GUI_GRID_W*0.5,GUI_A_Y+GUI_GRID_H*1.5,GUI_T_W-GUI_GRID_W,GUI_T_H-GUI_GRID_H*2];
_lbFaces ctrlSetBackgroundColor [0,0,0,1];
_c pushBack _lbFaces;

// list of armpatches
_lbPatches = _display ctrlCreate ["RscListBox", 55];
_lbPatches ctrlSetPosition [GUI_A_X+GUI_GRID_W*0.5,GUI_A_Y+GUI_T_H+GUI_GRID_H*2.5,GUI_T_W-GUI_GRID_W,GUI_T_H-GUI_GRID_H*2];
_lbPatches ctrlSetBackgroundColor [0,0,0,1];
_c pushBack _lbPatches;
{_x ctrlCommit 0} forEach _c;

// fill list with faces
{
	_i = _lbFaces lbAdd (getText (_x >> "DisplayName"));
	_cname = configName _x;
	_lbFaces lbSetData [_i, _cname];
	_lbFaces lbSetPictureRight [_i, getText (configFile >> "CfgMods" >> (configSourceMod _x) >> "logoSmall")];
} forEach ("(getNumber (_x >> 'disabled')) != 1" configClasses (configfile >> "CfgFaces" >> "Man_A3"));
lbSort _lbFaces;
// Go through a now sorted list and highlight the current
for "_i" from 0 to ((lbSize _lbFaces) -1) do
{
	if (toLower (face player) == (toLower (_lbFaces lbData _i))) then {_lbFaces lbSetCurSel _i};
};

// fill list with armpatches

// create default
_i = _lbPatches lbAdd "None";
_lbPatches lbSetData [_i, ""];
_lbPatches lbSetCurSel 0;
{
	_i = _lbPatches lbAdd (getText (_x >> "DisplayName"));
	_cname = configName _x;
	_lbPatches lbSetPicture [_i, (getText (_x >> "Texture"))];
	_lbPatches lbSetData [_i, _cname];
	_lbPatches lbSetPictureRight [_i, getText (configFile >> "CfgMods" >> (configSourceMod _x) >> "logoSmall")];
	if (player call BIS_fnc_getUnitInsignia == _cname) then {_lbFaces lbSetCurSel _forEachIndex};
} forEach ("true" configClasses (configfile >> "CfgUnitInsignia"));

_lbFaces ctrlAddEventHandler
[
	"LBDblClick",
	{
		params ["_control", "_idx"];
		[player, (_control lbData _idx)] remoteExec ["setFace", 0, true];
		gm_wfor_pc_data set [0, (_control lbData _idx)];
	}
];

_lbPatches ctrlAddEventHandler
[
	"LBDblClick",
	{
		params ["_control", "_idx"];
		[player,(_control lbData _idx)] call BIS_fnc_setUnitInsignia;
		gm_wfor_pc_data set [1, (_control lbData _idx)];
	}
];