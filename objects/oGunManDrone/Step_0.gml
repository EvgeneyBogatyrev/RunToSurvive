event_inherited();

// Floating in space
y += float_magnitude * sin(get_timer() / 300000);

// Destroy out of screen
if (x < oCamera.left - CAMERA_OFFSET)
{
	instance_destroy();	
}