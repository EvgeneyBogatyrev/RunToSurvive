var _keys = Input(InputTypes.MENU);
var _left = _keys[0];
var _right = _keys[1];
var _up = _keys[2];
var _down = _keys[3];
var _restart = _keys[4];
var _quit = _keys[6];

if (_quit) room_goto(rMenu);
if (_restart)	room_restart();