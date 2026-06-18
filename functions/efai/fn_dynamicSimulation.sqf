//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, Nov 2020
//
//  A dynamic simulation script to replace BI's, since that one causes lag in the multiplay that is noticeable
//  Runs on the server, toggles units in zones as required
//////////////////////////////////////////

[] spawn
{
	{
		// create the zone triggers
		_trg = createTrigger ["EmptyDetector", getPos _x];
		_trg setTriggerArea [gm_efai_dynsim_locationSize, gm_efai_dynsim_locationSize, 0, false, 50];
		_sideName = ["EAST", "WEST", "GUER"] select gm_efai_enemy_side;
		_trg setTriggerActivation [_sideName, "PRESENT", true];

		// store trigger in location so that we can retrieve it
		_x setVariable ["gm_dynsim_trigger",_trg];
	} forEach gm_efai_allZones;

	// the loop that scans distance to players

	_toggleZoneUnits =
	{
		params ["_zones", "_state"];

		// take action on the zones to disable units
		{
			// check if the zone needs toggling because it was flagged as  the opposite state before
			if ((_x getVariable ["gm_efai_dynsim_enabled", false]) isEqualTo !_state) then
			{
				// set flag
				_x setVariable ["gm_efai_dynsim_enabled", _state];

				// toggle off units
				_trg = (_x getVariable ["gm_dynsim_trigger", objNull]);
				if (!isNull _trg) then
				{
					{
						if (!isPlayer _x) then
						{
							_x enableSimulationGlobal _state;
							_x allowDamage _state;
							if (vehicle _x != _x) then
							{
								vehicle _x enableSimulationGlobal _state;
								vehicle _x allowDamage _state;
								{_x enableSimulationGlobal _state} forEach crew vehicle _x;
								{_x allowDamage _state} forEach crew vehicle _x;
							} else
							{
								// delete dead bodies that were killed while simulation was disabled
								if (!alive _x) then {deleteVehicle _x};
							};
						};
					} forEach list _trg;
				};
			};
		} forEach _zones;
	};

	gm_efai_dynsim_enabled = true;
	while {gm_efai_dynsim_enabled} do
	{
		sleep gm_efai_dynsim_interval;

		_disableZones = ([] + gm_efai_allZones);
		_enableZones = [];

		{
			_zn = _x;
			{
				if (alive _x) then
				{
					// Check if the player is within zone range
					if ((_x distance2D _zn) < gm_efai_dynsim_triggerDistance) then
					{
						// remove this zone from the checking list (so it doesnt get retested to save performance)
						_disableZones = _disableZones - [_zn];
						// add zone zo enable Zones list
						_enableZones pushBack _zn;
					};
				}
			} forEach (call BIS_fnc_listPlayers);
		} forEach gm_efai_allZones;

		[_disableZones, false] call _toggleZoneUnits;
		[_enableZones, true] call _toggleZoneUnits;
	};
};