params ["_artyPiece"];

sleep random [2, 2.5, 3];
private _target_location = [3636, 5272, 0];
//[_artyPiece, _target_location] call TAG_fnc_SetArtyTarget;
_artyPiece doArtilleryFire [_target_location, "32Rnd_155mm_Mo_shells_O", 10];
