1 spawn
{
	if isServer then
	{
		while {true} do
		{
			enableEnvironment false;
			_allplayers = call BIS_fnc_listPlayers;

			sleep 60;
			// cleanUp crates that somehow didn't timeOut
			{
				_item = _x;
				_del = true;
				{
					if ((_x distance2d _item) < 300) then
					{
						_del = false;
					};
				} forEach _allplayers;
				if _del then
				{
					deleteVehicle _item;
				};
			} forEach ((allMissionObjects "ReammoBox") + (allMissionObjects "ReammoBox_F"));

			// cleanUp dead that somehow didn't timeOut
			{
				if (!alive _x and !isPlayer _x) then
				{
					_del = true;
					_item = _x;
					{
						if ((_x distance2d _item) < 700) then
						{
							_del = false;
						};
					} forEach _allplayers;
					if _del then
					{
						deleteVehicle _item;
					};
				};
			} forEach ((allMissionObjects "Man") + (allDeadMen));

			// group police
			_eSide = ([east, west, resistance] select gm_efai_enemy_side);
			{
				if (side _x == _eSide) then
				{
					_x deleteGroupWhenEmpty true;
				};
			} forEach allGroups;

			// delete all sim-disabled units within 200m of players
			{
				_curpl = _x;
				{
					if !(simulationEnabled _x) then
					{
						if (side _x != side _curpl) then
						{
							_vic = vehicle _x;
							moveOut _x;
							deleteVehicle _x;
							deleteVehicle _vic;
							diag_log "deleting sim-disabled unit";
						};
					};
				} forEach nearestObjects [_x, ["Man"], 200];
			} forEach _allplayers;
		};
	};
};