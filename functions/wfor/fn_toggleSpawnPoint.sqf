//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, Dec 2019
//////////////////////////////////////////

params ["_target"];

private ["_enable", "_thisRespawn", "_target","_anchor"];
_enable = (count (_target getVariable ["thisRespawn", []]) == 0);
if _enable then
{
	// setup
	if ((speed _target < 1) and (((getPos _target) select 2) < 0.5)) then
	{
		_thisRespawn = [missionNamespace, _target getRelPos [10, 180], getText (configFile >> "CfgVehicles" >> typeOf _target >> "DisplayName")] call BIS_fnc_addRespawnPosition;
		_target animateSource ["antennamast_01_elev_source",1,10];

		_target allowDamage false;
		if (!alive _target) then {_target setdamage 0.7};

		{_target animateDoor [_x,1]} forEach
		[
			"door_1_1_source",
			"door_1_2_source",
			"door 2_1_source",
			"door_2_2_source",

			"hatch_1_1_source",
			"hatch_1_2_source",
			"hatch_2_1_source",
			"hatch_2_2_source"
		];

		// increase mass to prevent slingloading
		_target setVariable ["oldWeight", getMass _target, true];
		_target setMass 50000;

		_target setVariable ["thisRespawn", _thisRespawn, true];

		_anchor = "Land_clutterCutter_small_F" createVehicle getPos _target;
		_anchor setPos getPos _target;
		_dir = getDir _target;
		_target attachTo [_anchor];
		_target setDir _dir;
		_target setPosASL getPosASL _target;

		// add camoNet
		_cm = selectRandom gm_wfor_CamoNetTypes createVehicle getPos _target;
		_cm allowDamage false;
		_cm setDir _dir;
		_cm setPosASL getPosASL _target;

		_target setVariable ["gm_wfor_tempObjects", [_cm], true];

		moveOut player;
		if !(_target isKindOf "Air") then
		{
			player action ["engineOn", _target];
		};

		_mhqMarker = ("gm_efai_mhqmarker"+str floor time + str random 100000); // pseudo unique name
		createMarker [_mhqMarker, getPos _target];
		_mhqMarker setMarkerShape "ICON";
		_mhqMarker setMarkerType "mil_flag";
		_mhqMarker setMarkerColor gm_efai_friendly_color;
		_target setVariable ["gm_efai_mhqmarker", _mhqMarker, true];
	};
} else
{
	// cleanup
	{
		deleteVehicle _x;
	} forEach (_target getVariable ["gm_wfor_tempObjects",[]]);

	_target animateSource ['antennamast_01_elev_source',0,10];
	_om = _target getVariable ["oldWeight", 0];
	if (_om > 0) then
	{
		_target setMass _om;
	};
	detach _target;

	// marker
	deleteMarker (_target getVariable ["gm_efai_mhqmarker", ""]);

	{_target animateDoor [_x,0]} forEach
	[
		"door_1_1_source",
		"door_1_2_source",
		"door 2_1_source",
		"door_2_2_source",

		"hatch_1_1_source",
		"hatch_1_2_source",
		"hatch_2_1_source",
		"hatch_2_2_source"
	];


	_thisRespawn = _target getVariable ["thisRespawn", []];
	if (count _thisRespawn != 0) then
	{
		_thisRespawn call BIS_fnc_removeRespawnPosition;
	};
	_target setVariable ["thisRespawn", nil, true];
	_target allowDamage true;
};