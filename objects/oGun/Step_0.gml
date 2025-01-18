if (!instance_exists(host))
{
	instance_destroy();	
	exit;
}
else 
{
	Assert(instance_exists(host), "No host for gun\n");
	
	row = host.row;
	dir = host.dir;
	image_xscale = host.image_xscale;
	image_yscale = host.image_yscale;
	image_alpha  = host.image_alpha;
	image_angle = 0;
	switch (current_gun)
	{
		case Gun.ROCKET_LAUNCHER:
			depth = host.depth + 1;
			x = host.x - recoil * host.dir * host.scale;
			y = host.yprevious - 34 * host.scale;
			break;
	
		default:
			depth = host.depth - 1;
			x = host.xprevious - (4 + recoil) * host.dir * host.scale;
			y = host.yprevious - 22 * host.scale;
			break;
	}
}

var _held_gun = GetGunStateFromID(host.pocket[0]);

if (host.bullets < GetCost(current_gun) && secondary == false && shotgun_times == 0 && launcher_times == 0) 
{
	secondary = true;
	current_gun = host.character.secondary_weapon;
	shotgun_times = 0;
	shotgun_timer = 0;
	launcher_times = 0;
	launcher_timer = 0;
	temp_bullets = 0;
	charge_timer = 0;
}

if (secondary && host.bullets >= GetCost(_held_gun))
{
	current_gun = _held_gun;
	secondary = false;
	shoot = false;
	shoot_hold = false;
}

if (current_gun != Gun.ELECTRIC_GUN)
{
	if (electricity_obj != undefined)
	{
		instance_destroy(electricity_obj);
	}
	electricity_obj	= undefined;	
}

switch(current_gun)
{
	case Gun.STANDART_GUN:
		sprite_index = sStandartGun;
		if (image_index == 0)  image_speed = 0;
		else                   image_speed = 1;
			
		cost = GetCost(current_gun);
		var _damage = 2;
		
		if (shoot && !recoil && host.bullets >= cost)
		{
			ShakeScreen(3, 5);
			var _speed = 40;
			if (instance_exists(host) && host.object_index == oGunMan)
			{
				_speed = 20;	
			}
			Shoot(oProjectile, sBulletBeam, _damage + host.damageBoost, _speed, 8);
		}
		shoot = false;
		shoot_hold = false;
		
		break;
	
	case Gun.STEAMPUNK_HAMMER:
		sprite_index = sSteamPunkHammer;
		image_speed = 0;
		image_index = 0;
		image_xscale *= 1.3;
		image_yscale *= 1.3;
	
		damage = 4 + host.drill_damage;
		
		switch (hammer_state)
		{
			case MeleeStates.IDLE:
				depth = host.depth + swing_dir;
				if (swing_dir > 0)
				{
					image_angle = 35 * host.dir;
				}
				else
				{
					image_angle = 125 * host.dir;
				}
				if (shoot && (recoil == 0))
				{
					hammer_state = MeleeStates.ATTACK;
					shoot = false;
					shoot_hold = false;
					
					ds_list_clear(hit_by_attack);
					
					
					dir_lock = host.dir;
					recoil = swing_time;
				}
			break;
				
			case MeleeStates.ATTACK:
				var _swing_prog = 1 - (recoil / swing_time);
				var _swinganim = animcurve_get(HammerSwings);
				x = host.xprevious - 4 * host.scale + animcurve_channel_evaluate(_swinganim.channels[2], _swing_prog) * dir_lock;
				depth = host.depth + swing_dir * ((_swing_prog < 0.5) * 2 - 1);
				if (swing_dir > 0)
				{
					
					image_angle = animcurve_channel_evaluate(_swinganim.channels[0], _swing_prog) * dir_lock;
				}
				else
				{
					
					image_angle = animcurve_channel_evaluate(_swinganim.channels[1], _swing_prog) * dir_lock;
				}
				
				if (_swing_prog > 0.25 && _swing_prog < 0.8)
				{
					
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
								
								_worm_enemy.hit_flash = 3;
	
								if (object_is_ancestor(_worm_enemy.object_index, oHalfBossParent) && _worm_enemy.state != UniversalStates.DEAD)  StartBattle(row, host, _worm_enemy);
								
								with (Create(x + 80 * scale * host.dir, y - 4 * scale, oDamageNumber, row))
								{
									damage = other.damage;
								}
							}
						}
					}

					//
					
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
						
							/*
							hit_events = [];
							for (var _i = 0; _i < ds_list_size(host.inventory); _i++)
							{
								var _item = ds_list_find_value(host.inventory, _i);
								var hit_event = struct_exists(_item, "on_hit") ? struct_get(_item, "on_hit") : undefined;
								if (hit_event != undefined)
								{
									hit_event(id, 82 * sign(image_xscale));
								}
							}
							*/

						
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
				}
				
				if (recoil <= 0)
				{
					hammer_state = MeleeStates.IDLE;
					swing_dir *= -1;
				}
			break;
		}
		
		break;
	
	case Gun.DRILL:
		sprite_index = sDrill;
		image_speed = 1;
		
		damage = host.drill_damage;
		
		switch (drill_state)
		{
			
			case MeleeStates.IDLE:
				if (shoot && recoil == 0)
				{
					drill_state = MeleeStates.ATTACK;
					recoil = -16;
					shoot = false;
					shoot_hold = false;
					ds_list_clear(hit_by_attack);
				}
				break;
				
			case MeleeStates.ATTACK:
				
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
						
						/*
						hit_events = [];
						for (var _i = 0; _i < ds_list_size(host.inventory); _i++)
						{
							var _item = ds_list_find_value(host.inventory, _i);
							var hit_event = struct_exists(_item, "on_hit") ? struct_get(_item, "on_hit") : undefined;
							if (hit_event != undefined)
							{
								hit_event(id, 82 * sign(image_xscale));
							}
						}
						*/

						
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
				
				if (recoil == 0)  drill_state = MeleeStates.IDLE;			
				
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
		
		var _speed = 40;
		if (instance_exists(host) && host.object_index == oGunMan)
		{
			_speed = 20;	
		}
		
		if (shoot && !recoil && host.bullets >= cost && shotgun_times == 0)
		{
			ShakeScreen(2, 4);
			Shoot(oProjectile, sBulletBeam, _damage + host.damageBoost, _speed, 8);
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
			Shoot(oProjectile, sBulletBeam, _damage + host.damageBoost, _speed, 8);
			shotgun_timer = shotgun_timer_max;
		}
		
		break;
		
	case Gun.POWERGUN : 
		sprite_index = sPowerGun;
		cost = GetCost(current_gun);
		damage = host.bullets * 2;			
		
		if (shoot_hold && !recoil)
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
			Shoot(oProjectile, sBulletBeam, _damage + host.damageBoost, 40, 8);
				
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
		
		if (shoot && !recoil && host.bullets >= cost)
		{
			ShakeScreen(7, 5);
			Shoot(oAimProjectile, sRocket, _damage + host.damageBoost, 20, 8);
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
			Shoot(oAimProjectile, sRocket, _damage + host.damageBoost, 20, 8);
			launcher_timer = launcher_timer_max;
		}
		
		break;
		
	case Gun.LIFESTEAL_GUN:
		sprite_index = sLifestealGun;
		if (image_index == 0)  image_speed = 0;
		else                   image_speed = 1;
			
		cost = GetCost(current_gun);
		var _damage = 3;
		
		if (shoot && !recoil && host.bullets >= cost)
		{
			ShakeScreen(3, 5);
			Shoot(oProjectile, sBulletBeam, _damage + host.damageBoost, 40, 8);
			if (instance_exists(host))
			{
				var _heal_amount = 1;
				
				if (host.object_index == oPlayer && host.pocket[1] == DOUBLEHEART_INUMBER)
				{
					_heal_amount *= 1.5;	
				}
				host.hp += _heal_amount;
				if object_is_ancestor(host.object_index, oBossParent)
				{
					host.cum_hp += _heal_amount;	
				}
			}
			
		}
		shoot = false;
		shoot_hold = false;
		
		break;
		
	case Gun.REAL_SHOTGUN:
		sprite_index = GetGunSprite(Gun.REAL_SHOTGUN);
		
		cost = GetCost(current_gun);
		var _damage = 1;
		
		if (shoot && !recoil && host.bullets >= cost)
		{
			ShakeScreen(3, 5);
			var _offset = 30;
			for (var _angle = 45; _angle >= -45; _angle -= _offset)
			{
				Shoot(oProjectile, sPellet, _damage + host.damageBoost, 30, 8, _angle, _angle == 45 ? true: false);
			}
			var _spd = 5;
			with (Create(x, y, oShotgunShell, row))
			{
				depth = other.depth;
				rotation_speed = irandom_range(-5, 5);
				var _shell_angle = irandom_range(160, 210);
				xspeed = lengthdir_x(_spd, _shell_angle) * other.host.dir;					
				yspeed = lengthdir_y(_spd, _shell_angle);
			}
		}
		shoot = false;
		shoot_hold = false;
		
		break;
		
	case Gun.ELECTRIC_GUN:
		sprite_index = GetGunSprite(Gun.ELECTRIC_GUN);
		if (shoot_hold)
		{
			host.bullets -= 0.025;	
			if (electricity_obj == undefined)
			{
				electricity_obj = Create(x, y, oElectricity, row);
			}
			electricity_obj.x = x + 30 * host.dir * host.scale;
			electricity_obj.y = y - 4 * host.scale;
			electricity_obj.row = row;
			electricity_obj.scale = scale;	
			electricity_obj.dir = dir;
			electricity_obj.depth = depth - 1;
			electricity_obj.image_xscale = image_xscale;
			electricity_obj.image_yscale = image_yscale;
			electricity_obj.host = host;
		}
		else
		{
			if (electricity_obj != undefined)
			{
				instance_destroy(electricity_obj);
			}
			electricity_obj	= undefined;
		}
		
		shoot_hold = false;
		break;
		
	default:
		break;
		
	case Gun.CHARGING_GUN:
		sprite_index = sChargingGun;
			
		cost = GetCost(current_gun);
		if (shoot_hold && !recoil)
		{
			if (charge_timer == 0)  charge_timer = 1;
			if (increase)
			{
				charge_timer += 1;
				if (charge_timer >= 20)  increase = false;
			}
			//else
			//{
			//	temp_bullets -= 1;
			//	if (temp_bullets < 1)  increase = true;	
			//}
		}
			
		if (!shoot_hold && charge_timer < 20 && charge_timer != 0) 
		{
			increase = true; 
			var _damage = 2;
				
			ShakeScreen(3, 5);
			Shoot(oProjectile, sBulletBeam, _damage + host.damageBoost, 40, 8);
				
			charge_timer = 0;
		}
		if (!shoot_hold && charge_timer >= 20) 
		{
			increase = true; 
			var _damage = 5;
				
			ShakeScreen(3, 5);
			Shoot(oProjectile, sBulletBeam, _damage + host.damageBoost, 40, 8);
				
			charge_timer = 0;
		}
		shoot = false;
		shoot_hold = false;
		break;
}

if (recoil != 0)  recoil -= sign(recoil);


if (host.bullets < GetCost(current_gun) && host.pocket[1] == INFINITYGUN_INUMBER)
{
	var _guns = GetAllGuns();			
	var _gun_images = GetAllGunsImages();

	var _index = irandom_range(0, array_length(_guns) - 1);
	var _new_gun = _guns[_index];			
	var _new_gun_image = _gun_images[_index];

	host.gun.current_gun = _new_gun;
	host.pocket[0] = _new_gun_image;
	host.bullets = host.maxbullets / 2;
	host.shoot_hold = false;	
	host.shoot = false;
	
	host.hp -= 20;
}