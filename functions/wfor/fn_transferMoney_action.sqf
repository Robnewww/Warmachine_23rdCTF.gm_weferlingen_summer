_this spawn
{
	_disp = uiNameSpace getVariable ["gm_wfor_transferMoneyDisplay", displayNull];

	_lb = _disp displayCtrl 55;
	_eb = _disp displayCtrl 57;
	_targetID = lbCurSel _lb;
	_targetName = _lb lbText _targetID;
	_targetList = _disp getVariable ["gm_tm_accounts", []];
	_amountText = ctrlText _eb;

	// stop the transfer if something is fishy or the transferamount is 0, or negative ;)
	if ((count _targetList) == 0) exitWith {playSound "3DEN_notificationWarning";hint "Something went wrong. Try again."};
	if (parseNumber _amountText == 0) exitWith {playSound "3DEN_notificationWarning";};
	if (parseNumber _amountText < 0) exitWith {playSound "3DEN_notificationWarning";};

	_targetObject = _targetList select _targetID;

	if (!isNull _disp) then
	{
		if ([format ["Do you really wish to transfer %1 to %2?<br/>This cannot be undone.", _amountText,_targetName], format ["Transfer funds to %1", _targetName], true, true, _disp] call BIS_fnc_guiMessage) then
		{
			// ok
			playSound "3DEN_notificationDefault";

			// update budget locally at least for instant response, or globally in case of communism
			_total = parseNumber _amountText;
			_budget = missionNameSpace getVariable ["gm_wfor_budget", gm_wfor_startingBudget];
			missionNameSpace setVariable ["gm_wfor_budget", (_budget - _total), (gm_wfor_globalBudget == 1)];

			if (gm_wfor_globalBudget == 0) then
			{
				// remove cash from yourself
				[player call BIS_fnc_netId, (_total * -1)] remoteExec ["gm_wfor_fnc_accounting_server", 2];
				// apply to the chosen account
				[_targetObject call BIS_fnc_netId, _total] remoteExec ["gm_wfor_fnc_accounting_server", 2];
			};

		} else
		{
			// cancel
			playSound "3DEN_notificationWarning";
		};
	};
};