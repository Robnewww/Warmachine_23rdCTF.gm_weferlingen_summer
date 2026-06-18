//////////////////////////////////////////
//
//  Global Mobilization War Machine
//
//  Copyright: Mondkalb, Dec 2019
//////////////////////////////////////////

params ["_grp","_dst",["_type", "MOVE"],["_delay",[1,1,1]],["_force",false]];

// make destination uncertain depending on distance
private _wp =_grp addWaypoint [_dst, 1];
if _force then
{
	_grp setCurrentWaypoint _wp;
};

_wp setWaypointTimeout _delay;
_wp setWaypointType _type;

_wp
