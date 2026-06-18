//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, Dec 2019
//////////////////////////////////////////

// does the accounting per player ID:

params ["_netID", ["_amount",0]];
if isServer then
{
	private ["_unit","_uid","_idx", "_balance"];
	if (isNil "gm_wfor_accountNames") then {gm_wfor_accountNames = [];};
	if (isNil "gm_wfor_accountDatas") then {gm_wfor_accountDatas = [];};

	_unit = _netID call BIS_fnc_objectFromNetId;
	_uid = getPlayerUID _unit;

	_idx = gm_wfor_accountNames find _uid;

	// check books
	_balance = gm_wfor_startingBudget;
	if (_idx == -1) then
	{
		// acc not found
		gm_wfor_accountNames pushBack _uid;
		gm_wfor_accountDatas pushBack gm_wfor_startingBudget;
	};

	_idx = gm_wfor_accountNames find _uid;
	if (_idx > -1) then
	{
		// Account found
		_balance = (0 + (gm_wfor_accountDatas select _idx)); // create a copy so we dont modify the array directly, just to be sure

		// change balance if needed
		if (_amount != 0) then
		{
			_msg = format ["%1%2 %3", if (_amount > 0) then {"+"} else {""},_amount, gm_wfor_currency_symbol];
			_msg remoteExec ["systemChat", (owner _unit)];
			_balance = _balance + _amount;
			gm_wfor_accountDatas set [_idx, _balance];
		};
	};

	// books updated. Send new amount to player
	// Using remoteExec here to not interfere with a local hosted server (player's) own balance
	[_balance, {gm_wfor_budget = _this}] remoteExec ["call", (owner _unit)];
};