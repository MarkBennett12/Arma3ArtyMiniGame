// adjustable paramters
max_marker_size = 1000.0;
publicVariable "max_marker_size";
min_marker_size = 100.0;
publicVariable "min_marker_size";

// [marker handle, marker name, marker position, marker size, marker creation time, shot count]
ShotLocationMarkers = [];
publicVariable "ShotLocationMarkers";


// logistic function for marker shrinking
glf =
{
    params ["_x"];
    
    private _a = 1.04302;
    private _b = 0.9;
    private _c = 0.3;
    private _k = 0.721;
    private _q = 12.2;
    private _v = 1.7;
    
    private _y = _a + ((_k - _a) / (_c + _q * ((exp 1)^(-_b * _x)))^(1 / _v));
    
    _y;
};

TAG_fnc_AddArty = 
{
    params ["_artillery_unit"];

    // fired event counts shots and sets marker on target machines
    _artillery_unit addEventHandler ["Fired",
    {
        params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
        
        private _markerSize = max_marker_size;
        private _shotcount = 1;
        private _shotLocation = getPos _unit;
        
        
        // are we within an existng marker
        private _foundResult = ShotLocationMarkers findIf { (_x select 2) distance _shotLocation < _markerSize };
        diag_log format ["found marker index = %1, shot location = %2, old location = %3, marker size = %4", _foundResult, _shotLocation, (_x select 2), _markerSize];
        
        if(_foundResult > -1) then
        {
            _shotcount = (ShotLocationMarkers select _foundResult) select 5;
        
            // calculate shrinkage as a power function             
            private _markerSizeRange = max_marker_size - min_marker_size;
            private _shrinkAmount = _shotcount call glf;

            _markerSize = (_markerSizeRange * _shrinkAmount) + min_marker_size;
            _shotcount = _shotcount + 1;

            // remove the old marker
            deleteMarker ((ShotLocationMarkers select _foundResult) select 1);            
            ShotLocationMarkers deleteAt _foundResult;            
        };
        
        
        
        // make location uncertain
        private _randomOffset = random [0 -_markerSize, 0, _markerSize];        
        
        private _location = [];
        _location set [0, (_shotLocation select 0) + _randomOffset];
        _location set [1, (_shotLocation select 1) + _randomOffset];
        
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
        ShotLocationMarkers pushBack [_marker_handle, _markerName, _location, _markerSize, time, _shotcount];
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
