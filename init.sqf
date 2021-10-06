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

// fired event counts shots and sets marker on target machines
enemy_arty addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

  hint format ["%1 fired from location %2", typeOf _unit, position _unit];
  
  Arty_shot_count = Arty_shot_count + 1;
  publicVariable "Arty_shot_count";
  
  [_unit] remoteExec ["arty_track_shots"];
}];
