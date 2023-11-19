///@desc Shoot a bullet of a specific type and ect
///@param projectile An object of the bullet
///@param sprite     A sprite of the bullet
///@param damage     A damage of the bullet
///@param speed      A speed of the bullet
///@param recall     A recall of the bullet
function Shoot(argument0, argument1, argument2, argument3, argument4) {

	var _projectile = argument0;
	var _sprite = argument1;
	var _damage = argument2;
	var _speed = argument3;
	var _recall = argument4;

	with(Create(x + 30 * host.dir * host.scale, y - 4 * host.scale, _projectile, row))
	{
		row = other.row;
		damage = _damage;
		host = other.host;
		xspeed = _speed * host.dir;
		yspeed = random_range(-1, 1);
		sprite_index = _sprite;
		scale = other.scale;
		depth = other.depth - 1;
		dir = host.dir;
	
	
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
	if(_sprite == sRocket)
	{
		audio_play_sound(soRocketShoot, 1, false);
	}
	else
	{
		audio_play_sound(soShoot, 1, false);
	}


}
