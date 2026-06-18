//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, Dec 2019
//////////////////////////////////////////

params ["_location", "_side", "_hostTrigger"];
if isServer then
{
	_locID = (_location call BIS_fnc_netId);

	// not taken by friendly
	if (_side == gm_efai_enemy_side) then
	{
		// setup trigger to be ready to be captured by friendly
		private ["_sideName"];

		// _sideName = ["EAST", "WEST", "GUER"] select gm_efai_enemy_side;
		// _hostTrigger setTriggerActivation [_sideName, "NOT PRESENT", true];
		// _hostTrigger setTriggerStatements
		// [
			// "(thisTrigger getvariable 'gm_owner_location') getVariable ['gm_zoneActive',false]",
			// "[(thisTrigger getvariable 'gm_owner_location'),gm_efai_friendly_side, thisTrigger] call gm_efai_fnc_zoneMarkers_server;",
			// ""
		// ];

		// remove respawn
		_thisRespawn = _location getVariable ["gm_respawnLoc", []];
		if (count _thisRespawn != 0) then
		{
			_thisRespawn call BIS_fnc_removeRespawnPosition;
		};
		_location setVariable ["gm_respawnLoc", nil, true];
	} else
	{
		// Award cash only on first conquering
		if !(_location getVariable ["gm_zoneConquered", false]) then
		{
			// shop thing, optional only if wfor currency is there.
			if !(isNil "gm_wfor_currency_symbol") then
			{
				// add reward for capturing
				if (gm_wfor_globalBudget == 1) then
				{
					// to shared budget
					_budget = missionNameSpace getVariable ["gm_wfor_budget", gm_wfor_startingBudget];
					missionNameSpace setVariable ["gm_wfor_budget", _budget + gm_wfor_conquerReward, true];
				} else
				{
					// to individual budget
					{
						if (isPlayer _x) then
						{
							// update player's balance
							[_x call BIS_fnc_netId, gm_wfor_conquerReward] call gm_wfor_fnc_accounting_server;
						};
					} forEach (call BIS_fnc_listPlayers);
				};

				_location setVariable ['gm_zoneConquered', true, true];

				(["ScoreAdded", [format ["Location cleared. %1 %2 added to budget.", gm_wfor_conquerReward, gm_wfor_currency_symbol], 1]]) remoteExec ["BIS_fnc_showNotification", 0];
			};
		};

		// change the trigger activation so that it must be taken by the enemy again first
		private ["_sideName"];
		// _sideName = ["EAST", "WEST", "GUER"] select gm_efai_enemy_side;
		// _hostTrigger setTriggerActivation [_sideName, "PRESENT", true];
		// _hostTrigger setTriggerStatements
		// [
			// "(thisTrigger getvariable ['gm_owner_location',objNull]) getVariable ['gm_zoneActive',false]",
			// "[(thisTrigger getvariable 'gm_owner_location'),gm_efai_enemy_side, thisTrigger] call gm_efai_fnc_zoneMarkers_server;",
			// ""
		// ];
		// _hostTrigger setTriggerTimeout [5, 7, 10, false];

		if (gm_efai_respawnCaptures == 1) then
		{
			// Place respawn at the flag if possible:
			_rpos = _location;
			_spawnLocs = nearestObjects [_location, [gm_wfor_shopLocations], gm_efai_zone_radius];
			if (count _spawnLocs > 0) then {_rpos = (_spawnLocs select 0)};
			_thisRespawn = [missionNamespace, _rpos] call BIS_fnc_addRespawnPosition;
			_location setVariable ['gm_respawnLoc', _thisRespawn, true];
		};
	};
	_location setVariable ['gm_zoneOwner', _side, true];

	// Push marker update to all players
	[_locID] remoteExec ["gm_efai_fnc_zoneMarkers", -2];
	// SP debug
	if !isMultiplayer then {[_locID] call gm_efai_fnc_zoneMarkers;};
};