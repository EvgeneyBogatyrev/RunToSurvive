// Inherit the parent event
event_inherited();

switch (state)
{
	case ShootingRobotStates.ENTER:
		xspeed = -walkspeed;
		if (x + xspeed < oCamera.right - shooting_threshold * scale)
		{
			wait_before_shoot_timer--;
			if (wait_before_shoot_timer <= 0)
			{
				state = ShootingRobotStates.SHOOT;
				image_angle = -30;
				Create(x + shooting_offset_x * scale, y - shooting_offset_y * scale, oShootingRobotBullet, row);	
			}
		}
		break;
		
	case ShootingRobotStates.SHOOT:
		xspeed = -oRoomControl.roomspeed;
		image_angle += rotation_speed;
		if (image_angle >= 0)
		{
			image_angle = 0;
			state = ShootingRobotStates.BACK;
		}
		else
		{
			image_xscale = -abs(image_xscale);
		}
		break;
		
	case ShootingRobotStates.BACK:
		xspeed = max(walkspeed, -oRoomControl.roomspeed);
		walkspeed += 0.1;
		break;
}


if (x < oCamera.left - CAMERA_BOUNDS || (state == ShootingRobotStates.BACK && x > oCamera.right + CAMERA_OFFSET))
{
	instance_destroy();	
}


ContactDamage(damage, 0);