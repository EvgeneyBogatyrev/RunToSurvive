spawn_timer--;
if (spawn_timer <= 0)
{
	
	spawn_timer = spawn_timer_max;
	var _row = irandom_range(0, 2);
	var _robot = choose(oTallRobot, oShootingRobot, oFlyingRobot);
	
	if (_robot == oFlyingRobot)
	{
		if (instance_exists(oFlyingRobot))
		{
			_robot = choose(oTallRobot, oShootingRobot);
		}
		else
		{
			_row = 0;
		}
	}

	with (Create(oCamera.right + CAMERA_BOUNDS, oGenerator.ground[_row], _robot, _row)) 
	{
		if (_robot == oFlyingRobot)
		{
			y -= 250 * GetScale(_row);	
		}
		depth -= 2;
	}
	
}