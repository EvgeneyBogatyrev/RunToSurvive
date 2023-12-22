event_inherited();

var _target = oRobotBoss;

if (!instance_exists(_target))
{
	instance_destroy();
	exit;
}

var desired_angle = point_direction(x, y, _target.x, _target.y);

var _rotation_speed = 15;
var _dumpimg = 0.3;

angle -= clamp(angle_difference(angle, desired_angle) * _dumpimg, -_rotation_speed, _rotation_speed);


image_angle = angle;

xspeed = spd * dcos(angle);
yspeed = -spd * dsin(angle);


if (CheckCollisions(x, y, _target, 0))
{
	_target.hp -= damage;	
	_target.cum_hp -= damage;

	instance_destroy();	
}
