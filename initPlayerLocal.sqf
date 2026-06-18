player createDiaryRecord ["Diary", ["HELP", loadFile "gm_info.txt"]];
player createDiaryRecord ["Diary", ["CHANGE LOG",  ([loadFile "changelog.txt", toString [10],true] call BIS_fnc_splitString) joinString "<br />" ]];
player createDiaryRecord ["Diary", ["WAR MACHINE", loadFile "briefing.txt"]];
sleep 1;
call gm_wfor_fnc_tutorial;
hint "Check the briefing for details on how to collect funds and purchase gear.";
player setSpeaker "NoVoice";

gm_vl_excluded_magazines = ["gm_1Rnd_luna_nuc_3r10"]; // No nukes

player addEventHandler ["InventoryClosed",
{
	params["_dude"];
	if local _dude then
	{
		if isNil "gm_wfor_pc_data" then {gm_wfor_pc_data = [face player, ""]};
		_dude setVariable ["BIS_fnc_setUnitInsignia_class", nil]; // clear the var as otherwise the BI function doesn't re-add it if it was the same as previous
		[_dude, gm_wfor_pc_data select 1] call BIS_fnc_setUnitInsignia;
	};
}];

"gm_wfor_pc_data" addPublicVariableEventHandler
{
	[player, (_this select 1) select 0] remoteExec ["setFace", 0, true];
	[player, (_this select 1) select 1] call BIS_fnc_setUnitInsignia;
};

sleep 5;
{
	// restore appearance
	[player, gm_wfor_pc_data select 0] remoteExec ["setFace", 0, true];
	[player, gm_wfor_pc_data select 1] call BIS_fnc_setUnitInsignia;
};