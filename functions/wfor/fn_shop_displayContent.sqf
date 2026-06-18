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

params ["_display","_idBase","_shopLocation"];

_restrictedLimit = (if (_shopLocation isKindOf gm_wfor_supplyLocations) then {1} else {0});

private ["_edit", "_tv", "_cfg", "_maincats", "_mainLibrary", "_itemID", "_mcIdx", "_tidx", "_scIdx", "_realm", "_lastItem", "_lastItem", "_itemID"];
// vic attributes array
_edit = _display ctrlCreate ["RscEdit", 645];
_edit ctrlSetPosition [GUI_A_X+GUI_GRID_W*0.75,GUI_A_Y+GUI_GRID_H*1.5,GUI_GRID_W*19,GUI_GRID_H];
_edit ctrlSetBackgroundColor [0,0,0,1];
_edit ctrlCommit 0;
_edit ctrlSetTooltip "Type to search for specific items.";

// add search icon
_sico = _display ctrlCreate ["RscPicture", -1];
_sico ctrlSetPosition [GUI_A_X+GUI_GRID_W*18.5,GUI_A_Y+GUI_GRID_H*1.5,GUI_GRID_W,GUI_GRID_H];
_sico ctrlSetText "a3\Ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa";
_sico ctrlSetBackgroundColor [0,0,0,1];
_sico ctrlCommit 0;


_tv = _display ctrlCreate ["RscTreeSearch", _idBase];
// _tv ctrlSetFont "EtelkaMonospacePro";
_tv ctrlSetFontHeight GUI_GRID_H;
_tv ctrlSetPosition [GUI_A_X+GUI_GRID_W*0.75,GUI_A_Y+GUI_GRID_H*3,GUI_GRID_W*19,GUI_GRID_H*20];
_tv ctrlSetBackgroundColor [0,0,0,1];
_tv ctrlSetToolTip "Use the SHIFT key to add batches of 10.";
_tv ctrlCommit 0;

_cfg = (missionConfigFile >> "gm_wfor_shop_inventory" >> gm_wfor_shopSide);

_maincats = "true" configClasses _cfg;

// Fill tree with contents from missionConfig
_mainLibrary = [];
_itemID = 0;
_mcIdx = 0;
{
	_mcIdx = _forEachIndex;
	_tidx = _tv tvAdd [[], getText (_x >> "DisplayName")];
	_tv tvSetToolTip [[_tidx], getText (_x >> "DisplayName")];
	// find subClasses
	{
		// if ((getNumber (_x >> "restricted")) <= _restrictedLimit) then
		// {
			_scIdx = _forEachIndex;
			_tidx = _tv tvAdd [[_mcIdx], getText (_x >> "DisplayName")];
			_tv tvSetToolTip [[_mcIdx,_tidx], getText (_x >> "DisplayName")];
			_realm = getText (_x >> "realm");
			// _tv tvSetData [[_mcIdx], getText (_x >> "realm")];
			// fill with content
			_lastItem = -1;
			_itemClass = "";
			{
				if (_itemClass == "") then
				{
					_itemClass = _x;
					_lastItem = _tv tvAdd [[_mcIdx, _scIdx], getText (configFile >> _realm >> _itemClass >> "DisplayName")];
					_itemID = _itemID +1;
				} else
				{
					// tag the item with the config realm, classname and cost.
					_pic = getText (configFile >> _realm >> _itemClass >> "picture");
					//if its a thing with a faction, use faction icon
					_fac = getText (configFile >> _realm >> _itemClass >> "faction");
					if (_fac != "") then
					{
						_pic = getText (configFile >> "CfgFactionClasses">> _fac >> "icon");
					};
					_tv tvSetPicture  [[_mcIdx, _scIdx,_lastItem], _pic];

					// sort out tooltip
					_des = getText (configFile >> _realm >> _itemClass >> "DescriptionShort");
					_new = ([_des, "<br />",true] call BIS_fnc_splitString) joinString "\n";
					_tv tvSetTooltip  [[_mcIdx, _scIdx,_lastItem], _new];

					_tv tvSetValue [[_mcIdx, _scIdx,_lastItem], _itemID];
					_tv tvSetData [[_mcIdx, _scIdx,_lastItem], _itemClass];

					// Prefix item with cost
					_txt = _tv tvText [_mcIdx, _scIdx,_lastItem];
					_tv tvSetText [[_mcIdx, _scIdx,_lastItem], format ["(%1 %3) %2", _x, _txt, gm_wfor_currency_symbol]];

					// add this item to main catalogue as indexed list
					_mainLibrary set [_itemID, [_realm, _itemClass, _x]];
					_itemClass = "";
				};
			} forEach (getarray (_x >> "content"));
		// };
	} forEach ("true" configClasses (_cfg >> configName _x));
} forEach _mainCats;

// store the inventory in the UI so we can access it for operations
_display setVariable ["mainLibrary", _mainLibrary];

// user interaction
_tv ctrlAddEventhandler ["TreeDblClick", "_this call gm_wfor_fnc_shop_cart_add"];
_tv ctrlAddEventhandler ["TreeSelChanged", "_this call gm_wfor_fnc_shop_cart_show"];

// Go Button
_okBut = _display ctrlCreate [("RscButton"), 300];
_okBut ctrlSetPosition [GUI_A_X+GUI_GRID_W*20.25,GUI_A_Y+GUI_T_H-GUI_GRID_H*2.5,GUI_GRID_W*19,GUI_GRID_H*2];
_okBut ctrlSetText "Purchase";
_okBut ctrlSetTooltip "Makes the requested items available.";

_okBut ctrlSetEventHandler ["ButtonClick", "_this call gm_wfor_fnc_shop_purchase"];
_okBut ctrlCommit 0;
