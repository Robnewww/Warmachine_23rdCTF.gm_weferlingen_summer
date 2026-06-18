_sp = selectRandom allMissionObjects gm_wfor_startLocations;

_opos = getPos _sp;
playerBase setPos _opos;
gm_wfor_RespawnMarker setMarkerPos _opos;

{
	_x params ["_t","_p"];
	_dp = _opos vectorAdd _p;
	_np = [_dp, 0, 50, 5, 0, 45, 0, [], _dp] call BIS_fnc_findSafePos;
	_v = createVehicle [_t, _np];
	_v call gm_wfor_fnc_vehicle_setup;
} forEach gm_wfor_startAssets;

if !isMultiplayer then
{
	player setPos _opos;
};