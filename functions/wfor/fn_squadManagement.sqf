_this spawn
{
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
	#define GUI_T_H GUI_GRID_H*25
	#define GUI_A_X 0.5-(GUI_T_W*0.5)
	#define GUI_A_Y 0.5-(GUI_T_H*0.5)

	disableSerialization;

	// startLoadingScreen [" "];

	_display = findDisplay 46 createDisplay "RscCredits";

	uiNameSpace setVariable ["gm_wfor_squadManagementDisplay", _display];

	// Build Backgrounds
	_c = [];
	_bg = _display ctrlCreate ["RscBackgroundGUI", -1]; _bg ctrlSetPosition [GUI_A_X,GUI_A_Y,GUI_T_W,GUI_T_H]; _c pushBack _bg;
	_bg = _display ctrlCreate ["RscBackgroundGUITop", -1];_bg ctrlSetText "Squad Management";_bg ctrlSetPosition [GUI_A_X,GUI_A_Y,GUI_T_W,GUI_GRID_H]; _c pushBack _bg;

	_exit = _display ctrlCreate ["RscActivePicture", 2];
	_exit ctrlSetText "A3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_exit_cross_ca.paa";
	_exit ctrlSetPosition [GUI_A_X+GUI_T_W-GUI_GRID_W,GUI_A_Y,GUI_GRID_W,GUI_GRID_H];
	_exit ctrlSetTooltip "Exit";
	_c pushBack _exit;

	// Join Button
	_joinBut = _display ctrlCreate ["RscButton", 300];
	_joinBut ctrlSetPosition [GUI_A_X+GUI_GRID_W*0.5,GUI_A_Y+GUI_T_H-GUI_GRID_H*2.5,GUI_GRID_W*9.25,GUI_GRID_H*2];
	_joinBut ctrlSetText "Join";
	_joinBut ctrlSetTooltip "Join selected group.";
	_c pushBack _joinBut;

	// Create Button
	_createBut = _display ctrlCreate ["RscButton", 301];
	_createBut ctrlSetPosition [GUI_A_X+GUI_GRID_W*10.25,GUI_A_Y+GUI_T_H-GUI_GRID_H*2.5,GUI_GRID_W*9.25,GUI_GRID_H*2];
	_createBut ctrlSetText "Create";
	_createBut ctrlSetTooltip "Create a new group.";
	_createBut ctrlSetEventHandler ["ButtonClick", "call gm_wfor_fnc_squadManagement_create"];
	_c pushBack _createBut;

	{_x ctrlCommit 0} forEach _c;

	// vic attributes array
	_edit = _display ctrlCreate ["RscEdit", 645];
	_edit ctrlSetPosition [GUI_A_X+GUI_GRID_W*0.5,GUI_A_Y+GUI_GRID_H*1.5,GUI_GRID_W*19,GUI_GRID_H];
	_edit ctrlSetBackgroundColor [0,0,0,1];
	_edit ctrlCommit 0;
	_edit ctrlSetTooltip "Type to search for specific users.";

	// add search icon
	_sico = _display ctrlCreate ["RscPicture", -1];
	_sico ctrlSetPosition [GUI_A_X+GUI_GRID_W*18.25,GUI_A_Y+GUI_GRID_H*1.5,GUI_GRID_W,GUI_GRID_H];
	_sico ctrlSetText "a3\Ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa";
	_sico ctrlSetBackgroundColor [0,0,0,1];
	_sico ctrlCommit 0;

	_tv = _display ctrlCreate ["RscTreeSearch", 874];
	// _tv ctrlSetFont "EtelkaMonospacePro";
	_tv ctrlSetFontHeight GUI_GRID_H;
	_tv ctrlSetPosition [GUI_A_X+GUI_GRID_W*0.5,GUI_A_Y+GUI_GRID_H*3,GUI_GRID_W*19,GUI_GRID_H*19];
	_tv ctrlSetBackgroundColor [0,0,0,1];
	_tv ctrlSetToolTip "Select the group you wish to join.";
	_tv ctrlCommit 0;

	_joinBut ctrlAddEventhandler
	[
		"ButtonClick",
		{
			_disp = uiNameSpace getVariable "gm_wfor_squadManagementDisplay";
			_tv = _disp displayCtrl 874;
			_grpNetId = _tv tvData [((tvCurSel _tv) select 0)];
			_grp = _grpNetId call BIS_fnc_groupFromNetId;
			if (_grp != group player) then
			{
				[player] joinSilent _grp;
			};

			_t = [] spawn {sleep 0.1;gm_temp_squadManagement_forceUpdate = true;};
		}
	];

	while {!isNull _display} do
	{
		gm_temp_squadManagement_forceUpdate = false;
		_curGrpCnt = {side _x == side player} count allGroups;
		{
			if (side _x == side player) then
			{
				_grp = _x;
				_tidx = _tv tvAdd [[], groupId _grp];
				_tv tvSetData [[_tidx], _grp call BIS_fnc_netId];
				{
					_curi = _tv tvAdd [[_tidx], name _x];
					if (_x == player) then
					{
						_tv tvSetCurSel [_tidx,_curi];
						_tv tvSetValue [[_tidx], 100];
						if (_x == leader group _x) then
						{
							_tv tvSetValue [[_tidx,_curi], 100];
							_tv tvSortByValue [[_curi], false];
						};
					};
				} forEach units _x;
				_tv tvSortByValue [[], false];
			};
		} forEach allGroups;
		tvExpandAll _tv;
		waitUntil {_curGrpCnt != ({side _x == side player} count allGroups) or (isNull _display) or gm_temp_squadManagement_forceUpdate or (_tv tvCount [0] == 0)};
		gm_temp_squadManagement_forceUpdate = false;
		tvClear _tv;
	};
	gm_temp_squadManagement_forceUpdate = false;
};