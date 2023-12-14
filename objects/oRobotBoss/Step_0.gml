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
			//global.score += 100;
			//oRoomControl.gamestate = GameState.NORMAL;
			//GetStandartRoomProperties();
			//instance_destroy(oRobotSpawner);	
			//instance_destroy();
			hp = robot_hp;
			state = RobotBossStates.WAIT_FOR_ROBOT;
		}
		
		break;
	
	case RobotBossStates.WAIT_FOR_ROBOT:
		xspeed = 0.001;
		hp = robot_hp;
		
		if (chosen_robot == undefined && instance_exists(oTallRobot) && oTallRobot.x < oCamera.right - CAMERA_OFFSET/3 && oTallRobot.x > oCamera.left + CAMERA_OFFSET/3)
		{
			chosen_robot = oTallRobot;	
		}
		
		if (chosen_robot != undefined)
		{
			chosen_robot.xspeed = 0;
			x = lerp(x, chosen_robot.x, 0.1);			
			y = lerp(y, chosen_robot.y, 0.1);
			
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
		if (change_speed_timer <= 0)
		{
			change_speed_timer = change_speed_timer_max + random_range(-1, 1) * 60;
			xspeed = choose(0, walkspeed, -walkspeed);
		}
		change_speed_timer--;
		
		image_angle = -30 * sign(xspeed);
		
		if (x < oCamera.left - CAMERA_OFFSET)
		{
			x = oCamera.left - CAMERA_OFFSET + walkspeed * scale;
			xspeed = walkspeed;
			change_speed_timer = change_speed_timer_max;
			row = choose(0, 1, 2);
			scale = GetScale(row);
			depth -= 2;
			y = oGenerator.ground[row];
		}
		
		if (x > oCamera.right + CAMERA_OFFSET)
		{
			x = oCamera.right + CAMERA_OFFSET;
			xspeed = -walkspeed;
			change_speed_timer = change_speed_timer_max;
			row = choose(0, 1, 2);
			scale = GetScale(row);
			depth -= 2;
			y = oGenerator.ground[row];
		}
		break;
	
	default:
		Raise("Wrong Robot boss state\n");
		break;
}


event_inherited();