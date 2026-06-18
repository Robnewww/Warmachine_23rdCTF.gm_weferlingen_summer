//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, Dec 2019
//////////////////////////////////////////

params ["_locID",["_init", false]];

_name = ("gm_efai_marker_"+ _locID);
_locObj = _locID call BIS_fnc_objectFromNetId;
_status = _locObj getVariable ["gm_zoneOwner", gm_efai_enemy_side];

// setup marker first time
if _init then
{
	_m = createMarkerLocal [_name, getPos _locObj];
	_name setMarkerShapeLocal "ELLIPSE";
	_name setMarkerSizeLocal [gm_efai_zone_radius, gm_efai_zone_radius];

	// create a trigger that toggles marker appearance depending on enemy presence
	// set up enemy spawn trigger
	_trg3 = createTrigger ["EmptyDetector", getPos _locObj];
	_trg3 setVariable ["gm_owner_location",_locObj];
	_trg3 setTriggerArea [gm_efai_zone_radius, gm_efai_zone_radius, 0, false, 100];
	_trg3 setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trg3 setTriggerTimeout [1, 1, 1, true];
	_trg3 setTriggerInterval 5;
	_trg3 setTriggerStatements
	[
		"({((side group _x) call BIS_fnc_sideID) != ((thisTrigger getVariable 'gm_owner_location') getVariable 'gm_zoneOwner')} count thislist) > 0",
		format ["'%1' setMarkerBrushLocal 'DiagGrid'", _name],
		format ["'%1' setMarkerBrushLocal 'Solid'", _name]
	];
} else
{
	// dont show messages at start when they init the zones
	_nLocs = (nearestLocations [getpos _locObj, ["Mount","Airport","Name","NameCity","NameCityCapital","NameLocal","NameVillage","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"], 1000]);
	_locname = if ((count _nLocs) > 0) then {text (_nLocs select 0)} else {"A location"};
	systemChat format ["%1 is now owned by %2.",_locname, if (_status == gm_efai_enemy_side) then {gm_efai_enemy_name} else {gm_efai_friendly_name}];
};

// Color it in
_color = if (_status == gm_efai_enemy_side) then {gm_efai_enemy_color} else {gm_efai_friendly_color};
_name setMarkerColorLocal (_color);

// update flag
_flagText = if (_status == gm_efai_enemy_side) then {gm_efai_enemy_flags} else {gm_efai_friendly_flags};
{
	_x setFlagTexture selectRandom _flagText;
} forEach nearestObjects [_locObj, [gm_efai_flag_type], gm_efai_zone_radius];

