function NewBackround(_layer_sprites, _initial = false)
{
	
	var _layers = []
	for (var _i = 0; _i < array_length(_layer_sprites); _i++)
	{
		var _new_layer = CreateBgLayerFromSprite(_layer_sprites[_i], 300 + (100 * _i));
		layer_y(_new_layer, layer_get_y(_new_layer) - _i * 100)
		layer_background_alpha(layer_background_get_id(_new_layer), _initial);
		array_push(_layers, _new_layer);
	}
	
	return _layers;
}

function CreateBgLayerFromSprite(_sprite, _depth)
{
	var _layer = layer_create(_depth);
	
	var _bg = layer_background_create(_layer, _sprite);
	
	var _bg_height = sprite_get_height(_sprite);
	
	layer_y(_layer, oGenerator.ground[0] - _bg_height);
	
	layer_background_htiled(_bg, true);
	
	return _layer;
	
}

function FadeLayers(_layers_from, _layers_to, _step)
{
	var _done = true;
	for (var _i = 0; _i < array_length(_layers_from); _i++)
	{
		var _layer_id = layer_background_get_id(_layers_from[_i]);
		var _alpha = layer_background_get_alpha(_layer_id);
		_alpha = max(0, _alpha - _step);
		layer_background_alpha(_layer_id, _alpha)

		if _alpha > 0 _done = false;
	}
	
	for (var _i = 0; _i < array_length(_layers_to); _i++)
	{
		var _layer_id = layer_background_get_id(_layers_to[_i]);
		var _alpha = layer_background_get_alpha(_layer_id);
		_alpha = min(1, _alpha + _step);
		layer_background_alpha(_layer_id, _alpha)
		
		if _alpha < 1 _done = false;
	}
	
	return _done;
}


function Parallax(_layers)
{
	for (var _i = 0; _i < array_length(_layers); _i++)
	{
		layer_x(_layers[_i], position * (array_length(_layers) - _i) / array_length(_layers));
	}
}

function GetCurrrentBgSprites()
{
	return ds_map_find_value(oRoomControl.room_properties, "BackgroundLayers")
}

function ChangeBackgrounds()
{
	
	oBackgroundControl.new_layers = NewBackround(GetCurrrentBgSprites())
	
	oBackgroundControl.fade = true;
	
}