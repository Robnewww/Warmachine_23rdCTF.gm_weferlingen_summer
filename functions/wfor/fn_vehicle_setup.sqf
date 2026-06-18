_vic = _this;

// cleanup start loadout
clearWeaponCargoGlobal _vic;
clearMagazineCargoGlobal _vic;
clearItemCargoGlobal _vic;
clearBackpackCargoGlobal _vic;

// add abilities if needed
_isBuilder = false;
_isSpawn = false;

_vic setVariable ["gm_noreward", true, true];

// doing with explicit flags to prevent multiple addition of the UA.
{if (_vic isKindOf _x) then {_isBuilder = true};} forEach gm_wfor_builderTypes;
{if (_vic isKindOf _x) then {_isSpawn = true};} forEach gm_wfor_HQTypes;

if _isBuilder then
{
	[_vic, [format ["<t font='%1'>Build Interface</t>", gm_wfor_boldFont], {[player, baseZeus] call gm_wfor_fnc_builder_start}, [], 1.5,false, true, "", "driver _target == _this", 10]] remoteExec ["addAction", 0, true];
};

if _isSpawn then
{
	// Require driver to toggle it if there is a driver slot
	if ((count fullCrew _vic) > 0) then
	{
		[_vic, [format ["<t font='%1'>Toggle Respawn</t>", gm_wfor_boldFont], {[(_this select 0)] call gm_wfor_fnc_toggleSpawnPoint}, [], 1.5,false, true, "", "(speed _target < 1) and (driver _target == _this) and (((getPos _target) select 2) < 1)", 10]] remoteExec ["addAction", 0, true];
	} else
	{
		[_vic, [format ["<t font='%1'>Toggle Respawn</t>", gm_wfor_boldFont], {[(_this select 0)] call gm_wfor_fnc_toggleSpawnPoint}, [], 1.5,false, true, "", "(speed _target < 1) and (((getPos _target) select 2) < 1)", 10]] remoteExec ["addAction", 0, true];
	};
} else
{
	// give non-spawn vics the ability to build camo nets, too, but not Air
	if !(_vic isKindOf "Air") then
	{
		[_vic, [format ["<t font='%1'>Toggle Camo Net</t>", gm_wfor_boldFont], {[(_this select 0)] call gm_wfor_fnc_toggleCamoNet}, [], 1.5,false, true, "", "(speed _target < 1) and (((getPos _target) select 2) < 1) and (_this == vehicle _this)", 10]] remoteExec ["addAction", 0, true];
	};
};

// add vehicle unflipper
[_vic, [format ["<t font='%1'>Unflip Vehicle</t>", gm_wfor_boldFont], {_t = (_this select 0);_t setVectorUP [0,0,1];_p = getPos _t;_p set [2,0.3];_t setPos _p}, [], 1.5,false, true, "", "(((vectorUp _target) select 2) < 0.6) and (speed _target < 1)", 5]] remoteExec ["addAction", 0, true];

// add vehicle lock option when not communism
if !(isNull player) then
{
	if (gm_wfor_globalBudget == 0) then
	{
		_vic lock 0;
		if !_isSpawn then
		{
			[_vic, [format ["<t font='%1'>Lock Vehicle</t>", gm_wfor_boldFont], {[(_this select 0),2] remoteExec ["lock"]}, [], 1.5,false, true, "", format["((locked _target < 1) and ((getPlayerUID player) == '%1')) and vehicle player == player",getPlayerUID player], 10]] remoteExec ["addAction", 0, true];
			[_vic, [format ["<t font='%1'>Unlock Vehicle</t>", gm_wfor_boldFont], {[(_this select 0),0] remoteExec ["lock"]}, [], 1.5,false, true, "", format["(((locked _target) > 0) and ((getPlayerUID player) == '%1'))",getPlayerUID player], 10]] remoteExec ["addAction", 0, true];
		};
	};
};

// add vehicle customizer
[_vic, [format ["<t font='%1'>Customize Vehicle</t>", gm_wfor_boldFont], {(_this select 0) call gm_core_vehicles_fnc_vic_customizer_init}, [], 1.5,false, true, "", "(count (nearestObjects [_this, gm_wfor_repairTypes, 20, true]) > 0) and driver _target == _this", 5]] remoteExec ["addAction", 0, true];

// add vehicle loadout changer
if (_vic isKindOf "LandVehicle") then
{
	// aboid giving this action to ammotrucks themselves
	_cancel = false;
	{if (_vic isKindOf _x) then {_cancel = true}} forEach gm_wfor_ammoVicTypes;
	if !_cancel then
	{
		[_vic, [format ["<t font='%1'>Customize Vehicle Loadout</t>", gm_wfor_boldFont], {(_this select 0) call gm_wfor_fnc_handleVehicleLoadout}, [], 1.5,false, true, "", "(count (nearestObjects [_this, gm_wfor_ammoVicTypes, 20, true]) > 0) and driver _target == _this", 5]] remoteExec ["addAction", 0, true];
	} else
	{
		// The vehicle we have is an ammo truck, so we limit the ammo available to have roughly 80 155mm shells or 40 110mm rockets
		// The command is very strange and needs to be set twice to accurately assign the number
		_vic setAmmoCargo 0.00000004;
		_vic setAmmoCargo 0.00000004;
	};
};