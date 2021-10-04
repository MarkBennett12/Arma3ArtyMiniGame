params ["_marker_pos", "_shot_count"];

diag_log format ["_marker_pos = %1", _marker_pos];

deleteMarker "ArtilleryLocation";

private _size = 1500 / Arty_shot_count;

private _marker_alpha = 1;
private _arty_location_marker = createMarkerLocal ["ArtilleryLocation", _marker_pos];
_arty_location_marker setMarkerColorLocal "ColorRed";
_arty_location_marker setMarkerShapeLocal "ELLIPSE";
_arty_location_marker setMarkerBrushLocal "FDiagonal";
_arty_location_marker setMarkerSizeLocal [_size, _size];

while {!isnil _arty_location_marker && _marker_alpha > 0} do
{
  sleep 10;
  _marker_alpha = _marker_alpha - 0.2;
  "ArtilleryLocation" setMarkerAlphaLocal _marker_alpha;
};

deleteMarker "ArtilleryLocation";
