Arty_shot_count = 0;
publicVariable "Arty_shot_count";

// marker_funcLocal =
// {
  // params ["_marker_pos", "_shot_count"];
  
  // diag_log format ["_marker_pos = %1", _marker_pos];
  
  // deleteMarker "ArtilleryLocation";
  
  // private _size = 2000 / Arty_shot_count;
  
  // private _marker_alpha = 1;
  // private _arty_location_marker = createMarkerLocal ["ArtilleryLocation", _marker_pos];
  // _arty_location_marker setMarkerColorLocal "ColorRed";
  // _arty_location_marker setMarkerShapeLocal "ELLIPSE";
  // _arty_location_marker setMarkerBrushLocal "FDiagonal";
  // _arty_location_marker setMarkerSizeLocal [_size, _size];
  
// };

enemy_arty addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
  
  Arty_shot_count = Arty_shot_count + 1;
  publicVariable "Arty_shot_count";
  
  private _location = position _unit;

  diag_log format ["%1 fired from location %2", typeOf _unit, _location];
  
  [_location] remoteExec ["marker_funcLocal"];
}];

diag_log format ["should have created event handler now"];
