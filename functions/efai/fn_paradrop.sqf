_this spawn
{
	_home = _this;

	_relDir = [90,270,90,270,90,270,90] select gm_efai_enemy_side;
	_source = _home getRelPos [4000,_relDir];

	sleep 0.01;

	// 1 in 5 chance for a paradrop
	private _ptype = getArray (missionConfigFile >> "gm_efai" >> "gm_efai_paratroopers");

	// spawn without dynamic simulation to ensure the server doesnt turn them off
	_reinf =
	[
		selectRandom _ptype,
		_source,
		([east, west, resistance] select gm_efai_enemy_side),
		false
	] call gm_efai_fnc_createFromTemplate;

	_planeCargo = _reinf select 0;
	_planeGrp = _reinf select 1;
	_usePara = _reinf select 2;
	_aircraft = vehicle leader _planeGrp;

	// load up AI
	{_x moveInCargo _aircraft} forEach units _planeCargo;

	// Send infantry to town
	[_planeCargo, _home getRelPos [(gm_efai_zone_radius * 0.3) + random 200, 0] ,"SAD"] call gm_efai_fnc_moveGroup;

	_aircraft setVariable ["gm_efai_cargoai", _planeCargo];
	// send plane flying to town

	_pp = getPos _aircraft;

	// send plane and back, then cleanup
	_lwp = [_planeGrp, (_home getRelPos [(gm_efai_zone_radius * 0.6) + random 200, 0])] call gm_efai_fnc_moveGroup;
	if _usePara then
	{
		_pp set [2, 250];
		_aircraft flyInHeight 250;
		_lwp setWaypointStatements ["true", "this spawn {{sleep (0.2 + random 0.2); unassignVehicle _x; moveOut _x} forEach units (vehicle _this getVariable ['gm_efai_cargoai', grpNull])}"];
		_lwp = [_planeGrp, (_home getRelPos [1500, _relDir + 180])] call gm_efai_fnc_moveGroup;
		_lwp = [_planeGrp, (_home getRelPos [1500, _relDir + 90])] call gm_efai_fnc_moveGroup;
	} else
	{
		_pp set [2, 50];
		_aircraft flyInHeight 50;
		_lwp setWaypointType "TR UNLOAD";
	};

	_aircraft setPos _pp;
	_aircraft setDir (_aircraft getRelDir _home);
	_aircraft setVelocityModelSpace [0, 100, 0];

	_lwp = [_planeGrp, _source] call gm_efai_fnc_moveGroup;
	_lwp setWaypointStatements ["true", "_vic = vehicle this; {moveOut _x; deleteVehicle _x} forEach thislist; deleteVehicle _vic"];

};