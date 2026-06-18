//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, Dec 2019
//////////////////////////////////////////

params ["_control", "_selectionPath", ["_operation", 1]];

private ["_display", "_lb", "_itemID", "_lib", "_lbIdx", "_data", "_dn", "_amount", "_curAmount"];

_display = ctrlParent _control;
_lb = _display displayCtrl 200;

_itemID = -1;
// came from TV eventhandler
if (_operation > 0) then
{
	_itemID = (_control tvValue _selectionPath);
} else
{
	// came from lbox
	_itemID = _lb lbValue _selectionPath;
};

// do the accounting
_lib = _display getVariable ["mainLibrary", []];
if (count _lib > 0) then
{
	// see if selected item already exists in list
	_lbIdx = -1;
	for "_ci" from 0 to ((lbSize _lb)-1) do
	{
		if ((_lb lbValue _ci) == _itemID) then
		{
			_lbIdx = _ci;
		};
	};

	_data = _lib select _itemID;
	if (count _data != 0) then
	{
		_data params ["_realm", "_class", "_cost"];
		_dn = getText (ConfigFile >> _realm >> _class >> "DisplayName");

		_amount = 1;
		if (gm_wfor_shop_shift) then {_amount = 10};

		// Item wasn't found, we have to create it first time
		if (_lbIdx < 0) then
		{
			_lbIdx = _lb lbAdd format ["(%1 %3) %2", _cost, _dn, gm_wfor_currency_symbol];
			_lb lbSetTextRight [_lbIdx, str _amount];
			_lb lbSetValue [_lbIdx, _itemID];
		} else
		{
			// item was found
			_amount = _amount * _operation;
			_curAmount = ((call compile (_lb lbTextRight _lbIdx)) +_amount);

			if (_curAmount < 1) then
			{
				_lb lbDelete _lbIdx;
			} else
			{
				_lb lbSetTextRight [_lbIdx, str _curAmount];
			};
		};
		[_display] call gm_wfor_fnc_shop_updateTotal;
	};
};
