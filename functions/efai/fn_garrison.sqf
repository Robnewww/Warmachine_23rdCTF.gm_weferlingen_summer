if isServer then
{
	_houses = ((nearestTerrainObjects [getpos leader _this, ["House", "Building"], 500, false, true]));
	{
		{
			doStop _x;
			_x setUnitPos "UP";
			_h = (selectRandom _houses);
			_x setPos selectRandom (_h buildingPos -1);
			_x setDir ((_h getRelDir _x) + getDir _h);
		}
		forEach units _x
	} forEach units _this;
};