//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, Dec 2019
//////////////////////////////////////////

params ["_netID", "_saveLoadout", ["_externUID",""], ["_curLoadout", []]];
private ["_unit", "_uid", "_idx"];

// does the storing per player ID:
if isServer then
{
	if (isNil "gm_wfor_gearBankNames") then {gm_wfor_gearBankNames = [];};
	if (isNil "gm_wfor_gearBankDatas") then {gm_wfor_gearBankDatas = [];};
	if (isNil "gm_wfor_gearBankFaces") then {gm_wfor_gearBankFaces = [];};

	_unit = _netID call BIS_fnc_objectFromNetId;
	_uid = getPlayerUID _unit;
	_tempAppearance = [face _unit, _unit call BIS_fnc_getUnitInsignia];

	if (_curLoadout isEqualTo []) then
	{

		// The script wasn't told what to save to the player's slot, so we need to read this out.
		// It could be though that the unit doesn't exist yet so nothing can be read, hence the double check for empty array
		_t = getUnitLoadout _unit;
		if !(_t isEqualTo []) then
		{
			_curLoadout = getUnitLoadout _unit;
		};
	};
	// carry UID from the disconnect
	if (_externUID != "") then {_uid = _externUID};

	_idx = gm_wfor_gearBankNames find _uid;

	// check table
	if (_idx == -1) then
	{
		// player not found
		gm_wfor_gearBankNames pushBack _uid;
		gm_wfor_gearBankDatas pushBack _curLoadout;
		gm_wfor_gearBankFaces pushBack _tempAppearance;
	};

	_idx = gm_wfor_gearBankNames find _uid;
	if (_idx > -1) then
	{
		// player found
		if _saveLoadout then
		{
			if !(_curLoadout isEqualTo []) then
			{
				gm_wfor_gearBankDatas set [_idx, _curLoadout];
			};
			gm_wfor_gearBankFaces set [_idx, _tempAppearance];
		} else
		{
			gm_wfor_pc_data = (gm_wfor_gearBankFaces select _idx);
			(owner _unit) publicVariableClient "gm_wfor_pc_data";
			_unit setUnitLoadout (gm_wfor_gearBankDatas select _idx);
		};
	};
};