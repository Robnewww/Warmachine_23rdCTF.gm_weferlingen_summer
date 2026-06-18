//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, Dec 2019
//////////////////////////////////////////

_this spawn
{
	private ["_lb", "_lib", "_total"];

	_display = uiNameSpace getVariable ["gm_wfor_shop", displayNull];
	_lb = _display displayCtrl 200;

	_lib = _display getVariable ["mainLibrary", []];

	// deduct money
	_budget = missionNameSpace getVariable ["gm_wfor_budget", gm_wfor_startingBudget];
	_total = _display getVariable ["total",1000000000000];



	if (_total <= _budget) then
	{
		// do the transaction

		// update budget locally at least for instant response, or globally in case of communism
		missionNameSpace setVariable ["gm_wfor_budget", (_budget - _total), (gm_wfor_globalBudget == 1)];

		if (gm_wfor_globalBudget == 0) then
		{
			[player call BIS_fnc_netId, (_total * -1)] remoteExec ["gm_wfor_fnc_accounting_server", 2];
		};

		_items = [];
		_bigCrate = false;
		_dqty = 0;
		for "_ci" from 0 to ((lbSize _lb)-1) do
		{
			_qty = (call compile (_lb lbTextRight _ci));
			_dqty = _dqty + _qty;
			_items pushback ((_lib select (_lb lbValue _ci))+[_qty]);
		};

		_display closeDisplay 0;

		private ["_container"];
		if (count _items > 0) then
		{
			_ctype = if (_dqty > 6) then {gm_wfor_container_large} else {gm_wfor_ammoBox_small};
			_container = _ctype createVehicle [1,1,1];

			// delete crate unless actually needed. Ugly shortcut.
			_deleteCrate = true;
			{
				_x params ["_realm", "_class", "_cost", "_amount"];
				_fidx = _forEachIndex;

				if ((toLower _realm) == "cfgweapons") then {_deleteCrate = false; _container addItemCargoGlobal  [_class, _amount];};
				if ((toLower _realm) == "cfgmagazines") then {_deleteCrate = false; _container addItemCargoGlobal  [_class, _amount];};
				if ((toLower _realm) == "cfgGlasses") then {_deleteCrate = false; _container addItemCargoGlobal  [_class, _amount];};

				if ((toLower _realm) == "cfgvehicles") then
				{
					// Find out if its a backpack or an actual vehicle...
					if (getNumber (configFile >> "CfgVehicles" >> _class >> "isbackpack") == 1) then
					{
						_deleteCrate = false;
						_container addBackpackCargoGlobal [_class, _amount];
					} else
					{
						for "_i" from 1 to _amount do
						{
							// its a vehicle
							_vic = _class createVehicle [1,1,10];
							_vic allowDamage false;
							//
							_spawnPos = ([getpos player, 15, 200, 10, 0] call BIS_fnc_findSafePos) + [0.5];

							openMap true;
							hint "Select a position for the vehicle.";
							mapAnimAdd [0, 0.1, getpos player];
							mapAnimCommit;
							gm_placementDone = false;
							gm_placementDonePos = _spawnPos;
							vehicle player onMapSingleClick
							{
								if (_pos distance player < (gm_efai_zone_radius * 0.5)) then
								{
									gm_placementDonePos = ([_pos, 0, 10, 10, 0] call BIS_fnc_findSafePos) + [0.5];
									gm_placementDone = true;
									hint "";
								} else
								{
									hint "Location too far away.";
								};
							};

							waitUntil {gm_placementDone or !visibleMap};
							onMapSingleClick "";
							openMap false;
							if !gm_placementDone then
							{
								hint "";
							};

							// secondary check that the placement pos was legit
							if ((gm_placementDonePos distance player) > (gm_efai_zone_radius * 0.5)) then
							{
								// fall back to old
								gm_placementDonePos = _spawnPos;
							};

							_vic setPos gm_placementDonePos;

							// cleanup start loadout and assign user actions and variables
							_vic call gm_wfor_fnc_vehicle_setup;

							if (gm_wfor_shipDirect == 1) then
							{
								player moveInAny _vic;
							};

							// If it's a luna, we must make it a one-shot vehicle. THis is a terrible way to fix it, but its temporary until there is an engine fix
							if (_vic isKindOf "gm_2p16_base") then
							{
								_vic addEventHandler
								[
									"Fired",
									{
										params ["_unit", "_weapon"];
										if (_weapon == "gm_luna_launcher") then
										{
											_unit removeWeaponTurret ["gm_luna_launcher", [0]];
										};
									}
								];
							};

							// Open customizer for last bought vehicle
							if (_fidx == (count _items-1)) then
							{
								_vic spawn
								{
									_this call gm_core_vehicles_fnc_vic_customizer_init;
									sleep 2;
									// make spawncontainers indestructible by not re-enabling their damage
									if !(_this isKindOf "thingx") then {_this allowDamage true;};
								};
							};
						};
					};
				};
			} forEach _items;

			if _deleteCrate then {deleteVehicle _container} else
			{
				_spawnPos = [getPos player, 5, 60, 2, 0] call BIS_fnc_findSafePos;
				_container setPos _spawnPos;
				if (gm_wfor_shipDirect == 1) then
				{
					player setPos getPos _container;
				};
				nul = _container spawn
				{
					sleep 300;
					deleteVehicle _this;
				};
			};
		};

		if (!isNull _container) then
		{
			player action ["gear", _container];
		};
	} else
	{
		hint "Credit verification failed. Check balance.";
		[_display] call gm_wfor_fnc_shop_updateTotal;
		playSound "3DEN_notificationWarning";
	};
};