event_inherited();

var _target = oRobotBoss;

if (!instance_exists(_target))
{
	instance_destroy();
	exit;
}

angle = point_direction(x, y, _target.x, _target.y);

image_angle = angle;

xspeed = spd * dcos(angle);
yspeed = -spd * dsin(angle);


if (CheckCollisions(x, y, _target, 0))
{
	_target.hp -= damage;	
	_target.cum_hp -= damage;

	instance_destroy();	
}
