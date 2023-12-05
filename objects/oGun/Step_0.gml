if (!instance_exists(host))
{
	instance_destroy();	
	exit;
}
else 
{
	Assert(instance_exists(host), "No host for gun\n");
	row = host.row;
	image_xscale = host.image_xscale;
	image_yscale = host.image_yscale;
	image_alpha  = host.image_alpha;
	
	switch (current_gun)
	{
		case Gun.ROCKET_LAUNCHER:
			depth = host.depth + 1;
			x = host.x - recall * host.dir * host.scale;
			y = host.yprevious - 34 * host.scale;
			break;
	
		default:
			depth = host.depth - 1;
			x = host.xprevious - (4 + recall) * host.dir * host.scale;
			y = host.yprevious - 22 * host.scale;
			break;
	}
}

if (host.bullets < GetCost(current_gun) && last_gun == Gun.DRILL && shotgun_times == 0 && launcher_times == 0) 
{
	last_gun = current_gun;
	current_gun = Gun.DRILL;
	shotgun_times = 0;
	shotgun_timer = 0;
	launcher_times = 0;
	launcher_timer = 0;
	temp_bullets = 0;
}

if (last_gun != Gun.DRILL && host.bullets >= GetCost(last_gun))
{
	current_gun = last_gun;
	last_gun = Gun.DRILL;	
	shoot = false;
	shoot_hold = false;
}

switch(current_gun)
{
	case Gun.STANDART_GUN:
		sprite_index = sStandartGun;
		if (image_index == 0)  image_speed = 0;
		else                   image_speed = 1;
			
		cost = GetCost(current_gun);
		var _damage = 2;
		
		if (shoot && !recall && host.bullets >= cost)
		{
			ShakeScreen(3, 5);
			Shoot(oProjectile, sBulletBeam, _damage, 40, 8);
		}
		shoot = false;
		shoot_hold = false;
		
		break;
		
	case Gun.DRILL:
		sprite_index = sDrill;
		image_speed = 1;
		
		damage = 1;
		
		switch (drill_state)
		{
			
			case DrillStates.FREE:
				if (shoot && recall == 0)
				{
					drill_state = DrillStates.ATTACK;
					recall = -16;
					shoot = false;
					shoot_hold = false;
					ds_list_clear(hit_by_attack);
				}
				break;
				
			case DrillStates.ATTACK:
				
				var _colliding_enemies = ds_list_create();
				var _amount = instance_place_list(x, y, oEnemyParent, _colliding_enemies, true);
				
				for (var i = 0; i < _amount; ++i)
				{
					var _enemy = _colliding_enemies[| i];
					
					if (_enemy.object_index == oDelver)
					{
						if (_enemy.state != DelverStates.INSECT)
						{
							continue;	
						}
					}
					else if (_enemy.row != row)  continue;
					
					if (ds_list_find_index(hit_by_attack, _enemy) == -1 && _enemy.active && _enemy.hp > 0)
					{
						ds_list_add(hit_by_attack, _enemy);	
						_enemy.hp -= damage;
						_enemy.hit_flash = 3;
						
						for (var i = 0; i < array_length(host.onHitEvent); i++)
						{
							host.onHitEvent[i]();
						}

						
						if (object_is_ancestor(_enemy.object_index, oBossParent))
						{
							_enemy.cum_hp -= damage;
						}
						
						if (object_is_ancestor(_enemy.object_index, oHalfBossParent))
						{
							StartBattle(row, host, _enemy.id);
						}
						
						with (Create(x + 80 * scale * host.dir, y - 4 * scale, oDamageNumber, row))
						{
							damage = other.damage;
						}						
					}
				}
				ds_list_destroy(_colliding_enemies);
				
				if (recall == 0)  drill_state = DrillStates.FREE;			
				
				break;
			
			default:
				break;
		}
		
		break;
		
	case Gun.SHOTGUN:
		sprite_index = sShotgun;
		if (image_index == 0)  image_speed = 0;
		else                   image_speed = 1;
			
		cost = GetCost(current_gun);
		var _damage = 2;
		
		if (shoot && !recall && host.bullets >= cost && shotgun_times == 0)
		{
			ShakeScreen(2, 4);
			Shoot(oProjectile, sBulletBeam, _damage, 40, 8);
			shotgun_timer = shotgun_timer_max;
			shotgun_times = 3;
		}
		shoot = false;
		shoot_hold = false;
		
		if (shotgun_times != 0)	shotgun_timer--;
		else					shotgun_timer = 0;
		
		if (shotgun_timer == 0 && shotgun_times > 0)
		{
			shotgun_times--;
			host.bullets += cost;
			Shoot(oProjectile, sBulletBeam, _damage, 40, 8);
			shotgun_timer = shotgun_timer_max;
		}
		
		break;
		
	case Gun.POWERGUN : 
		sprite_index = sPowerGun;
		cost = GetCost(current_gun);
		damage = host.bullets * 2;			
		
		if (shoot_hold && !recall)
		{
			if (temp_bullets == 0)  temp_bullets = 1;
			if (increase)
			{
				temp_bullets += 1;
				if (temp_bullets >= 100)  increase = false;
			}
			//else
			//{
			//	temp_bullets -= 1;
			//	if (temp_bullets < 1)  increase = true;	
			//}
		}
			
		if (!shoot_hold && temp_bullets > 0) 
		{
			increase = true;
			cost = ceil(temp_bullets / 100 * host.bullets); 
			var _damage = cost * 2;
				
			ShakeScreen(3, 5);
			Shoot(oProjectile, sBulletBeam, _damage, 40, 8);
				
			temp_bullets = 0;
		}
		shoot = false;
		shoot_hold = false;
		break;
	
	case Gun.ROCKET_LAUNCHER:
		sprite_index = sRocketLauncher;
		if (image_index == 0)  image_speed = 0;
		else                   image_speed = 1;
			
		cost = GetCost(current_gun);
		var _damage = 1;
		
		if (shoot && !recall && host.bullets >= cost)
		{
			ShakeScreen(7, 5);
			Shoot(oAimProjectile, sRocket, _damage, 20, 8);
			launcher_timer = launcher_timer_max;
			launcher_times = 4;
		}
		shoot = false;
		shoot_hold = false;
		
		if (launcher_times != 0)	launcher_timer--;
		else					    launcher_timer = 0;
		
		if (launcher_timer == 0 && launcher_times > 0)
		{
			launcher_times--;
			host.bullets += cost;
			ShakeScreen(7, 5);
			Shoot(oAimProjectile, sRocket, _damage, 20, 8);
			launcher_timer = launcher_timer_max;
		}
		
		break;
		
	case Gun.LIFESTEAL_GUN:
		sprite_index = sLifestealGun;
		if (image_index == 0)  image_speed = 0;
		else                   image_speed = 1;
			
		cost = GetCost(current_gun);
		var _damage = 3;
		
		if (shoot && !recall && host.bullets >= cost)
		{
			ShakeScreen(3, 5);
			Shoot(oProjectile, sBulletBeam, _damage, 40, 8);
			if (instance_exists(host))
			{
				host.hp += 1;	
			}
			
		}
		shoot = false;
		shoot_hold = false;
		
		break;
		
	default:
		break;
}

if (recall != 0)  recall -= sign(recall);