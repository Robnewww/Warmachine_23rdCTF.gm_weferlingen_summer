//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, Dec 2019
//////////////////////////////////////////

params ["_display"];
private ["_lb", "_lib", "_total"];
_lb = _display displayCtrl 200;
_tv = _display displayCtrl 100;

_lib = _display getVariable ["mainLibrary", []];

_budget = missionNameSpace getVariable ["gm_wfor_budget", gm_wfor_startingBudget];

_total = 0;


// lambda recursive tree explore
_explorelevel =
{
	params ["_tv","_path", "_findthis"];

	_limit = (_tv tvCount _path) - 1;

	for "_i" from 0 to _limit do
	{
		private _ce = (_path + [_i]);

		if ((_tv tvCount _ce) == 0) then
		{
			// item has no sub children
			if (tolower (_tv tvData _ce) == tolower _findthis) then
			{
				_tv tvSetColor [_ce, [0,1,0,1]];
				_tv tvExpand _ce;
			};
		} else
		{
			// item has sub-children
			[_tv, _ce, _findthis] call _explorelevel;
		};
	};
};

for "_ci" from 0 to ((lbSize _lb)-1) do
{
	(_lib select (_lb lbValue _ci)) params ["_realm", "_typus", "_price"];
	_amount = (call compile (_lb lbTextRight _ci));

	// find compatible ammo for this type
	if (toLower _realm == "cfgweapons") then
	{
		_mags = _typus call BIS_fnc_compatibleMagazines;
		{
			[_tv, [0], _x] call _explorelevel;
		} forEach _mags;
	};
	// find compatible ammo for this type
	if (toLower _realm == "cfgweapons") then
	{
		_atts = _typus call BIS_fnc_compatibleItems;
		{
			[_tv, [1], _x] call _explorelevel;
		} forEach _atts;
	};
	_total = _total + (_price * _amount);
};

_color = if (_total <= _budget) then
{
	(_display displayCtrl 300) ctrlEnable true;
	[1, 1, 1, 1]
} else
{
	(_display displayCtrl 300) ctrlEnable false;
	[0.7, 0.1, 0.1, 1]
};
(_display displayCtrl 500) ctrlSetText format["%1 %3 / %2 %3", _total, _budget, gm_wfor_currency_symbol];
(_display displayCtrl 500) ctrlSetTextColor _color;

_display setVariable ["total", _total];
