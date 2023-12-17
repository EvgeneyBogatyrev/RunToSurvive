/// @description

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
		xspeed = 0.001;
		hp = robot_hp;
		cum_hp = robot_hp + ship_hp;
		
		if (chosen_robot == undefined && instance_exists(oTallRobot) && oTallRobot.x < oCamera.right - CAMERA_OFFSET/3 && oTallRobot.x > oCamera.left + CAMERA_OFFSET/3)
		{
			chosen_robot = oTallRobot;	
		}
		
		if (chosen_robot != undefined)
		{
			chosen_robot.xspeed = 0;
			x = lerp(x, chosen_robot.x, 0.05);			
			y = lerp(y, chosen_robot.y, 0.05);
			
			if (CheckCollisions(x, y, chosen_robot, chosen_robot.row))
			{
				sprite_index = chosen_robot.sprite_index;
				x = chosen_robot.x;
				y = chosen_robot.y;
				row = chosen_robot.row;
				scale = chosen_robot.scale;
				depth = chosen_robot.depth;
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
	
		if (change_speed_timer <= 0)
		{
			change_speed_timer = change_speed_timer_max + random_range(-0.5, 0.5) * 60;
			if (xspeed == 0)
			{
				xspeed = choose(walkspeed, -walkspeed);
			}
			else
			{
				xspeed = 0;	
			}
		}
		change_speed_timer--;
		
		image_angle = -30 * sign(xspeed);
		
		if (x < oCamera.left - CAMERA_OFFSET)
		{
			x = oCamera.left - CAMERA_OFFSET + walkspeed * scale;
			xspeed = walkspeed;
			change_speed_timer = change_speed_timer_max * 5;
			row = choose(0, 1, 2);
			scale = GetScale(row);
			depth -= 2;
			y = oGenerator.ground[row];
		}
		
		if (x > oCamera.right + CAMERA_OFFSET)
		{
			x = oCamera.right + CAMERA_OFFSET;
			xspeed = -walkspeed;
			change_speed_timer = change_speed_timer_max * 5;
			row = choose(0, 1, 2);
			scale = GetScale(row);
			depth -= 2;
			y = oGenerator.ground[row];
		}
		
		if (hp <= 0)
		{
			hp = ship_hp;
			state = RobotBossStates.SHIP;
		}	
		
		break;
		
	case RobotBossStates.SHIP:
		image_angle = 0;
		if (sprite_index != sShip)
		{
			hp = ship_hp;
			cum_hp = ship_hp;
			xspeed = 0;
			
			if (x < oCamera.left - CAMERA_OFFSET)
			{
				sprite_index = sShip;
				row = 1;
				scale = GetScale(row);
				depth -= 2;
				y = oGenerator.ground[row];
				saved_roomspeed = oRoomControl.roomspeed;
			}
		}
		else
		{
			while (oRoomControl.roomspeed > saved_roomspeed - roomspeed_acc)
			{
				oRoomControl.roomspeed -= 0.01;	
			}
			x = lerp(x, oCamera.left - 5, 0.1);
			ContactDamage(20, 0);
		}
		
		if (hp <= 0)
		{
			ShakeScreen(10, 60);
			global.score += 100;
			oRoomControl.gamestate = GameState.NORMAL;
			oRoomControl.roomspeed += roomspeed_acc;
			GetStandartRoomProperties();
			instance_destroy(oRobotSpawner);	
			state = UniversalStates.DEAD;
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


event_inherited();