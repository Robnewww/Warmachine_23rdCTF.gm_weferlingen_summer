//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, Dec 2019
//////////////////////////////////////////

params ["_target"];

_enable = (count (_target getVariable ["gm_wfor_tempObjects", []]) == 0);
_hidelist =
["camonetpoles_1_1_unhide",
"camonetpoles_1_2_unhide",
"camonetrack_unhide",
"CamoNet_01_rack_unhide",
"CamoNet_02_rack_unhide",
"CamoNet_01_unhide",
"CamoNet_02_unhide",
"CamoNet_03_unhide",
"CamoNet_04_unhide"];

if _enable then
{
	if ((speed _target < 1) and (((getPos _target) select 2) < 0.5)) then
	{
		// add camoNet
		_cm = selectRandom gm_wfor_CamoNetTypes createVehicle getPos _target;
		_cm setDir getDir _target;
		_cm setPosASL getPosASL _target;

		_target setVariable ["gm_wfor_tempObjects", [_cm], true];

		// hide vehicle speciifcs of camonets
		{_target animateSource [_x, 0]} forEach _hidelist;
	};
} else
{
	// check for distance, we may need to run the func again to instantly build a net, sinc ethe user "toggled" it off with a net that was left behind, and they expect to build a new one
	_t = (_target getVariable ["gm_wfor_tempObjects",[]]);
	_restart = false;

	if (count _t > 0) then
	{
		_restart = (((_t select 0) distance _target) > 10);
	};
	// cleanup
	{
		deleteVehicle _x;
	} forEach _t;
	_target setVariable ["gm_wfor_tempObjects", [], true];
	{_target animateSource [_x, 1,1000]} forEach _hidelist;

	if _restart then
	{
		[_target] call gm_wfor_fnc_toggleCamoNet;
	};
};