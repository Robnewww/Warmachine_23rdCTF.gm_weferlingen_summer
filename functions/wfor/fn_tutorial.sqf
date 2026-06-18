//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, August 2021
//////////////////////////////////////////

#define GUI_GRID_WAbs ((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_HAbs (GUI_GRID_WAbs / 1.2)
#define GUI_GRID_W (GUI_GRID_WAbs / 40)
#define GUI_GRID_H (GUI_GRID_HAbs / 25)
#define GUI_GRID_X (safezoneX)
#define GUI_GRID_Y (safezoneY + safezoneH - GUI_GRID_HAbs)
#define GUI_T_W GUI_GRID_W*40
#define GUI_T_H safeZoneH - GUI_GRID_H * 8
#define GUI_A_X 0.5-(GUI_T_W*0.5)
#define GUI_A_Y safezoneY + GUI_GRID_H*5

disableSerialization;

// Start disp
_display = findDisplay 46 createDisplay "RscCredits";

_c = [];
_bg = _display ctrlCreate ["RscBackgroundGUI", -1]; _bg ctrlSetPosition [GUI_A_X,GUI_A_Y,GUI_T_W,GUI_T_H]; _c pushBack _bg;
_bg = _display ctrlCreate ["RscBackgroundGUITop", -1];_bg ctrlSetText "QUICK START GUIDE";_bg ctrlSetPosition [GUI_A_X,GUI_A_Y,GUI_T_W,GUI_GRID_H]; _c pushBack _bg;

// Picture
_exit = _display ctrlCreate ["RscActivePicture", 2];
_exit ctrlSetText "A3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_exit_cross_ca.paa";
_exit ctrlSetPosition [GUI_A_X+GUI_GRID_W*39,GUI_A_Y,GUI_GRID_W,GUI_GRID_H];
_exit ctrlSetTooltip "Exit";
_c pushBack _exit;

_html = _display ctrlCreate ["RscHTML", -1];
_html ctrlSetPosition [GUI_A_X,GUI_A_Y+GUI_GRID_H,GUI_T_W,GUI_T_H-GUI_GRID_H];
_c pushBack _html;

_okBut = _display ctrlCreate ["RscButtonMenuOK", 1];
_okBut ctrlSetPosition [GUI_A_X+GUI_T_W - GUI_GRID_W * 9.5,GUI_A_Y+GUI_T_H+GUI_GRID_H,GUI_GRID_W*9.5,GUI_GRID_H*1];
_okBut ctrlSetText "OK";
_c pushBack _okBut;

_pic = _display ctrlCreate ["RscPictureKeepAspect", 3];
_pic ctrlSetText (getText (configfile >> "CfgMods" >> "gm" >> "logo"));
_pic ctrlSetPosition [GUI_A_X+GUI_T_W-GUI_GRID_W*4,GUI_A_Y+GUI_GRID_H,GUI_GRID_W*4,GUI_GRID_H*4];
_c pushBack _pic;

{_x ctrlCommit 0} forEach _c;
_html htmlLoad "tutorial.html";

ctrlSetFocus _okBut;