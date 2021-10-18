// this function is needed to get the script handle from spawn so
// we can check if the script is running and terminate it if it is

params ["_shot_pos"];

private _shot_counted = false;

// check for existing shot near this position
if ((count ShotCount) > 0) then
{
    {
        if (((_x select 0) distance _shot_pos) < uncertainty_dist) exitWith
        {
            // new position is average of old position and new shot position
            private _new_pos = ((_x select 0) vectorAdd _shot_pos) vectorMultiply 0.5;
            _x set [0, _new_pos];
            
            // increment shot count at this position
            _x set [1, ((_x select 1) + 1)];
            
            [(_x select 0), (_x select 1)] spawn set_marker;
            
            _shot_counted = true;
        }
    }
    forEach ShotCount;   
};

if(_shot_counted == false) then
{
    ShotCount pushBack [_shot_pos, 1, []];
    [_shot_pos, 1] spawn set_marker;    
};

//hint format ["%1 shots fired from location %2", (ShotCount select 1), (ShotCount select 0)];
diag_log ShotCount;

