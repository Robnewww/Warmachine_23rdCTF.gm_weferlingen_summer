//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, Dec 2019
//////////////////////////////////////////

// set up start pos and units right away
if isServer then
{
	[] spawn gm_wfor_fnc_setupStart;
};

// make constants available from descripion.ext
{
	{
		_val = _x call BIS_fnc_getCfgData;
		// cast constant number
		if ((typeName _val == typeName 0) or (typeName _val == typeName [])) then
		{
			call compile format["%1 = %2", configName _x, _val];
		};

		// cast constant number
		if (typeName _val == typeName "text") then
		{
			call compile format["%1 = '%2'", configName _x, _val];
		};
	} forEach configProperties [(missionConfigFile >> _x),"true"];
} forEach ["gm_wfor_init_constants","gm_efai_init_constants"];

// setVD, since the server setting is ignored for some reason.
setViewDistance gm_wfor_viewDistance;

// Fill zeus with relevant objects
/*
_assetList = [];
{
	// crude price approximation through asset size
	_assetList = _assetList + [typeOf _x, (0.002 * (sizeOf typeOf _x))];
} forEach nearestObjects [getPos zeusbaseTemplates, ["All","House_F"], (triggerArea zeusBaseTemplates) select 0];

missionNameSpace setVariable ["gm_wfor_zeusBasicObjects", _assetList];
*/

// unit trait setting per unit per respawn
addMissionEventHandler
[
	"EntityRespawned",
	{
		params ["_entity", "_corpse"];

		// set unit abilities
		_entity setUnitTrait ["engineer",true];
		_entity setUnitTrait ["explosiveSpecialist",true];
		_entity setUnitTrait ["medic",true];
		_entity setSpeaker "NoVoice";

		if (local _entity) then
		{
			_entity spawn
			{
				sleep 2; // delay to let the publicVariable arrive; Additonally done with a PV Eventhandler as the main method, this is a backup
				// restore face and insignia
				if !isNil "gm_wfor_pc_data" then
				{
					[player, gm_wfor_pc_data select 0] remoteExec ["setFace", 0, true];
					player setVariable ["BIS_fnc_setUnitInsignia_class", nil]; // clear the var as otherwise the BI function doesn't re-add it if it was the same as previous
					[player, gm_wfor_pc_data select 1] call BIS_fnc_setUnitInsignia;
				};

				// insignia and face restore Eventhandler
				player addEventHandler ["InventoryClosed",
				{
					if isNil "gm_wfor_pc_data" then {gm_wfor_pc_data = [face player, ""]};
					player setVariable ["BIS_fnc_setUnitInsignia_class", nil]; // clear the var as otherwise the BI function doesn't re-add it if it was the same as previous
					[player, gm_wfor_pc_data select 1] call BIS_fnc_setUnitInsignia;
				}];
			};
		};
	}
];

if (gm_wfor_globalBudget == 0) then
{
	// set gear upon connect, so that BI's respawn syste doesnt overwrite it
	addMissionEventHandler
	[
		"EntityKilled",
		{
			// params is behaving fucky, so gotta do it oldschool
			params ["_unit", "_killer", "_instigator", "_useEffects"];
			if (local _unit) then
			{
				_curLoadout = getUnitLoadout _unit;
				// save loadout earliest possibility.

				// persistent gear
				if (isPlayer _unit) then
				{
					// handling the exception where BI's respawn system triggers EntityKilled upon reconnect to a server
					// We dont want this to trigger the gear bank since it would save the default gear, resetting the player

					if !((_unit == _killer) and (isNull _instigator)) then
					{
						// local host, directly save
						if isServer then
						{
							[_unit call BIS_fnc_netId, true, "", _curLoadout] call gm_wfor_fnc_gearBank_server;
						} else
						{
							// dedicated host, tell server
							[_unit call BIS_fnc_netId, true, "", _curLoadout] remoteExec ["gm_wfor_fnc_gearBank_server", 2]
						};
					};
					_unit spawn
					{
						sleep 5;
						_this setPos [0,0,0];
						_this setVelocity [0,0,0];
					};
				};
			};
		}
	];
};

if isServer then
{
	if (gm_wfor_globalBudget == 0) then
	{
		addMissionEventHandler
		[
			"PlayerConnected",
			{
				params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];

				[_owner, false] call gm_wfor_fnc_gearBank_server;
			}
		];

		addMissionEventHandler
		[
			"EntityKilled",
			{
				// params is behaving fucky, so gotta do it oldschool
				params ["_unit", "_killer", "_instigator", "_useEffects"];

				// system to allow kills to earn money
				if (((side group _unit) != (side _killer)) and (isPlayer _killer) and (!isPlayer _unit)) then
				{
					// award cash for kills
					_reward = 0;
					if !(_unit getVariable ["gm_noreward", false]) then
					{
						if (_unit isKindOf "Man") then {_reward = gm_wfor_killReward};
						if (_unit isKindOf "Car") then {_reward = gm_wfor_killRewardCar};
						if (_unit isKindOf "Tank") then {_reward = gm_wfor_killRewardTank};
						if (_unit isKindOf "Air") then {_reward = gm_wfor_killRewardAir};
					};

					if (isNull _instigator) then {_instigator = UAVControl vehicle _killer select 0}; // UAV/UGV player operated road kill
					if (isNull _instigator) then {_instigator = _killer}; // player driven vehicle road kill

					// only award cash if it is anything
					if (_reward != 0) then
					{
						[_instigator call BIS_fnc_netId, _reward] call gm_wfor_fnc_accounting_server;

						if (_instigator != vehicle _instigator) then
						{
							_vicCrew = [];
							{
								_vicCrew pushBack (_x select 0);
							} forEach (fullCrew (vehicle _instigator));
							{
								[_x call BIS_fnc_netId, (_reward)] call gm_wfor_fnc_accounting_server;
							} forEach (_vicCrew - [_instigator]);
						};
					};
				};
			}
		];

		addMissionEventHandler
		[
			"EntityRespawned",
			{
				params ["_entity", "_corpse"];

				// restore gear
				[_entity call BIS_fnc_netId, false] call gm_wfor_fnc_gearBank_server;

				if !(isNil {_corpse}) then {deleteVehicle _corpse};
			}
		];
		addMissionEventHandler
		[
			"HandleDisconnect",
			{
				params ["_unit", "_id", "_uid", "_name"];
				if (alive _unit) then
				{
					_curLoadout = getUnitLoadout _unit;

					// EH triggers too late, unit is already
					[_unit call BIS_fnc_netId, true, _uid, _curLoadout] call gm_wfor_fnc_gearBank_server;
					_unit setPos [-100,-100,1];
					deleteVehicle _unit;
					false
				};
			}
		];

		// basic income
		[] spawn
		{
			while {true} do
			{
				sleep gm_wfor_basicPeriod;
				{
					if(isPlayer _x) then
					{
						// add basic income every minute
						[_x call BIS_fnc_netId, gm_wfor_basicIncome] call gm_wfor_fnc_accounting_server;
					};
				} forEach allPlayers;
			};
		};
	};
};


// sort out local map markers
if !isDedicated then
{
	[] spawn
	{
		sleep 1;
		// wfor budget
		if (gm_wfor_globalBudget == 1) then
		{
			missionNameSpace setVariable ["gm_wfor_budget", gm_wfor_startingBudget];
		} else
		{
			// request budget for player from server
			[] spawn
			{
				waitUntil {!(isNil {player})};
				missionNameSpace setVariable ["gm_wfor_budget", gm_wfor_startingBudget]; // default budget just for sure
				[player call BIS_fnc_netId, 0] remoteExec ["gm_wfor_fnc_accounting_server", 2];
			};
		};

		{
			_isSupply = _x isKindOf gm_wfor_supplyLocations;
			_name = ("marker_"+str _x);
			_m = createMarkerLocal [_name, getPos _x];
			// _m setMarkerTypeLocal (if _isSupply then {"mil_join"} else {"mil_triangle"});
			_m setMarkerTypeLocal "mil_triangle";

			// set up shops
			_flag = gm_efai_flag_type createVehicleLocal [10,10,10];

			_p = getPos _x;
			_p set [2,0];
			_flag setPos _p;
			_synchdLocs = synchronizedObjects _x;
			_ft = gm_efai_enemy_flags;
			_ownerMain = if (count _synchdLocs > 0) then {_synchdLocs select 0} else {_ft = gm_efai_friendly_flags;_x};
			_flag setVariable ["gm_shop_owner", _ownerMain];

			_flag setFlagTexture selectRandom _ft;

			// drop in light source
			_lightpoint = "#lightpoint" createVehicleLocal [0,0,0];
			_lightpoint setPos _p;
			_lightpoint setLightColor [0,0,0];
			_lightpoint setLightAmbient [1,0.8, 0.25];
			_lightpoint setLightBrightness 0.15;

			_flag addAction [format ["<t font='%1'>Equipment Shop</t>", gm_wfor_boldFont], {(_this select 3) call gm_wfor_fnc_shop_init}, _x, 10, true, true, "", "((_target getVariable ['gm_shop_owner', objNull]) getVariable ['gm_zoneOwner',gm_efai_friendly_side]) == ([east, west, resistance] find side _this)", 10];
			_flag addAction [format ["<t font='%1'>Transfer Funds</t>", gm_wfor_boldFont], {call gm_wfor_fnc_transferMoney}, nil, 10, true, true, "", "((_target getVariable ['gm_shop_owner', objNull]) getVariable ['gm_zoneOwner',gm_efai_friendly_side]) == ([east, west, resistance] find side _this)", 10];
			_flag addAction [format ["<t font='%1'>Soldier Customizer</t>", gm_wfor_boldFont], {call gm_wfor_fnc_personalCustomizer}, nil, 10, true, true, "", "((_target getVariable ['gm_shop_owner', objNull]) getVariable ['gm_zoneOwner',gm_efai_friendly_side]) == ([east, west, resistance] find side _this)", 10];
			_flag addAction [format ["<t font='%1'>Squad Management</t>", gm_wfor_boldFont], {call gm_wfor_fnc_squadManagement}, nil, 10, true, true, "", "((_target getVariable ['gm_shop_owner', objNull]) getVariable ['gm_zoneOwner',gm_efai_friendly_side]) == ([east, west, resistance] find side _this)", 10];
			_flag addAction [format ["<t font='%1'>Spawn Assistant AI</t>", gm_wfor_boldFont], {_ndud = group player createUnit [typeOf player, getPos player, [], 0, "NONE"];systemChat format ["%1 joined your squad", name (units group player select 1)];}, nil, 10, true, true, "", "(count units group player < 2) && (((_target getVariable ['gm_shop_owner', objNull]) getVariable ['gm_zoneOwner',gm_efai_friendly_side]) == ([east, west, resistance] find side _this))", 10];

			if ((count gm_wfor_builderTypes) > 0) then
			{
				_flag addAction [format ["<t font='%1'>Loading Interface</t>", gm_wfor_boldFont], {[player, baseZeus, false] call gm_wfor_fnc_builder_start}, nil, 10, true, true, "", "((_target getVariable ['gm_shop_owner', objNull]) getVariable ['gm_zoneOwner',gm_efai_friendly_side]) == ([east, west, resistance] find side _this)", 10];
			};

			// add fast travel
			if (gm_wfor_fastTravel > 0) then
			{
				_flag addAction
				[
					format ["<t font='%1'>Fast Travel</t>", gm_wfor_boldFont],
					{
						openMap true;
						hint "Click anywhere within friendly zones.\n\nClose map to cancel teleport.";
						teleported = false;
						vehicle player onMapSingleClick
						{
							_nO = nearestObjects [_pos, [gm_efai_objectiveTypes],gm_efai_zone_radius,true];
							_nSpw = nearestObjects [_pos, gm_wfor_HQTypes,50,true];
							if (count _nO > 0) then
							{
								_nO = _nO select 0;
								if ((_nO getVariable ['gm_zoneOwner', gm_efai_enemy_side]) == gm_efai_friendly_side) then
								{
									_this setPos _pos; teleported = true;
									hint text (nearestLocation [getPos _nO, ""]);
								}
							};
							if (count _nSpw > 0) then
							{
								_nSpw = _nSpw select 0;
								if ((count (_nSpw getVariable ['thisRespawn', []])) > 0) then
								{
									_this setPos _pos; teleported = true;
									hint text (nearestLocation [getPos _nSpw, ""]);
								}
							}
						};

						waitUntil {teleported or !visibleMap};
						onMapSingleClick "";
						openMap false;
						if !teleported then
						{
							hint "";
						};
					}, nil, 10, true, true, "", "((_target getVariable ['gm_shop_owner', objNull]) getVariable ['gm_zoneOwner',gm_efai_friendly_side]) == ([east, west, resistance] find side _this) and (vehicle _this == _this)", 10
				];
			};
		} forEach ((allMissionObjects gm_wfor_shopLocations) + (allMissionObjects gm_wfor_supplyLocations));

		// budget ui overlay
		if (gm_wfor_globalBudget == 0) then
		{
			[] spawn
			{
				sleep 1;
				disableSerialization;

				while {true} do
				{
					private _d = ((findDisplay 46) displayCtrl 5888);
					if isNull (_d) then
					{
						ctrlDelete ((findDisplay 46) displayCtrl 5888);
						_d = (findDisplay 46) ctrlCreate ["RscIGUIValue", 5888];
						_d ctrlSetPosition [safeZoneX+safeZoneW-0.1, safeZoneY+SafeZoneH-0.1, 0.1,0.1];
						_d ctrlSetText "test";
						_d ctrlCommit 0;
					};

					_d ctrlSetText format ["%1 %2",gm_wfor_budget, gm_wfor_currency_symbol];
					sleep 0.01;
				};
			};
		};
	};
};