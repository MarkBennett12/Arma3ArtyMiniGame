// tracks the shots
Arty_shot_count = 0;
publicVariable "Arty_shot_count";

// adjustable paramters
uncertainty_dist = 500;
publicVariable "uncertainty_dist";
max_size = 1500;
publicVariable "max_size";
min_size = 100;
publicVariable "min_size";
decay_rate = 20;
publicVariable "decay_rate";

// scripts for the marker
set_marker = compileFinal preprocessfilelinenumbers "scripts\set_marker.sqf";
arty_track_shots = compileFinal preprocessfilelinenumbers "scripts\arty_track_shots.sqf";

marker_script_handle = nil;
publicVariable "marker_script_handle";

// [object,  arty position, shotcount, target location]
ArtyData = createHashMap;
publicVariable "ArtyData";

TAG_fnc_AddArty = 
{
  params ["_arty"];
  
  private _id = _arty call BIS_fnc_netId;
  ArtyData set [_id, [_arty, position _arty, 0, []]];
  publicVariable "ArtyData";
};

TAG_fnc_GetArtyDataElem = 
{
  params ["_arty", "_element"];
  
  private _id = _arty call BIS_fnc_netId;
  private _data = ArtyData get _id;
  _data select _element;
};

TAG_fnc_SetArtyDataElem = 
{
  params ["_arty", "_element", "_val"];
  
  private _id = _arty call BIS_fnc_netId;
  private _data = ArtyData get _id;
  _data set [_element, _val];

  ArtyData set [_id, _data];
  publicVariable "ArtyData";
};

TAG_fnc_GetArtyObject = 
{
  params ["_arty"];
  
  [_arty, 0] call TAG_fnc_GetArtyDataElem
};


TAG_fnc_GetArtyShotCount = 
{
  params ["_arty"];
  
  [_arty, 2] call TAG_fnc_GetArtyDataElem
};

TAG_fnc_SetArtyShotCount = 
{
  params ["_arty", "_shot_count"];
  
  [_arty, 2, _shot_count] call TAG_fnc_SetArtyDataElem;
};

TAG_fnc_GetArtyTarget = 
{
  params ["_arty"];
  
  [_arty, 3] call TAG_fnc_GetArtyDataElem
};

TAG_fnc_SetArtyTarget = 
{
  params ["_arty", "_target"];
  
  [_arty, 3, _target] call TAG_fnc_SetArtyDataElem;

};

[enemy_arty] call TAG_fnc_AddArty;

// fired event counts shots and sets marker on target machines
enemy_arty addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

  hint format ["%1 fired from location %2", typeOf _unit, position _unit];
    
  [_unit] remoteExec ["arty_track_shots"];
}];
