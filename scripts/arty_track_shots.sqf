params ["_artyPiece"];

diag_log format ["arty_track_shots started for %1", name _artyPiece];

waitUntil {alive _artyPiece};

while {alive _artyPiece} do
{  
  hint format ["%1 is alive", name  _artyPiece];
  diag_log format ["%1 is alive", name  _artyPiece];
  sleep 60;
};
