/// @description

if (trail == undefined)
{
	trail = part_type_create();
	part_type_shape(trail, pt_shape_smoke);
	part_type_size(trail, 0.5 * GetScale(row), 1 * GetScale(row), 0.05, 0);
	part_type_color1(trail, c_gray);
	part_type_alpha1(trail, 0.1);
	part_type_speed(trail, 5, 7, -0.10, 0);
	part_type_direction(trail, 130, 150, 0, 20);
	part_type_life(trail, 10, 20);	
}

event_inherited();

switch (state)
{
	case UniversalStates.INTRO:
		var _acc = (abs(x - oCamera.center) / oCamera.view_w_half) > 0.5 ? 0.7 : 0.1;
		y = ystart + sin((get_timer() - phase) / 250000) * magnitude;
		x = lerp(x, oCamera.center + sin((get_timer() - phase) / 500000) * magnitude, _acc);
		xspeed = 0.001;
	
		hp = maxhp;
		cum_hp = cum_hp_max;
		
		intro_timer--;
		if (intro_timer == 0)
		{
			state = RobotBossStates.IDLE;	
			Create(x, y, oRobotSpawner, 0);
		}
		break;
	
	case RobotBossStates.IDLE:
		var _acc = (abs(x - oCamera.center) / oCamera.view_w_half) > 0.5 ? 0.7 : 0.1;
		y = ystart + sin((get_timer() - phase) / 250000) * magnitude;
		x = lerp(x, oCamera.center + sin((get_timer() - phase) / 500000) * magnitude, _acc);
		xspeed = 0.001;
		
		if (hp <= 0)
		{
			ShakeScreen(5, 30);
			hp = robot_hp;
			state = RobotBossStates.WAIT_FOR_ROBOT;
		}
		
		break;
	
	case RobotBossStates.WAIT_FOR_ROBOT:
		part_particles_create(global.particle_systems[row], x, y, trail, 1);

		xspeed = 0.001;
		hp = robot_hp;
		cum_hp = robot_hp + ship_hp;
		
		if (chosen_robot == undefined && instance_exists(oTallRobot) && oTallRobot.x < oCamera.right - CAMERA_OFFSET/3 && oTallRobot.x > oCamera.left + CAMERA_OFFSET/3)
		{
			chosen_robot = oTallRobot;	
		}
		
		if (chosen_robot != undefined)
		{
			draw_screen = false;
			chosen_robot.xspeed = 0;
			row = chosen_robot.row;
			scale = chosen_robot.scale;
			depth = chosen_robot.depth;
			x = lerp(x, chosen_robot.x, 0.05);			
			y = lerp(y, chosen_robot.y, 0.05);
			image_angle = lerp(image_angle, -45, 0.05);
			
			if (CheckCollisions(x, y, oGroundBlock, chosen_robot.row))
			{
				ShakeScreen(20, 50);
				// Create ship remains
				with (Create(x, y, oShipRemains, row))
				{
					scale = other.scale;
					depth = other.depth;
					image_angle = other.image_angle;
				}
				
				// Turn into robot
				sprite_index = chosen_robot.sprite_index;
				x = chosen_robot.x;
				y = chosen_robot.y;
				image_angle = chosen_robot.image_angle;
				instance_destroy(chosen_robot);
				state = RobotBossStates.ROBOT;
			}
		}
		else
		{
			var _acc = (abs(x - oCamera.center) / oCamera.view_w_half) > 0.5 ? 0.7 : 0.1;
			y = ystart + sin((get_timer() - phase) / 250000) * magnitude;
			x = lerp(x, oCamera.center + sin((get_timer() - phase) / 500000) * magnitude, _acc);
		}
		
		break;
		
	case RobotBossStates.ROBOT:
	
		ContactDamageKnockback(25, 2);
	
		if (!walk_from_behind)
		{
	
			if (change_speed_timer <= 0)
			{
				change_speed_timer = change_speed_timer_max + random_range(-0.5, 0.5) * 60;
				if (xspeed == 0)
				{
					if (x > oCamera.right + CAMERA_OFFSET)
					{
						xspeed = choose(-walkspeed, -walkspeed, walkspeed);
					}
					else
					{
						xspeed = choose(walkspeed, -walkspeed);
					}
				}
				else
				{
					xspeed = 0;	
				}
			}
			change_speed_timer--;
			
			if (x < oCamera.left - CAMERA_OFFSET)
			{
				xspeed = walkspeed;
				row = choose(0, 1, 2);
				scale = GetScale(row, true);
				depth -= 2;
				y = oGenerator.ground[row];
				walk_from_behind = true;
			}
		}
		else
		{
			if (x > oCamera.x)
			{
				walk_from_behind = false;	
			}
		}
		
		
		if (hp <= 0)
		{
			ShakeScreen(20, 50);
			hp = ship_hp;
			state = RobotBossStates.SHIP;
		}	
		
		var _desired_image_angle = -30 * sign(xspeed);
		image_angle += sign(_desired_image_angle - image_angle);
		
		break;
		
	case RobotBossStates.SHIP:
		image_angle = 0;
		if (sprite_index != sRobotShip)
		{
			part_particles_create(global.particle_systems[row], x, y - 150 * scale, trail, 5);
			hp = ship_hp;
			cum_hp = ship_hp;
			xspeed = 0;
			
			if (x < oCamera.left - CAMERA_OFFSET)
			{
				sprite_index = sRobotShip;
				row = 1;
				scale = GetScale(row);
				depth -= 2;
				y = oGenerator.ground[row];
				saved_roomspeed = oRoomControl.roomspeed;
				image_xscale = abs(image_xscale);
				dir = 1;
				
				// Create magnet
				with (Create(x + magnet_offset_x, y + magnet_offset_y, oRobotMagnet, row))
				{
					host = other.id;
					depth = other.depth - 1;
				}
			}
		}
		else
		{
			while (oRoomControl.roomspeed > saved_roomspeed - roomspeed_acc)
			{
				oRoomControl.roomspeed -= 0.001;	
			}
			xspeed = -oRoomControl.roomspeed;
			x = lerp(x, oCamera.left - 10, 0.15);
			ContactDamageKnockback(20, 25);
		}
		
		if (hp <= 0)
		{
			ShakeScreen(10, 120);
			global.score += 100;
			oRoomControl.gamestate = GameState.NORMAL;
			oRoomControl.roomspeed += roomspeed_acc;
			GetStandartRoomProperties();
			instance_destroy(oRobotSpawner);	
			state = UniversalStates.DEAD;
			
			with (oMissileLauncher)
			{
				if (x > oCamera.right + 10 * scale)
				{
					instance_destroy();	
				}
			}
		}
		break;
		
	case UniversalStates.DEAD:
		xspeed = 0;
		if (AnimationEnd())
		{
			image_speed = 0;	
		}
		if (x < oCamera.left - CAMERA_BOUNDS)
		{
			instance_destroy();	
		}
		break;
	
	default:
		Raise("Wrong Robot boss state\n");
		break;
}


