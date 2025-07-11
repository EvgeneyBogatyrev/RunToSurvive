///@desc Shoot a bullet of a specific type and ect
///@param projectile An object of the bullet
///@param sprite     A sprite of the bullet
///@param damage     A damage of the bullet
///@param speed      A speed of the bullet
///@param recoil     A recoil of the bullet

function Shoot(_projectile, _sprite, _damage, _speed, _recoil, _direction=undefined, _sound=true, _lifespan=999999, _main_shoot = true) {


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

	var _bullet = Create(x + 30 * host.dir * host.scale, y - 4 * host.scale, _projectile, row);
	with(_bullet)
	{
		row = other.row;
		damage = _damage;
		host = other.host;
		xspeed = _xspeed * host.dir;
		yspeed = _yspeed;
		sprite_index = _sprite;
		scale = host.scale;
		image_xscale = scale;		
		image_yscale = scale;
		
		lifespan = _lifespan;
		
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
	recoil = _recoil;
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

//Rocket_Drone
	if (host.object_index == oPlayer && host.pocket[1] == DRONE_INUMBER && _main_shoot)
	{
		_main_shoot = false;
		var _rnd_val = random_range(0, 100);
		if (_rnd_val < 33)
		{	
			Shoot(oAimProjectile, sRocket, 1 + host.damageBoost, 20, 8, _direction, true, 99999, false);
		}
	}
//Burn
	if (host.object_index == oPlayer && host.pocket[1] == BURN_INUMBER)
	{
		_bullet.on_fire = 180;
	}
}
