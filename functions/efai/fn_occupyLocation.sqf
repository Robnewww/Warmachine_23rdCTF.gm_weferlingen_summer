//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, Dec 2019
//////////////////////////////////////////

// spawn to prevent lockup
_this spawn
{
	_allpl = call BIS_fnc_listPlayers;
	_serverPopFactor = (ceil ((count _allpl)/10)) max 1;
	params ["_location"];

	_gtype = getArray (missionConfigFile >> "gm_efai" >> "gm_efai_garrisons");
	_ptype = getArray (missionConfigFile >> "gm_efai" >> "gm_efai_patrols");
	_qtype = getArray (missionConfigFile >> "gm_efai" >> "gm_efai_qrf");

	// Group of tanks just cruising
	if (count _qtype > 0) then
	{
		for "_i" from 1 to (_serverPopFactor) do
		{
			_garrisonTanks = [selectRandom _qtype, _location getRelPos [100+random (gm_efai_zone_radius*0.5), random 360]] call gm_efai_fnc_createFromTemplate;

			// provide a circle of waypoints
			_origin = leader _garrisonTanks;

			[_garrisonTanks, _origin getRelPos [(gm_efai_zone_radius * 0.7) + random 200, random 360]] call gm_efai_fnc_moveGroup;
			[_garrisonTanks, _origin getRelPos [(gm_efai_zone_radius * 0.7) + random 200, random 360]] call gm_efai_fnc_moveGroup;
			[_garrisonTanks, _origin getRelPos [(gm_efai_zone_radius * 0.7) + random 200, random 360]] call gm_efai_fnc_moveGroup;
			[_garrisonTanks, _origin getRelPos [(gm_efai_zone_radius * 0.7) + random 200, 0] ,"CYCLE"] call gm_efai_fnc_moveGroup;
		};
	};

	sleep 1;
	if (count _gtype > 0) then
	{
		// Garrison creation
		for "_i" from 1 to (3 + _serverPopFactor) do
		{
			_spos = [_location getRelPos [50 + random (gm_efai_zone_radius*0.5), random 360], 0, gm_efai_zone_radius*0.5, 0, 0, 0, 0, [], _location getRelPos [random (gm_efai_zone_radius*0.5), random 360]] call BIS_fnc_findSafePos;
			_g = [selectRandom _gtype, _spos] call gm_efai_fnc_createFromTemplate;

			// 15% chance they are in houses
			if (random 100 < 50) then
			{
				_g call gm_efai_fnc_garrison;
			} else
			{
				// dismiss the AI
				_spos = _location getRelPos [50 + random (gm_efai_zone_radius*0.5), random 360];
				[_g,_spos,"DISMISS"] call gm_efai_fnc_moveGroup;

				// if they find enemies, search and destroy
				_spos = _location getRelPos [50 + random (gm_efai_zone_radius*0.5), random 360];
				[_g,_spos,"SAD"] call gm_efai_fnc_moveGroup;
			};
			sleep 0.25
		};
	};
	sleep 1;
	// InterCity patrols
	if (count _ptype > 0) then
	{
		for "_i" from 1 to (_serverPopFactor) do
		{
			_spos = [_location getRelPos [50 + random 150, random 360], 0, gm_efai_zone_radius*0.5, 0, 0, 0, 0, [], _location getRelPos [random (gm_efai_zone_radius*0.5), random 360]] call BIS_fnc_findSafePos;
			_pat = [selectRandom _ptype, _spos] call gm_efai_fnc_createFromTemplate;
			_nearVillages = nearestObjects [getpos _location, ["LocationCamp_F"], 8000, true];

			// 4x stations
			{
				_spos = _location getRelPos [gm_efai_zone_radius + random (gm_efai_zone_radius*0.25), random 360];
				[_pat,_spos] call gm_efai_fnc_moveGroup;
			} forEach [0,1,2,3];
			[_pat,(_location getRelPos [gm_efai_zone_radius + random (gm_efai_zone_radius*0.25), random 360]),"CYCLE",[120,300,600]] call gm_efai_fnc_moveGroup;

			_pat setFormation "FILE";
			_pat setBehaviour "SAFE";
		};
	};

	_location setVariable ["gm_zoneActive", true];

	// Create counter-attack
	_location call gm_efai_fnc_counterattack;

	// 50% chance for para
	if (random 2 < 1) then
	{
		sleep (300+random 300); // 5-10min response
		_location call gm_efai_fnc_paradrop;
	};
};