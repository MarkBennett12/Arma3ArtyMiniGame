// tracks the shots
Arty_shot_count = 0;
publicVariable "Arty_shot_count";

// adjustable paramters
uncertainty_dist = 500;
publicVariable "uncertainty_dist";
max_size = 1500;
publicVariable "max_size";
min_size = 100;
publicVariable "min_size";
decay_rate = 20;
publicVariable "decay_rate";

// scripts for the marker
set_marker = compileFinal preprocessfilelinenumbers "scripts\set_marker.sqf";
arty_track_shots = compileFinal preprocessfilelinenumbers "scripts\arty_track_shots.sqf";

marker_script_handle = nil;
publicVariable "marker_script_handle";

// [object,  arty position, shotcount, target location]
ArtyData = [];
publicVariable "ArtyData";

// [marker position, marker size, marker alpha]
ArtyMarkers = [];

TAG_fnc_AddArty = 
{
    params ["_arty"];

    ArtyData pushBack [_arty, position _arty, 0, [], [], 0, 0];
    publicVariable "ArtyData";
    diag_log ArtyData;

    // fired event counts shots and sets marker on target machines
    _arty addEventHandler ["Fired", {
        params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

        hint format ["%1 fired from location %2", typeOf _unit, position _unit];

        [_unit] remoteExec ["arty_track_shots"];
    }];  
};

TAG_fnc_GetArtyDataElem = 
{
    params ["_arty", "_element"];

    {
        if((_x select 0) isEqualTo  _arty) exitWith
        {
            _x select _element;
        };
    } forEach ArtyData; 
};

TAG_fnc_SetArtyDataElem = 
{
    params ["_arty", "_element", "_val"];

    {
        if((_x select 0) isEqualTo  _arty) exitWith
        {
            _x set [_element, _val];
            publicVariable "ArtyData";
        };
    } forEach ArtyData;     
};

TAG_fnc_GetArtyObject = 
{
    params ["_arty"];

    [_arty, 0] call TAG_fnc_GetArtyDataElem;
};

TAG_fnc_GetArtyShotCount = 
{
    params ["_arty"];

    [_arty, 2] call TAG_fnc_GetArtyDataElem;
};

TAG_fnc_SetArtyShotCount = 
{
    params ["_arty", "_shot_count"];

    [_arty, 2, _shot_count] call TAG_fnc_SetArtyDataElem;
};

TAG_fnc_GetArtyTarget = 
{
    params ["_arty"];

    [_arty, 3] call TAG_fnc_GetArtyDataElem;
};

TAG_fnc_SetArtyTarget = 
{
    params ["_arty", "_target"];

    [_arty, 3, _target] call TAG_fnc_SetArtyDataElem;
};

TAG_fnc_GetArtyMarkerPos = 
{
    params ["_arty"];

    [_arty, 4] call TAG_fnc_GetArtyDataElem;
};

TAG_fnc_SetArtyMarkerPos = 
{
    params ["_arty", "_target"];

    [_arty, 4, _target] call TAG_fnc_SetArtyDataElem;
};

TAG_fnc_GetArtyMarkerSize = 
{
    params ["_arty"];

    [_arty, 5] call TAG_fnc_GetArtyDataElem;
};

TAG_fnc_SetArtyMarkerSize = 
{
    params ["_arty", "_target"];

    [_arty, 5, _target] call TAG_fnc_SetArtyDataElem;
};

TAG_fnc_GetArtyMarkerAlpha = 
{
    params ["_arty"];

    [_arty, 6] call TAG_fnc_GetArtyDataElem;
};

TAG_fnc_SetArtyMarkerAlpha = 
{
    params ["_arty", "_target"];

    [_arty, 6, _target] call TAG_fnc_SetArtyDataElem;
};



[enemy_arty1] call TAG_fnc_AddArty;
[enemy_arty2] call TAG_fnc_AddArty;
