/// @description
if (queue)  exit;
if (!instance_exists(player))  exit;


var _text0 = (global.multiplayer) ? player.name + " \n" : "";
var _text1 = "Do you want to equip this item?\n";
var _text2;

if (index < ROCKETBOOTS_INUMBER)   _text2 = "Yes, left    Yes, right      No\n";
else                               _text2 = "        Yes           No       \n";

var _text3 = GetTextboxButtons(player._input_type);
DrawTextboxExt(window_get_width() / 2, window_get_height() - 25, 500, sprite, index, _text0 + _text1 + _text2 + _text3, fa_left);