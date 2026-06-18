//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, May 2020
//////////////////////////////////////////

private ["_trg", "_list"];
params ["_logic", "_index"];


	_trg = _logic getVariable ["gm_zoneTrigger", nil];
	if !isNil {_trg} then
	{
		_list = list _trg;
		_mn = ("gm_efai_eh_"+str _index);
		if ((count _list > 0) and (count _list < 16)) then
		{
			if (_logic getVariable ["gm_zoneActive", true]) then
			{
				// see if marker already exists:
				if (getmarkerPos _mn isEqualTo [0,0,0]) then
				{
					// create the marker
					createMarker [_mn, getPos (_list select 0)];
					_mn setMarkerShape "ICON";
					_mn setMarkersize [0.5,0.5];
					_mn setMarkerType "mil_unknown";
					_mn setMarkerColor gm_efai_enemy_color;
				};

				// set Zone's enemy marker to the position of the the dude
				_mn setMarkerPos getPos (_list select 0);
			}
		} else
		{
			deleteMarker _mn;
		};
	};
