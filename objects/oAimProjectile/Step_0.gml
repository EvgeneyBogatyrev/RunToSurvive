if (target == noone || !instance_exists(target))
{
	target = AimProjectileChooseTarget(row);	
}

if (target != noone && instance_exists(target) && target.state != UniversalStates.DEAD && (target.row == row || (target.object_index == oDelver && target.state == DelverStates.INSECT)))
{
	var _target_direction = point_direction(x, y, (target.bbox_right + target.bbox_left)/2, target.bbox_top);
	var _rotation_speed = 15;
	var _dumpimg = 0.3;

	direction -= clamp(angle_difference(direction, _target_direction) * _dumpimg, -_rotation_speed, _rotation_speed);
	
	if (y + sprite_width < oGenerator.ground[target.row])  row = target.row;
}

if (abs(x - oCamera.x) > oCamera.view_w_half * 3)  instance_destroy();

if (CheckCollisions(x, y, oEnemyParent, row))
{
	var _victim = GetCollider(x, y, oEnemyParent, row);
	if (_victim.state != UniversalStates.DEAD && _victim.state != HalfBossStates.INACTIVE && _victim.hp > 0) 
	{
		_victim.hp -= damage;
		display = true;
		_victim.hit_flash = 3;
		if object_is_ancestor(_victim.object_index, oBossParent)
		{
			_victim.cum_hp -= damage;	
		}
		if (object_is_ancestor(_victim.object_index, oHalfBossParent) && _victim.state != UniversalStates.DEAD)  StartBattle(row, host, _victim);
		instance_destroy();	
	}
}

if (CheckCollisions(x, y, oSolidParent, row))
{
	instance_destroy();
}

if (place_meeting(x, y, oDelver) && oDelver.state == DelverStates.INSECT)
{
	oDelver.hp -= damage;
	oDelver.hit_flash = 3;
	oDelver.cum_hp -= damage;
	display = true;
	instance_destroy();	
}

var _new_direction = darctan2(speed * dsin(direction), speed * dcos(direction) + remain_speed * scale);
speed = (speed * dcos(direction) + remain_speed * scale) * (speed * dcos(direction) + remain_speed * scale) + (speed * dsin(direction)) * (speed * dsin(direction));
direction = _new_direction;
remain_speed = ApproachTo(remain_speed, 0);

var _norm_dir = (direction + 360) % 360;
if (_norm_dir > 270 || _norm_dir < 90)  dir = 1;
else                                    dir = -1;

image_angle = direction;
speed = min(speed + acceleration, absolute_speed);
image_xscale = abs(scale);
image_yscale = abs(scale);





