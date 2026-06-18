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
(_display displayCtrl 651) ctrlSetText ""; // clear image no matter what

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

		// Use editor if available, otherwise use picture. This covers the mix between cfgVehicles and cfgWeapons, and also backpacks that are sort of both.
		_pic = getText (ConfigFile >> _realm >> _class >> "editorpreview");
		if (_pic == "") then
		{
			_pic = getText (ConfigFile >> _realm >> _class >> "Picture");
		};
		(_display displayCtrl 651) ctrlSetText _pic;
	}
};
