// Inherit the parent event
event_inherited();


image_angle = 25;

if (x < oCamera.left - CAMERA_BOUNDS)
{
	instance_destroy();	
}


ContactDamageKnockback(damage, max(0, 10 * dir * scale), -15 * scale);