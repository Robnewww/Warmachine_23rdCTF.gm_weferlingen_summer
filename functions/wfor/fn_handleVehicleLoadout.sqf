_vic = _this;

disableSerialization;

_nearTrucks = nearestObjects [getPos _vic, gm_wfor_ammoVicTypes, 20, true];
if (count _nearTrucks > 0) then
{
	// launch the interface
	gm_wfor_vl_temp_truck = _nearTrucks select 0;

	if (getAmmoCargo gm_wfor_vl_temp_truck > 0) then
	{
		_vic call gm_core_vehicles_fnc_vic_loadout_init;
		_timeout = time + 1;
		_disp = displayNull;
		waitUntil
		{
			_disp = uiNameSpace getVariable ["gm_vl_disp", displayNull];
			(!isNull _disp) or (time > _timeout)
		};

		// We have hooked into the display of the customizer and can now wait for the button to confirm
		if !isNull _disp then
		{
			(_disp displayCtrl 300) ctrlAddEventHandler
			[
				"ButtonClick",
				{
					if !isNil "gm_wfor_vl_temp_truck" then
					{
						_ca = (getAmmoCargo gm_wfor_vl_temp_truck) - 0.000000005; // deduct about a 12.5% from the truck

						gm_wfor_vl_temp_truck setAmmoCargo _ca; // run twice again to be sure
						gm_wfor_vl_temp_truck setAmmoCargo _ca; // run twice again to be sure

						// specific to the 10t
						if (_ca < 0.00000002) then {gm_wfor_vl_temp_truck animateSource ["ammo_155mm_02_unhide", 0]};
						if (_ca < 0.000000001) then {gm_wfor_vl_temp_truck animateSource ["ammo_155mm_01_unhide", 0]};

						gm_wfor_vl_temp_truck = nil;
					};
				}
			];
		};
	} else
	{
		systemChat "The nearby ammo truck does not have enough cargo left to change the loadout!";
	};
};