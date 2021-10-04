params ["_artyPiece"];
private _shotCount = 0;

diag_log format ["arty_track_shots started for %1", typeOf _artyPiece];




waitUntil {alive _artyPiece};

while {alive _artyPiece} do
{  
  sleep 10;
  diag_log format ["%1 is still alive", typeOf  _artyPiece];
};

