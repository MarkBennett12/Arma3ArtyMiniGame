// adjustable paramters
max_marker_size = 1000;
publicVariable "max_marker_size";
min_marker_size = 200;
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
        
        private _markerSize = max_marker_size;
        
        // are we within an existng marker
        private _foundResult = ShotLocationMarkers findIf { (_x select 2) distance getPos _unit < _markerSize };
        
        if(_foundResult > -1) then
        {
            // shrink the marker size to min size
            private _oldMarkerSize = ((ShotLocationMarkers select _foundResult) select 3);
            if(_oldMarkerSize < min_marker_size) then
            {
                _markerSize = min_marker_size;
            }
            else
            {
                _markerSize = _oldMarkerSize / 2;
            };

            // remove the old marker
            deleteMarker ((ShotLocationMarkers select _foundResult) select 1);            
            ShotLocationMarkers deleteAt _foundResult;            
        };
        
        // make location uncertain
        private _randomOffset = random [0 -_markerSize, 0, _markerSize];
        hint str _randomOffset;
        
        private _location = [];
        _location set [0, (getPos _unit select 0) + _randomOffset];
        _location set [1, (getPos _unit select 1) + _randomOffset];
        
        // create marker name based on position
        private _xStr = str (round (_location select 0));
        private _yStr = str (round (_location select 1));
        private _markerName = _xStr + _yStr;
                
        // place the marker
        private _marker_handle = createMarkerLocal [_markerName, _location];
        _marker_handle setMarkerColorLocal "ColorRed";
        _marker_handle setMarkerShapeLocal "ELLIPSE";
        _marker_handle setMarkerBrushLocal "FDiagonal";
        _marker_handle setMarkerSizeLocal [_markerSize, _markerSize];
        
        
        // keep track of the markers
        ShotLocationMarkers pushBack [_marker_handle, _markerName, _location, _markerSize, time];
                
        //diag_log ShotLocationMarkers;
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
