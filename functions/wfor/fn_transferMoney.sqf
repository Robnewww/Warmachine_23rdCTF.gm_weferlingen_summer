_this spawn
{
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
	#define GUI_T_W GUI_GRID_W*20
	#define GUI_T_H GUI_GRID_H*25
	#define GUI_A_X 0.5-(GUI_T_W*0.5)
	#define GUI_A_Y 0.5-(GUI_T_H*0.5)

	disableSerialization;

	// startLoadingScreen [" "];

	_display = findDisplay 46 createDisplay "RscCredits";

	uiNameSpace setVariable ["gm_wfor_transferMoneyDisplay", _display];
	_budget = missionNameSpace getVariable ["gm_wfor_budget", gm_wfor_startingBudget];

	// Build Backgrounds
	_c = [];
	_bg = _display ctrlCreate ["RscBackgroundGUI", -1]; _bg ctrlSetPosition [GUI_A_X,GUI_A_Y,GUI_T_W,GUI_T_H]; _c pushBack _bg;
	_bg = _display ctrlCreate ["RscBackgroundGUITop", -1];_bg ctrlSetText "Transfer Funds";_bg ctrlSetPosition [GUI_A_X,GUI_A_Y,GUI_T_W,GUI_GRID_H]; _c pushBack _bg;
	_mcnt = _display ctrlCreate ["RscBackgroundGUITop", 500];_mcnt ctrlSetText format["%1 %2", _budget, gm_wfor_currency_symbol];_mcnt ctrlSetPosition [GUI_A_X+GUI_GRID_W*0.5,GUI_A_Y+GUI_T_H-GUI_GRID_H*6,GUI_GRID_W*19,GUI_GRID_H]; _c pushBack _mcnt;

	_exit = _display ctrlCreate ["RscActivePicture", 2];
	_exit ctrlSetText "A3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_exit_cross_ca.paa";
	_exit ctrlSetPosition [GUI_A_X+GUI_T_W-GUI_GRID_W,GUI_A_Y,GUI_GRID_W,GUI_GRID_H];
	_exit ctrlSetTooltip "Exit";
	_c pushBack _exit;

	// list of acc
	_lb = _display ctrlCreate ["RscListBox", 55];
	_lb ctrlSetPosition [GUI_A_X+GUI_GRID_W*0.5,GUI_A_Y+GUI_GRID_H*1.5,GUI_T_W-GUI_GRID_W,GUI_T_H-GUI_GRID_H*8];
	_lb ctrlSetBackgroundColor [0,0,0,1];
	_c pushBack _lb;

	// Go Button
	_okBut = _display ctrlCreate ["RscButton", 300];
	_okBut ctrlSetPosition [GUI_A_X+GUI_GRID_W*0.5,GUI_A_Y+GUI_T_H-GUI_GRID_H*2.5,GUI_GRID_W*19,GUI_GRID_H*2];
	_okBut ctrlSetText "Send Money";
	_okBut ctrlSetTooltip "Send money to selected person.";
	_okBut ctrlSetEventHandler ["ButtonClick", "call gm_wfor_fnc_transferMoney_action"];
	_c pushBack _okBut;

	// slider
	_moneySlider = _display ctrlCreate ["RscXSliderH", 56];
	_moneySlider ctrlSetPosition [GUI_A_X+GUI_GRID_W*0.5,GUI_A_Y+GUI_T_H-GUI_GRID_H*4.5,GUI_GRID_W*14.5,GUI_GRID_H*1.5];
	_moneySlider ctrlAddEventHandler ["SliderPosChanged",{((ctrlParent (_this select 0)) displayCtrl 57) ctrlSetText (str([(_this select 1), 0] call BIS_fnc_cutDecimals)+" "+gm_wfor_currency_symbol)}];
	_moneySlider ctrlSetTooltip "Click and drag set the amount of currency.";
	_c pushBack _moneySlider;

	// editbox
	_moneyedit = _display ctrlCreate ["RscEdit", 57];
	_moneyedit ctrlSetPosition [GUI_A_X+GUI_GRID_W*15.5,GUI_A_Y+GUI_T_H-GUI_GRID_H*4.5,GUI_GRID_W*4,GUI_GRID_H*1.5];
	_moneyedit ctrlSetToolTip "Enter amount of currency to transfer.";
	_moneyedit ctrlSetText ("0 "+gm_wfor_currency_symbol);
	_moneyedit ctrlAddEventHandler ["Char",{_this spawn {((ctrlParent (_this select 0)) displayCtrl 56) sliderSetPosition parseNumber (ctrlText (_this select 0))}}];
	_moneyedit ctrlAddEventHandler
	[
		"KillFocus",
		{
			_ctrl = _this select 0;
			_ct = ctrlText _ctrl;
			_budget = missionNameSpace getVariable ["gm_wfor_budget", gm_wfor_startingBudget];
			if ((parseNumber _ct) > _budget) then
			{
				_ctrl ctrlSetText (str _budget + " " +gm_wfor_currency_symbol);
				playSound "3DEN_notificationWarning";
			};
			if !(gm_wfor_currency_symbol in _ct) then
			{
				_ctrl ctrlSetText (_ct + " " +gm_wfor_currency_symbol);
			};
			if ((parseNumber _ct) < 0) then
			{
				_ctrl ctrlSetText ("0 "+gm_wfor_currency_symbol);
				playSound "3DEN_notificationWarning";
			};
		}
	];
	_c pushBack _moneyedit;

	{_x ctrlCommit 0} forEach _c;

	_clientList = (allPlayers - entities "HeadlessClient_F" - [player]);
	_display setVariable ["gm_tm_accounts", _clientList];

	// Add all players to the list
	{
		_i = _lb lbAdd name _x;
		_lb lbSetCurSel 0; // always select first
		_lb lbSetTooltip [_i, format ["Click to choose %1 to receive the transfer.",name _x]];
	} forEach _clientList;

	if (count _clientList == 0) then
	{
		{_x ctrlEnable false; _x ctrlSetToolTip "No account selected."} forEach [_moneySlider, _moneyEdit, _okBut]
	};

	while {!isNull _display} do
	{
		_budget = missionNameSpace getVariable ["gm_wfor_budget", gm_wfor_startingBudget];
		_mcnt ctrlSetText format["%1 %2", _budget, gm_wfor_currency_symbol];
		_moneySlider sliderSetRange [0, _budget];
	};
};