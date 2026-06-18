_home = _this;
// retrieve pool of possible attacker forces
// pick a location nearby

sleep 0.01;
// cycle each individually, since nearestObjects is too performance heavy and could lock up the server
_source = objNull;
_sd = 40000;
{
	_d = _x distance2D _home;
	// minimal distance 2500 and unconquered
	if (_d > 2500 and !(_x getVariable ["gm_zoneConquered", false])) then
	{
		// this one is closer than the previous one identified
		if (_d < _sd) then
		{
			_sd = _d;
			_source = _x;
		};
	};
	sleep 0.05;
} forEach (gm_efai_allZones - [_home]);

sleep 0.01;

_allCounterGroups = [];
if !isNull _source then
{
	_qtype = getArray (missionConfigFile >> "gm_efai" >> "gm_efai_attackers");
	{
		// use the new location to create the reinforcements
		_reinf =
		[
			selectRandom _qtype,
			_source getRelPos [gm_efai_zone_radius + random 200, (_source getRelDir _home)]
		] call gm_efai_fnc_createFromTemplate;

		{if (vehicle _x == _x) then {_x moveInAny assignedVehicle _x}} forEach units _reinf;

		_allCounterGroups pushBack _reinf;
		[_reinf, _home getRelPos [(gm_efai_zone_radius * 0.3) + random 200, 0], "SAD"] call gm_efai_fnc_moveGroup;
		[_reinf, _home getRelPos [(gm_efai_zone_radius * 0.3) + random 200, 0], "LOITER"] call gm_efai_fnc_moveGroup;
		sleep 2;
	} forEach [1,2,3];
};

g_debugReinf = _allCounterGroups;