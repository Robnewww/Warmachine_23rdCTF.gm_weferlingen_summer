//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, Dec 2019
//////////////////////////////////////////

_trg = createTrigger ["EmptyDetector", getPos _this];
_trg setVariable ["gm_owner_location",_this];
_trg setTriggerArea [gm_efai_zone_radius, gm_efai_zone_radius, 0, false, 15];

_this setVariable ["gm_zoneOwner", gm_efai_enemy_side, true];
_this setVariable ["gm_zoneTrigger", _trg];
_this setVariable ["gm_zoneActive", false]; // tag as not active

if (isNil "gm_efai_allZones") then {gm_efai_allZones = []};
gm_efai_allZones pushback _this;

// create side name

_enemySideName = ["EAST", "WEST", "GUER"] select gm_efai_enemy_side;
_trg setTriggerActivation [_enemySideName, "NOT PRESENT", true];
_trg setTriggerStatements
[
	"this and ((thisTrigger getvariable 'gm_owner_location') getVariable ['gm_zoneActive',false])",
	"[(thisTrigger getvariable 'gm_owner_location'),gm_efai_friendly_side, thisTrigger] call gm_efai_fnc_zoneMarkers_server;",
	"[(thisTrigger getvariable 'gm_owner_location'),gm_efai_enemy_side, thisTrigger] call gm_efai_fnc_zoneMarkers_server;"
];

// mark area as guarded to get arma AI to react
createGuardedPoint [[east, west, resistance] select gm_efai_enemy_side, getPos _this, -1, objNull];

// set up enemy spawn trigger
_friendlySideName = ["EAST", "WEST", "GUER"] select gm_efai_friendly_side;
_trg2 = createTrigger ["EmptyDetector", getPos _this];
_trg2 setVariable ["gm_owner_location",_this];
_trg2 setTriggerArea [1500, 1500, 0, false, 100];
_trg2 setTriggerActivation [_friendlySideName, "PRESENT", false];
_trg2 setTriggerTimeout [1, 1, 1, true];
_trg2 setTriggerStatements
[
	"if (count thisList > 0) then {speed (thisList select 0) < 100} else {false}",
	"[(thisTrigger getvariable 'gm_owner_location')] call gm_efai_fnc_occupyLocation;",
	""
];