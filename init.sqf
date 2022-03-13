// adjustable paramters
uncertainty_dist = 200;
publicVariable "uncertainty_dist";
max_marker_size = 1500;
publicVariable "max_marker_size";
min_marker_size = 100;
publicVariable "min_marker_size";
marker_decay_rate = 10;
publicVariable "marker_decay_rate";

// // [marker handle, marker name, marker position, marker size, marker fade time]
// ShotLocationMarkers = [];
// publicVariable "ShotLocationMarkers";

TAG_fnc_AddArty = 
{
    params ["_artillery_unit"];

    // fired event counts shots and sets marker on target machines
    _artillery_unit addEventHandler ["Fired",
    {
        params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
        
        diag_log format ["%1 fired from %2", _unit, getPos _unit];
        
        // place the marker
        private _marker_handle = createMarkerLocal [name _unit, getPos _unit];
        _marker_handle setMarkerColorLocal "ColorRed";
        _marker_handle setMarkerShapeLocal "ELLIPSE";
        _marker_handle setMarkerBrushLocal "FDiagonal";
        _marker_handle setMarkerSizeLocal [max_marker_size, max_marker_size];
    }]; 
    
};

// addMissionEventHandler ["EachFrame",
// {
    // if (count ShotLocationMarkers > 0) then
    // {
        // {
          
        // } forEach ShotLocationMarkers;
    // };
// }];



[enemy_arty1] call TAG_fnc_AddArty;
[enemy_arty2] call TAG_fnc_AddArty;
[enemy_arty3] call TAG_fnc_AddArty;
