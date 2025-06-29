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

// Worm enemy colllisions
if (instance_exists(oWormEnemy))
{
	//Print("Found worm enemies:", instance_number(oWormEnemy));
	for (var _i = 0; _i < instance_number(oWormEnemy); ++_i)
	{
		var _worm_enemy = instance_find(oWormEnemy, _i);
		if (_worm_enemy.row != row || _worm_enemy.state == UniversalStates.DEAD)
		{
			//Print("Worm enemy on the other row:", _worm_enemy.row);
			continue;	
		}
		var _collision_found = false;
		var _collision_masks = _worm_enemy.collision_detector();
		for (var _mask_index = 0; _mask_index < len(_collision_masks); ++_mask_index)
		{
			var _x = _collision_masks[_mask_index][0];
		    var _y = _collision_masks[_mask_index][1];
		    var spr = _collision_masks[_mask_index][2];
			
			
    
		    var spr_width = sprite_get_width(spr);
		    var spr_height = sprite_get_height(spr);
			
    
		    // Define the collision rectangle for the current entity
		    var rect_left = _x - spr_width / 2;
		    var rect_top = _y - spr_height / 2;
		    var rect_right = _x + spr_width / 2;
		    var rect_bottom = _y + spr_height / 2;
			
    
		    // Check if bullet collides with this entity
		    if (x > rect_left && x < rect_right && y > rect_top && y < rect_bottom)
			{
		        _collision_found = true;
		        break;
		    }
		}
		
		if (_collision_found)
		{
			//Print("Found collision");
			_worm_enemy.hp -= damage;
			if object_is_ancestor(_worm_enemy.object_index, oBossParent)
			{
				_worm_enemy.cum_hp -= damage;	
			}
			display = true;
			_worm_enemy.hit_flash = 3;
		
			hit_an_enemy = true;
	
			if (object_is_ancestor(_worm_enemy.object_index, oHalfBossParent) && _worm_enemy.state != UniversalStates.DEAD)  StartBattle(row, host, _worm_enemy);
			instance_destroy();	
			break;
		}
	}
}


if (CheckCollisions(x, y, oEnemyParent, row))
{
	var _victim = GetCollider(x, y, oEnemyParent, row);
	if (_victim.state != UniversalStates.DEAD && _victim.state != HalfBossStates.INACTIVE && _victim.hp > 0) 
	{
		_victim.on_fire = on_fire;
		hit_an_enemy = true;
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
	oDelver.on_fire = on_fire;
	hit_an_enemy = true;
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





