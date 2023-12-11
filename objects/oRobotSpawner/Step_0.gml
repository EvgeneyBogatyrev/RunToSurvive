spawn_timer--;
if (spawn_timer <= 0)
{
	
	spawn_timer = spawn_timer_max;
	var _row = irandom_range(0, 2);

	with (Create(oCamera.right + CAMERA_BOUNDS, oGenerator.ground[_row], oTallRobot, _row)) {}
	
}