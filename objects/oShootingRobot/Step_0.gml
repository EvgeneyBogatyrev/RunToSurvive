// Inherit the parent event
event_inherited();

switch (state)
{
	case ShootingRobotStates.ENTER:
		xspeed = -walkspeed;
		if (x + xspeed < oCamera.right - shooting_threshold * scale)
		{
			state = ShootingRobotStates.SHOOT;
			image_angle = -30;
			with (Create(x + shooting_offset_x * scale, y - shooting_offset_y * scale, oShootingRobotBullet, row))
			{
					
			}
		}
		break;
		
	case ShootingRobotStates.SHOOT:
		xspeed = 0;
		image_angle += rotation_speed;
		if (image_angle >= 0)
		{
			image_angle = 0;
			state = ShootingRobotStates.BACK;
		}	
		break;
		
	case ShootingRobotStates.BACK:
		xspeed = walkspeed;
		walkspeed += 0.1;
		break;
}


if (x < oCamera.left - CAMERA_BOUNDS || (state == ShootingRobotStates.BACK && x > oCamera.right + CAMERA_OFFSET))
{
	instance_destroy();	
}


ContactDamage(5, 0);