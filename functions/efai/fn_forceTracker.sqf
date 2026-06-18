//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, Dec 2019
//////////////////////////////////////////

// main marker loop
gm_efai_markerPool = [];
gm_efai_forceTrackerEnabled = true;
[] spawn
{
	// getPlayerUID
	while {gm_efai_forceTrackerEnabled} do
	{
		{
			_obj = _x call BIS_fnc_objectFromNetId;
			if ((!isNull _obj) and (alive _obj)) then
			{
				_pos =  getPos _obj;
				// show names when zoomed in
				_isVehicleCommander = ((effectiveCommander vehicle _obj == _obj) and (vehicle _obj != _obj));
				_scale = (ctrlmapScale ((findDisplay 12) displayCtrl 51));

				_posOffset = if (vehicle _obj != _obj) then {((crew vehicle _obj) find _obj) max 0} else {0};
				_role = if (vehicle _obj != _obj) then {((fullCrew vehicle _obj) select _posOffset) select 1} else {""};
				_ico = switch _role do
				{
					case "driver" : {" (D)"};
					case "gunner" : {" (G)"};
					case "commander" : {" (C)"};
					default {""}
				};
				("gm_m_"+_x) setMarkerTypeLocal "mil_dot";

				if (_scale < 0.1) then
				{

					_pos = [getPos vehicle _obj select 0, (getPos vehicle _obj select 1) - (1000 * _scale * _posOffset)];
					_name = if isPlayer _obj then {name _obj} else {"AI"};
					("gm_m_"+_x) setMarkerTextLocal (format ["%1%2", _name, _ico]);
				} else
				{
					("gm_m_"+_x) setMarkerTextLocal "";
				};
				("gm_m_"+_x) setMarkerPosLocal _pos;

				if (simulationEnabled _obj) then
				{
					("gm_m_"+_x) setMarkerColorLocal gm_efai_friendly_color;
				} else
				{
					("gm_m_"+_x) setMarkerColorLocal "ColorBlack";
				};
			} else
			{
				// remove marker from pool because unit quit
				gm_efai_markerPool = gm_efai_markerPool - [_x];
				deleteMarkerLocal ("gm_m_"+_x);
			};
		} forEach gm_efai_markerPool;
		sleep 0.1;
	};
};

if isNil "gm_efai_debugunits" then {gm_efai_debugunits = []};

// update marker pool
[] spawn
{
	while {gm_efai_forceTrackerEnabled} do
	{
		{
			if ((isPlayer _x) or (_x in gm_efai_debugunits)) then
			{
				_id = _x call BIS_fnc_netId;
				// add marker to pool if it doesnt already exist
				if !(_id in gm_efai_markerPool) then
				{
					gm_efai_markerPool pushBack _id;
					createMarkerLocal [("gm_m_"+_id), getPos _x];
					("gm_m_"+_id) setMarkerShapeLocal "ICON";
					("gm_m_"+_id) setMarkerTypeLocal "mil_dot";
					("gm_m_"+_id) setMarkerColorLocal gm_efai_friendly_color;
				};
			};
		} forEach ((call BIS_fnc_listPlayers) + gm_efai_debugunits);
		sleep 2.5;
	};

	// cleanup
	{
		deleteMarkerLocal ("gm_m_"+_x);
	} forEach gm_efai_markerPool;
};