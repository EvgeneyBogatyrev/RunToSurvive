/// @description Create obstacle on the position
/// @param obstacle_type Type of an obstacle
/// @param start X position
/// @param row Row to create
function CreateEnvironment(argument0, argument1, argument2) {

	var _obstacle_type = argument0;
	var _start = argument1;
	var _row = argument2;

	switch (_obstacle_type) 
	{
		case Obstacles.EMPTY :
			break;
		
		case Obstacles.AREA :
			var _enemy = choose(oStump, oArcher, oBilly);
			Create(_start + oCamera.view_w_half/2, oGenerator.ground[_row], _enemy, _row);
			break;
		
		case Obstacles.BIG :
			with(Create(_start + oCamera.view_w_half/2, oGenerator.ground[_row], oObstacle, _row))
			{
				sprite_index = oRoomControl.room_properties[? "ObstacleBigSprite"];
				image_index = choose(0, 1);
			}
			break;
		
		case Obstacles.SMALL :
			with(Create(_start + oCamera.view_w_half/2, oGenerator.ground[_row], oObstacle, _row))
			{
				sprite_index = oRoomControl.room_properties[? "ObstacleSmallSprite"];
				image_index = choose(0, 1);
			}
		
			break;
	
		case Obstacles.BLOCKS :
			var _shape = GetShape();
			var _scale = GetScale(_row);
			
			var _surface_width = array_length(_shape[0]) * BLOCKSIZE * _scale;			
			var _surface_height = array_length(_shape) * BLOCKSIZE * _scale;
			
			var _draw_surface = surface_create(_surface_width, _surface_height);
			surface_set_target(_draw_surface);
			
			for (var _height = array_length(_shape) - 1; _height >= 0; --_height)
			{
				var _line = _shape[_height];
				var _level = array_length(_shape) - _height;
				for (var _elem = 0; _elem < array_length(_shape[_height]); ++_elem)	
				{
					if (_line[_elem] != 0) 
					{
						var _sprite_index = abs(_line[_elem]);
						var _draw_sprite;
						
						switch (_sprite_index)
						{
							case 4:
								_draw_sprite = oRoomControl.room_properties[? "BlockEmptySprite"];
								break;
							case 2:
								_draw_sprite = oRoomControl.room_properties[? "BlockRoundedLeftSprite"];
								break;
							case 3:
								_draw_sprite = oRoomControl.room_properties[? "BlockRoundedRightSprite"];
								break;
							case 1:
								_draw_sprite = oRoomControl.room_properties[? "BlockSprite"];
								break;
							
							default:
								Raise("Invalid block sprite index\n");
								break;
						}	
						
						draw_sprite_ext(_draw_sprite, floor(random(sprite_get_number(_draw_sprite))), _start + _elem * (BLOCKSIZE - 1) * _scale, oGenerator.ground[_row] - _level * BLOCKSIZE * _scale, _scale, _scale, 0, c_white, 1);
						
						/*with (Create(_start + _elem * (BLOCKSIZE - 1) * _scale, oGenerator.ground[_row] - _level * BLOCKSIZE * _scale, oStructureBlock, _row)) //-1
						{
							
						
							if (_line[_elem] < 0 && (irandom_range(1, 100) > 90 || global.level_started)) 
							{
								global.level_started = false;
								Create(_start + _elem * (BLOCKSIZE - 1) * _scale - 1, oGenerator.ground[_row] - (_level) * BLOCKSIZE * _scale, oChest, _row)	;
							}
						
							if (_level == 1)
							{
								var _collider = GetCollider(x, y + BLOCKSIZE * scale, oGroundBlock, row);
								if (_collider != noone)
								{
									_collider.sprite_index = oRoomControl.room_properties[? "BlockEmptySprite"];
								}
							}
						
						}
						*/
					}
				}
			}
			surface_reset_target();
			
			_block_sprite_index = sprite_create_from_surface(_draw_surface, 0, _surface_height, _surface_width, _surface_height, false, false, 0, 0);
			Print(_block_sprite_index);
			with (Create(_start, oGenerator.ground[_row], oStructureBlock, _row))
			{
				sprite_index = other._block_sprite_index;
				mask_index = other._block_sprite_index;
			}
			surface_free(_draw_surface);
			break;
		
		case Obstacles.CHARGE_STATION :
		
			var _object = oChargeStation;
			with (oPlayer)
			{
				//Print(revival_number,", " ,instance_exists(oCloningStation));
				
				randomize();
				if (revival_number > 0 && !instance_exists(oCloningStation) && irandom_range(0, 100) < 30)  _object = oCloningStation;	
				if (irandom_range(0, 100) < 5)	_object = oChest;
			}
		
			Create(_start + oCamera.view_w_half/2, oGenerator.ground[_row], _object, _row);
			break;
		
		default :
			break;
	}



}


function CreateConstruct(_start, _row, _shape, _only_update=false) {
	var _scale = GetScale(_row);
	for (var _height = array_length(_shape) - 1; _height >= 0; --_height)
	{
		var _line = _shape[_height];
		var _level = array_length(_shape) - _height;
		for (var _elem = 0; _elem < array_length(_shape[_height]); ++_elem)	
		{
			if (_line[_elem] != 0) 
			{
				with (Create(_start + _elem * (BLOCKSIZE - 1) * _scale, oGenerator.ground[_row] - _level * BLOCKSIZE * _scale, oStructureBlock, _row)) //-1
				{
					var _sprite_index = abs(_line[_elem]);
						
					switch (_sprite_index)
					{
						case 4:
							sprite_index = oRoomControl.room_properties[? "BlockEmptySprite"];
							break;
						case 2:
							sprite_index = oRoomControl.room_properties[? "BlockRoundedLeftSprite"];
							break;
						case 3:
							sprite_index = oRoomControl.room_properties[? "BlockRoundedRightSprite"];
							break;
						case 1:
							sprite_index = oRoomControl.room_properties[? "BlockSprite"];
							break;
							
						default:
							Raise("Invalid block sprite index\n");
							break;
					}	
						
					if (_line[_elem] < 0 && (irandom_range(1, 100) > 90 || global.level_started)) 
					{
						global.level_started = false;
						if (!_only_update)	Create(_start + _elem * (BLOCKSIZE - 1) * _scale - 1, oGenerator.ground[_row] - (_level) * BLOCKSIZE * _scale, oChest, _row)	;
					}
						
					if (_level == 1)
					{
						var _collider = GetCollider(x, y + BLOCKSIZE * scale, oGroundBlock, row);
						if (_collider != noone)
						{
							_collider.sprite_index = oRoomControl.room_properties[? "BlockEmptySprite"];
						}
					}
					
					if (_only_update)
					{
						instance_destroy();	
					}
						
				}
			}
		}
	}
}