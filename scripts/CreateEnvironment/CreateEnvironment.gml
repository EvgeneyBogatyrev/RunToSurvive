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
			for (var _height = array_length_1d(_shape) - 1; _height >= 0; --_height)
			{
				var _line = _shape[_height];
				var _level = array_length_1d(_shape) - _height;
				for (var _elem = 0; _elem < array_length_1d(_shape[_height]); ++_elem)	
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
						
							if (_line[_elem] < 0 && (irandom_range(1, 100) > 85 || global.level_started)) 
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
					}
				}
			}
			break;
		
		case Obstacles.CHARGE_STATION :
		
			var _object = oChargeStation;
			with (oPlayer)
			{
				Print(revival_number,", " ,instance_exists(oCloningStation));
				
				randomize();
				if (revival_number > 0 && !instance_exists(oCloningStation) && irandom_range(0, 100) > 30)  _object = oCloningStation;	
			}
		
			Create(_start + oCamera.view_w_half/2, oGenerator.ground[_row], _object, _row);
			break;
		
		default :
			break;
	}



}
