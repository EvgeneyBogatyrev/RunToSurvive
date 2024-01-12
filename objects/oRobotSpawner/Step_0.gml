var _robot_pool = [];

spawn_timer--;
if (spawn_timer <= 0)
{
	
	spawn_timer = spawn_timer_max;
	
	if (instance_exists(oRobotBoss))
	{
		if (oRobotBoss.state == RobotBossStates.ROBOT)
		{
			var _row = irandom_range(0, 2);
			_robot_pool = [oShootingRobot, oFlyingRobot];
			var _robot = choose(oShootingRobot, oFlyingRobot);
			spawn_timer_max = 1.5 * 60;
		}
		else if (oRobotBoss.state == RobotBossStates.SHIP)
		{
			var _row = 1;
			var _robot = oShootingRobot;
			spawn_timer_max = 3.5 * 60;
		}
		else if (oRobotBoss.state != UniversalStates.DEAD && oRobotBoss.state != UniversalStates.VICTORY)
		{
			var _row = irandom_range(0, 2);
			_robot_pool = [oTallRobot, oShootingRobot, oFlyingRobot];
			var _robot = choose(oTallRobot, oShootingRobot, oFlyingRobot);
			
			if (random(100) < 10)
			{
				_robot = oMissileLauncher;	
			}
		}
		else
		{
			_robot = oMissileLauncher;
			_row = 0;
		}
	}
	else
	{
		exit;
	}
	
	
	if (_robot == oFlyingRobot)
	{
		if (instance_exists(oFlyingRobot))
		{
			_robot = _robot_pool[irandom_range(0, array_length(_robot_pool) - 2)]; // Without oFlyingRobot
		}
		else
		{
			_row = 0;
		}
	}

	with (Create(oCamera.right + CAMERA_BOUNDS * 2, oGenerator.ground[_row], _robot, _row)) 
	{
		if (_robot == oFlyingRobot)
		{
			y -= 210 * GetScale(_row);	
		}
		depth -= 2;
	}
	
}

if (instance_exists(oRobotBoss) && oRobotBoss.state == RobotBossStates.SHIP)
{
	if (last_spawn_launcher[0] == undefined)
	{
		for (var _row = 0; _row < 3; ++_row)
		{
			if (_row == 1)	continue;
			var _launcher = Create(oCamera.right + CAMERA_OFFSET, oGenerator.ground[_row], oMissileLauncher, _row);
			_launcher.depth -= 2;
			last_spawn_launcher[_row] = _launcher;
		}
	}
	if (last_spawn_launcher[2].x < oCamera.right + CAMERA_OFFSET)
	{
		for (var _i = 0; _i < 5; ++_i)
		{
			for (var _row = 0; _row < 3; ++_row)
			{
				if (_row == 1)	continue;
				var _tmp_launcher = Create(last_spawn_launcher[_row].x + spawn_x_diff * GetScale(_row), oGenerator.ground[_row], oMissileLauncher, _row);
				_tmp_launcher.depth -= 2;
				last_spawn_launcher[_row] = _tmp_launcher;
			}
		}
	}
	
}
else
{
	last_spawn_launcher = [undefined, 0, 0];	
}