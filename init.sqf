// adjustable paramters
uncertainty_dist = 200;
publicVariable "uncertainty_dist";
max_marker_size = 1500;
publicVariable "max_marker_size";
min_marker_size = 100;
publicVariable "min_marker_size";
marker_decay_rate = 10;
publicVariable "marker_decay_rate";

// scripts for the marker
set_marker = compileFinal preprocessfilelinenumbers "scripts\set_marker.sqf";
arty_track_shots = compileFinal preprocessfilelinenumbers "scripts\arty_track_shots.sqf";

marker_script_handle = nil;
publicVariable "marker_script_handle";

// tracks the shots
// [shot position, shotcount, target location]
ShotCount = [];
publicVariable "ShotCount";

// [marker position, marker size, marker fade time]
ShotLocationMarkers = [];

TAG_fnc_AddArty = 
{
    params ["_artillery_unit"];

    // fired event counts shots and sets marker on target machines
    _artillery_unit addEventHandler ["Fired", {
        params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
        
        diag_log format ["%1 fired from %2", _unit, getPos _unit];
        
        [getPos _unit] spawn arty_track_shots;
    }]; 
};


[enemy_arty1] call TAG_fnc_AddArty;
[enemy_arty2] call TAG_fnc_AddArty;
[enemy_arty3] call TAG_fnc_AddArty;
