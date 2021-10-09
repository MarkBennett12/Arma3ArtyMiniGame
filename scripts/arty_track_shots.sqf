// this function is needed to get the script handle from spawn so
// we can check if the script is running and terminate it if it is

params ["_unit"];

// have the marker start when the shots arrive plus a small random delay
// _mortar getArtilleryETA [position _target, currentMagazine _mortar];
private _target = [_unit] call TAG_fnc_GetArtyTarget;
private _eta = 0;

if (count _target > 0) then
{
  _eta = _unit getArtilleryETA [_target, currentMagazine ([_unit] call TAG_fnc_GetArtyObject)];
  
  // random [min, mid, max]
  sleep _eta + random [5, 7, 10];

  private _shot_count = [_unit] call TAG_fnc_GetArtyShotCount;
  _shot_count = _shot_count + 1;
  [_unit, _shot_count] call TAG_fnc_SetArtyShotCount;

  private _marker_location = position _unit;

  // terminte the script if it's running so we can restart from scratch
  if(!isNil "marker_script_handle") then
  {
    if(!scriptDone marker_script_handle) then
    {
      terminate marker_script_handle;
      sleep 0.2;
    };
  };

  // call the script to place the marker
  marker_script_handle = [_marker_location, _shot_count] spawn set_marker;
  publicVariable "marker_script_handle";
};
