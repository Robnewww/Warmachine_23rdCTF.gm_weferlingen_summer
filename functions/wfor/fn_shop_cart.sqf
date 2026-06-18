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

params ["_display","_idBase"];

private ["_lb"];
// vic attributes array
_lb = _display ctrlCreate ["RscListBox", _idBase];
_lb ctrlSetPosition [GUI_A_X+GUI_GRID_W*20.25,GUI_A_Y+GUI_GRID_H*11.5,GUI_GRID_W*19,GUI_GRID_H*9];
_lb ctrlSetBackgroundColor [0,0,0,1];
_lb ctrlCommit 0;

_lb ctrlAddEventhandler ["lbDblClick", "(_this + [-1]) call gm_wfor_fnc_shop_cart_add"];
_lb ctrlAddEventhandler ["LBSelChanged", "(_this + [-1]) call gm_wfor_fnc_shop_cart_show"];

_bg = _display ctrlCreate ["RscBackgroundGUI", -1];
_bg ctrlSetPosition [GUI_A_X+GUI_GRID_W*20.25,GUI_A_Y+GUI_GRID_H*1.5,GUI_GRID_W*19,GUI_GRID_H*9.5];
_bg ctrlSetBackgroundColor [0,0,0,0.5];
_bg ctrlCommit 0;

_picture = _display ctrlCreate ["RscPictureKeepAspect", 651];
_picture ctrlSetPosition [GUI_A_X+GUI_GRID_W*20.5,GUI_A_Y+GUI_GRID_H*1.75,GUI_GRID_W*18.5,GUI_GRID_H*9];
_picture ctrlSetBackgroundColor [0,0,0,0];
_picture ctrlCommit 0;