// Inherit the parent event
event_inherited();

switch (state)
{
	case ShootingRobotStates.ENTER:
		xspeed = -walkspeed;
		if (x < oCamera.right - shooting_threshold)
		{
			state = ShootingRobotStates.SHOOT;
			image_angle = -30;
			with (Create(x - shooting_offset_x * scale, y - shooting_offset_y * scale, oMissileHorizontal, row))
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

image_xscale = -abs(image_xscale) * 0.7;
image_yscale = scale * 0.5; // FIX THIS!

if (x < oCamera.left - CAMERA_BOUNDS || (state == ShootingRobotStates.BACK && x > oCamera.right + CAMERA_OFFSET))
{
	instance_destroy();	
}


ContactDamage(5, 0);