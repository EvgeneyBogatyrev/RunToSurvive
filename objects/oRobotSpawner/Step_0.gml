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
			spawn_timer_max = 1.2 * 60;
		}
		else if (oRobotBoss.state == RobotBossStates.SHIP)
		{
			var _row = 1;
			var _robot = oShootingRobot;
			spawn_timer_max = 3 * 60;
		}
		else if (oRobotBoss.state != UniversalStates.DEAD)
		{
			var _row = irandom_range(0, 2);
			_robot_pool = [oTallRobot, oShootingRobot, oFlyingRobot];
			var _robot = choose(oTallRobot, oShootingRobot, oFlyingRobot);
			
			if (random(100) < 10)
			{
				_robot = oMissileLauncher;	
			}
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
	spawn_launcher_timer--;
	if (spawn_launcher_timer <= 0)
	{
		spawn_launcher_timer = spawn_launcher_timer_max;
		with (Create(oCamera.right + CAMERA_BOUNDS, oGenerator.ground[0], oMissileLauncher, 0)) 
		{
			depth -= 2;
		}
		
		with (Create(oCamera.right + CAMERA_BOUNDS, oGenerator.ground[2], oMissileLauncher, 2)) 
		{
			depth -= 2;
		}
	}
}