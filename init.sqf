// adjustable paramters
max_marker_size = 1500;
publicVariable "max_marker_size";
min_marker_size = 100;
publicVariable "min_marker_size";

// [marker handle, marker name, marker position, marker size, marker creation time]
ShotLocationMarkers = [];
publicVariable "ShotLocationMarkers";

TAG_fnc_AddArty = 
{
    params ["_artillery_unit"];

    // fired event counts shots and sets marker on target machines
    _artillery_unit addEventHandler ["Fired",
    {
        params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
        
        // make location uncertain
        private _location = [];
        _location set [0, ((getPos _unit select 0) + (random (max_marker_size * 2)) - max_marker_size)];
        _location set [1, ((getPos _unit select 1) + (random (max_marker_size * 2)) - max_marker_size)];
        
        // create marker name based on position
        private _xStr = str (round (_location select 0));
        private _yStr = str (round (_location select 1));
        private _markerName = _xStr + _yStr;
        
        hint _markerName;
        
        
        // place the marker
        private _marker_handle = createMarkerLocal [_markerName, _location];
        _marker_handle setMarkerColorLocal "ColorRed";
        _marker_handle setMarkerShapeLocal "ELLIPSE";
        _marker_handle setMarkerBrushLocal "FDiagonal";
        _marker_handle setMarkerSizeLocal [max_marker_size, max_marker_size];
        
        
        // add marker to array
        //ShotLocationMarkers pushBack [];
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
