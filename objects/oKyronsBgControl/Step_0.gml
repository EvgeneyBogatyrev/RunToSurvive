///description Move layers.

if layer_exists(oRoomControl.room_properties[? "BackgroundFront"])  layer_x(oRoomControl.room_properties[? "BackgroundFront"], position);	
if layer_exists(oRoomControl.room_properties[? "BackgroundBack"])   layer_x(oRoomControl.room_properties[? "BackgroundBack"], position / 2);

//var _layers_front = ["bPineForest", "bGraveyardTrees"];
//var _layers_back = ["bMountains", "bGraveyard"];

//for (var i = 0; i < array_length_1d(_layers_front); ++i)
//{
//	if (layer_background_get_alpha(layer_background_get_id(_layers_front[i])) > 0)   layer_x(_layers_front[i], position);	
//	if (layer_background_get_alpha(layer_background_get_id(_layers_back[i])) > 0)   layer_x(_layers_back[i], position/2);	
//}

if (oRoomControl.room_properties[? "BackgroundFront"] != cur_front_layer) 
{
	var _back_from = layer_background_get_id(cur_front_layer);
	var _back_to = layer_background_get_id(oRoomControl.room_properties[? "BackgroundFront"]);
	
	layer_exists(_back_from)  layer_x(cur_front_layer, position);
	layer_background_alpha(_back_from, layer_background_get_alpha(_back_from) - 0.01);
	layer_background_alpha(_back_to, layer_background_get_alpha(_back_to) + 0.01);
	
	if (layer_background_get_alpha(_back_from) == 0)  cur_front_layer = oRoomControl.room_properties[? "BackgroundFront"];
}
if (oRoomControl.room_properties[? "BackgroundBack"] != cur_back_layer) 
{
	var _back_from = layer_background_get_id(cur_back_layer);
	var _back_to = layer_background_get_id(oRoomControl.room_properties[? "BackgroundBack"]);
	
	layer_exists(_back_from)  layer_x(cur_back_layer, position/2);
	layer_background_alpha(_back_from, layer_background_get_alpha(_back_from) - 0.01);
	layer_background_alpha(_back_to, layer_background_get_alpha(_back_to) + 0.01);
	
	if (layer_background_get_alpha(_back_from) == 0)  cur_back_layer = oRoomControl.room_properties[? "BackgroundBack"];
}

position += oRoomControl.roomspeed * (GetScale(0) - 0.2);