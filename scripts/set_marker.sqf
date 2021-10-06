params ["_marker_pos"];

// remove any previous markers before placing a new one
deleteMarker "ArtilleryLocation";

// the marker and uncertainty distance get smaller with each shot to the minimum distance
private _dist = uncertainty_dist;
private _size = max_size;

if(Arty_shot_count > 0) then
{
  _dist = uncertainty_dist / Arty_shot_count;
  _size = min_size + ((max_size - min_size) / Arty_shot_count);
};

// offset the marker by the uncertainty distance which gets reduced by each shot
private _random_pos =[random 1, random 1, 0];
_offset_pos = ((vectorNormalized _random_pos) vectorMultiply _dist) vectorAdd _marker_pos;

// transparency to fade marker
private _marker_alpha = 1;

// place the marker
private _arty_location_marker = createMarkerLocal ["ArtilleryLocation", _offset_pos];
_arty_location_marker setMarkerColorLocal "ColorRed";
_arty_location_marker setMarkerShapeLocal "ELLIPSE";
_arty_location_marker setMarkerBrushLocal "FDiagonal";
_arty_location_marker setMarkerSizeLocal [_size, _size];
"ArtilleryLocation" setMarkerAlphaLocal _marker_alpha;

// fade the marker out over time
while {_marker_alpha > 0} do
{
  sleep 1;
  _marker_alpha = _marker_alpha - 0.1;
  "ArtilleryLocation" setMarkerAlphaLocal _marker_alpha;
};

// clean up afterwards
deleteMarker "ArtilleryLocation";
