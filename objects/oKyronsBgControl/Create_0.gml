/// @description Setting standart for room

position = 0;

backgrounds = [];

cur_front_layer = "bPineForest";
cur_back_layer = "bMountains";

var _backgrounds = ["bGraveyard", "bGraveyardTrees"];
var _len = array_length_1d(_backgrounds);
for (var i = 0; i < _len; ++i)  layer_background_alpha(layer_background_get_id(_backgrounds[i]), 0);
