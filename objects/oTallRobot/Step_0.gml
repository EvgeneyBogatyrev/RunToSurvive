// Inherit the parent event
event_inherited();


image_angle = 25;

if (x < oCamera.left - CAMERA_BOUNDS)
{
	instance_destroy();	
}


ContactDamageKnockback(10, 2);