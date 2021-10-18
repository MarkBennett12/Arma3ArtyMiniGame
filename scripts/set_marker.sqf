params ["_marker_pos", "_shot_count"];

// the marker and uncertainty distance get smaller with each shot to the minimum distance
private _dist = uncertainty_dist;
private _size = max_marker_size;

if (count ShotLocationMarkers > 0) then
{
    {
        if ((_x select 1) distance _marker_pos < uncertainty_dist) exitWith
        {
            private _old_marker_handle = _x select 0;
            deleteMarker "_old_marker_handle";
        };

    } forEach ShotLocationMarkers;
};

if(_shot_count > 0) then
{
    _dist = uncertainty_dist / _shot_count;
    _size = min_size + ((max_marker_size - min_marker_size) / _shot_count);
};

// offset the marker by the uncertainty distance which gets reduced by each shot
private _random_pos =[random 1, random 1, 0];
_offset_pos = ((vectorNormalized _random_pos) vectorMultiply _dist) vectorAdd _marker_pos;

private _marker_name = str _offset_pos;

// place the marker
private _marker_handle = createMarkerLocal [_marker_name, _offset_pos];
_marker_handl setMarkerColorLocal "ColorRed";
_marker_handl setMarkerShapeLocal "ELLIPSE";
_marker_handl setMarkerBrushLocal "FDiagonal";
_marker_handl setMarkerSizeLocal [_size, _size];

//_marker_name setMarkerAlphaLocal _marker_alpha;


ShotLocationMarkers pushBack [_marker_handle, _marker_name, _offset_pos, max_marker_size, marker_decay_rate];


diag_log ShotLocationMarkers;




// // remove any previous markers before placing a new one
// deleteMarker "ArtilleryLocation";




// // transparency to fade marker
// private _marker_alpha = 1;


// // fade the marker out over time
// private _increment = 1 / marker_decay_rate;
// while {_marker_alpha > 0} do
// {
    // sleep 1;
    // _marker_alpha = _marker_alpha - _increment;
    // "ArtilleryLocation" setMarkerAlphaLocal _marker_alpha;
// };

// // clean up afterwards
// deleteMarker "ArtilleryLocation";
