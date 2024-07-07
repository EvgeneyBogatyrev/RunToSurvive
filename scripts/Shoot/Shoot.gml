///@desc Shoot a bullet of a specific type and ect
///@param projectile An object of the bullet
///@param sprite     A sprite of the bullet
///@param damage     A damage of the bullet
///@param speed      A speed of the bullet
///@param recall     A recall of the bullet
function Shoot(_projectile, _sprite, _damage, _speed, _recall, _direction=undefined, _sound=true) {

	var _xspeed, _yspeed;
	if (_direction == undefined)
	{
		_xspeed = _speed;
		_yspeed = 0;
	}
	else
	{
		_xspeed = lengthdir_x(_speed, _direction);		
		_yspeed = lengthdir_y(_speed, _direction);	
	
	}

	with(Create(x + 30 * host.dir * host.scale, y - 4 * host.scale, _projectile, row))
	{
		row = other.row;
		damage = _damage;
		host = other.host;
		xspeed = _xspeed * host.dir;
		yspeed = _yspeed;
		sprite_index = _sprite;
		scale = other.scale;
		image_xscale = scale;		
		image_yscale = scale;

		depth = other.depth - 1;
		dir = host.dir;
		if (host.object_index == oPlayer) 
		{
			hit_events = GetItemActions(host, "on_hit");
		}
		else
		{
			hit_events = [];	
		}
	
		if (object_index == oAimProjectile)
		{
			target = AimProjectileChooseTarget(row);
		
			remain_speed = host.xspeed;
			absolute_speed = sqrt(xspeed * xspeed + yspeed * yspeed);
			direction = 90 - dir * 90;
			speed *= scale;
			acceleration *= scale;
		
			y += 4 * scale;
			depth += 2;
		}
	
	}
	//image_index = 1;
	recall = _recall;
	host.bullets -= cost;
	if (_sound)
	{
		if(_sprite == sRocket)
		{
			audio_play_sound(soRocketShoot, 1, false);
		}
		else
		{
			audio_play_sound(soShoot, 1, false);
		}
	}


}
