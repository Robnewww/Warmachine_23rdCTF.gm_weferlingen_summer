//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, Dec 2019
//////////////////////////////////////////

params["_type", ["_pos",[10,10,0]], ["_side", ([east, west, resistance] select gm_efai_enemy_side)], ["_dynSim", true]];

_cls = missionConfigFile >> "gm_efai" >> "grouptemplates" >> _type;

if isNil "gm_efai_debugunits" then {gm_efai_debugunits = []};

private _usePara = false;
private _isAirmob = false;
private _pool = grpNull;
private "_pool2";
if isClass _cls then
{
	_ranks = getarray (_cls >> "ranks");
	_inits = getText (_cls >> "unitInit");
	_init = getText (_cls >> "init");
	_vinit = getText (_cls >> "vehicleInit");
	_locked = (getNumber (_cls >> "unlocked") == 0);
	_vics = getarray (_cls >> "vehicles");
	_fb = getText  (_cls >> "forceBackPackType");
	_usePara = ((getNumber (_cls >> "useParachute")) > 0);
	_isAirmob = ((getNumber (_cls >> "isAirmobile")) > 0);

	_pool = createGroup _side;
	{
		private "_spawnPos";
		_spawnPos = [_pos, 0, 250, 5, 0, 45, 0, [], _pos] call BIS_fnc_findSafePos;

		// 3 error fallbacks in case BI's function is poo
		if (_spawnPos isEqualTo []) then {_spawnPos = _pos};
		if (typeName _spawnPos != typeName []) then {_spawnPos = _pos};
		if ((count _spawnPos) != 3) then {_spawnPos = _pos};

		// _nr = (_spawnPos nearRoads 50);
		// if (count _nr > 0) then {_spawnPos = (_nr select 0)};

		private "_v";
		if _isAirmob then
		{
			_v = createVehicle [_x , _spawnPos, [],100, "FLY"];
		} else
		{
			// non airvehicle
			_adjustedSP = [_spawnPos, 200, ["null"], 0.001] call gm_core_fnc_findParkingSpot;

			_adjustedSP params ["_spPos", "_spDir"];
			if (_spPos isEqualTo [0,0,0]) then
			{
				_spPos = _spawnPos;
			};

			_v = createVehicle [_x , _spPos, [], 0, "NONE"];
			_v setDir _spDir;

		};

		_pool addVehicle _v;
		_v call compile _vinit;

		if _locked then
		{
			_v lock 3;
		};

		createVehicleCrew _v;
		(crew _v) joinSilent _pool;
		gm_efai_debugunits append crew _v;

		sleep 2;
	} forEach _vics;

	// new group for the paras
	if _isAirmob then
	{
		_pool2 = _pool;
		_pool = createGroup _side;

		if _dynSim then
		{
			_pool2 enableDynamicSimulation true;
			_pool2 deleteGroupWhenEmpty true;
		};
	};

	{
		// create
		_dude = _pool createUnit [_x, _pos, [], 150, "CARGO"];
		if (_inits != "") then
		{
			_dude call compile _inits;
		};

		// promote
		if (count _ranks > 0) then
		{
			if (count _ranks < _forEachIndex) then
			{
				_dude setRank (_ranks select _forEachIndex);
			};
		};

		gm_efai_debugunits pushBack _dude;

		if (_fb != "") then
		{
			removeBackpack _dude;
			_dude addBackpack _fb;
		};
		// run general init
		_pool call compile _init;

		// run unit specific init
		/*
		if (count _inits < _forEachIndex) then
		{
			_dude call compile (_inits select _forEachIndex);
		};
		*/
		sleep 0.2;
	} forEach getarray (_cls >> "units");

	if _dynSim then
	{
		_pool enableDynamicSimulation true;
	};
	_pool deleteGroupWhenEmpty true;
};

// return
if _isAirmob then
{
	[_pool, _pool2, _usePara];
} else
{
	_pool
};