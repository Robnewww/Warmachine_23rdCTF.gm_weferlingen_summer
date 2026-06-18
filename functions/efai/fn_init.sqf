//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, Dec 2019
//////////////////////////////////////////

// make constants available from descripion.ext
{
	_val = _x call BIS_fnc_getCfgData;
	// cast constant number
	if ((typeName _val == typeName 0) or (typeName _val == typeName [])) then
	{
		call compile format["%1 = %2", configName _x, _val];
	};

	// cast constant number
	if (typeName _val == typeName "text") then
	{
		call compile format["%1 = '%2'", configName _x, _val];
	};
} forEach configProperties [(missionConfigFile >> "gm_efai_init_constants"),"true"];

{
	// init markers
	[(_x call BIS_fnc_netId), true] call gm_efai_fnc_zoneMarkers;

	if isServer then
	{
		_x call gm_efai_fnc_zoneSetup_server;
	};
} forEach allMissionObjects gm_efai_objectiveTypes;

// init force trackers
if !isDedicated then
{
	call gm_efai_fnc_forceTracker;
};

// handle empty server pausing
if isServer then
{
	1 spawn gm_efai_fnc_dynamicSimulation;
	1 spawn gm_efai_fnc_assistantGarbageCollector;

	[] spawn
	{
		sleep 2;
		gm_missionComplete = false;
		// Overlord that monitors the game, ticks every 15 seconds

		_weatherIter = 0;
		while {!gm_missionComplete} do
		{
			if ((count gm_efai_allZones) > 0) then
			{
				_zc = 0;
				{
					if ((_x getVariable ["gm_zoneOwner", gm_efai_enemy_side]) == gm_efai_friendly_side) then
					{
						_zc = _zc +1;
					};
					// check zone for last remaining units
					[_x, _forEachIndex] call gm_efai_fnc_enemyHighlight;
				} forEach gm_efai_allZones;
				sleep 15;
				if (_zc == (count gm_efai_allZones)) then
				{
					gm_missionComplete = true;
				};
				_weatherIter = _weatherIter + 1;
				if (_weatherIter > 120) then
				{
					500 setFog 0; // clear fog
					1800 setOvercast (random 0.8);
					_weatherIter = 0;
				};
				_hour = date select 3;
				if ((_hour >= 18) or (_hour < 6)) then
				{
					setTimeMultiplier 5;
				} else
				{
					setTimeMultiplier 1;
				};
			};
		};
		// exit mission
		"EveryoneWon" call BIS_fnc_endMissionServer;
	};
};