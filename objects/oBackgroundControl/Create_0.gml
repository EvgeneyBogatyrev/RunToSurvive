/// @description Setting standart for room

position = 0;

cur_front_layer = "bPineForest";
cur_back_layer = "bMountains";

var _backgrounds = ["bPineForest", "bMountains", "bGraveyard", "bGraveyardTrees", "bSpamCity"];
var _len = array_length(_backgrounds);
for (var i = 0; i < _len; ++i)  layer_background_alpha(layer_background_get_id(_backgrounds[i]), 0);


layers = [];
new_layers = [];
fade = false;
fade_speed = 0.01;



