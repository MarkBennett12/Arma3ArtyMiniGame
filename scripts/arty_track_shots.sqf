// this function is needed to get the script handle from spawn so
// we can check if the script is running and terminate it if it is

params ["_unit"];

// terminte the script if it's running so we can restart from scratch
if(!isNil "marker_script_handle") then
{
  if(!scriptDone marker_script_handle) then
  {
    diag_log text "terminating marker script";
    terminate marker_script_handle;
    sleep 0.2;
  };
};

diag_log format ["arty_track_shots started for %1", typeOf _unit];

// call the script to place the marker
private _location = position _unit;
marker_script_handle = [_location] spawn set_marker;
publicVariable "marker_script_handle";
