//Initialize cursor position
cursor_position = 0;

//Set default buttons
dbutton[0] = "SINGLEPLAYER";
dbutton[1] = "MULTIPLAYER";
dbutton[2] = "ITEMS";
dbutton[3] = "BACK";

_length = array_length(dbutton);

//Set gamepad
allowed_array = [];
allowed_hor_array = [];

for (var i = 0; i < 5; ++i)
{
	choices[i] = i;	
	lock[i] = false;
	allowed_array[i] = true;
	allowed_hor_array[i] = true;
}

items_mode = false;
items_cursor = 0;
items_last_cursor = -1;
items_columns = 6;
items_catalog = [];

items_preview_left = 0;
items_preview_right = 0;
items_preview_top = 0;
items_preview_bottom = 0;
items_preview_ground = 0;

preview_x = 0;
preview_y = 0;
preview_xspeed = 0;
preview_yspeed = 0;
preview_face = 1;
preview_grounded = true;
preview_double_jump = true;
preview_projectiles = [];
preview_shot_timer = 0;
preview_beam_timer = 0;
preview_melee_timer = 0;
preview_heal_timer = 0;
preview_charge = 0;
preview_was_shooting = false;
preview_recoil = 0;
preview_hp = 100;
preview_maxhp = 100;
preview_bullets = 20;
preview_maxbullets = 20;
preview_restore_pool = 0;
preview_restore_timer = 0;
preview_shield_ready = true;
preview_target_hp = 44;
preview_target_maxhp = 44;
preview_target_hit_flash = 0;
preview_target_respawn = 0;
preview_target_burn = 0;
preview_station_timer = 0;
preview_heart_timer = 0;
preview_battery_timer = 0;
preview_hazard_timer = 0;
preview_damage_numbers = [];

function ItemsMenuRefreshPreviewBounds()
{
	items_preview_left = max(960, room_width - 820);
	items_preview_right = room_width - 80;
	items_preview_top = 155;
	items_preview_bottom = room_height - 120;
	items_preview_ground = items_preview_bottom - 90;
}

function ItemsMenuAddCatalogEntry(_item_name, _description, _sprite, _image, _item_id, _category, _gun_state, _profile_index)
{
	array_push(items_catalog, {
		item_name : _item_name,
		description : _description,
		sprite : _sprite,
		image : _image,
		item_id : _item_id,
		category : _category,
		gun_state : _gun_state,
		profile_index : _profile_index
	});
}

function ItemsMenuBuildCatalog()
{
	items_catalog = [];
	
	for (var _i = 0; _i < array_length(item_description); ++_i)
	{
		var _item = item_description[_i];
		var _gun_state = undefined;
		var _category = "Powerup";
		
		if (struct_exists(_item, "gun_state"))
		{
			_gun_state = _item.gun_state;
			_category = "Weapon";
		}
		else if (_item.item_id == BATTERY_INUMBER || _item.item_id == HEARTH_INUMBER || _item.item_id == ESSENCE_INUMBER)
		{
			_category = "Pickup";
		}
		
		ItemsMenuAddCatalogEntry(_item.item_name, _item.description, sItems, _item.item_id, _item.item_id, _category, _gun_state, -1);
	}
	
	for (var _i = 0; _i < array_length(passive_items_profiles); ++_i)
	{
		var _profile = passive_items_profiles[_i];
		ItemsMenuAddCatalogEntry(_profile.name, _profile.description, sPassiveItems, _profile.icon_index, -1000 - _i, "Boss loot", undefined, _i);
	}
}

function ItemsMenuCurrent()
{
	var _count = array_length(items_catalog);
	if (_count <= 0) return undefined;
	
	items_cursor = clamp(items_cursor, 0, _count - 1);
	return items_catalog[items_cursor];
}

function ItemsMenuHasGun(_entry)
{
	return (_entry != undefined && _entry.gun_state != undefined);
}

function ItemsMenuGunSprite(_entry)
{
	if (!ItemsMenuHasGun(_entry)) return -1;
	if (_entry.gun_state == Gun.SHIELD_MELEE) return sShield;
	
	var _sprite = GetGunSprite(_entry.gun_state);
	if (_sprite == undefined) return -1;
	return _sprite;
}

function ItemsMenuGunSpriteFromState(_gun_state)
{
	if (_gun_state == Gun.SHIELD_MELEE) return sShield;
	
	var _sprite = GetGunSprite(_gun_state);
	if (_sprite == undefined) return -1;
	return _sprite;
}

function ItemsMenuPreviewLoadout(_entry)
{
	var _gun_state = Gun.STANDART_GUN;
	var _gun_item = STDGUN_INUMBER;
	var _powerup = 0;
	var _profile_index = -1;
	
	if (_entry != undefined)
	{
		if (ItemsMenuHasGun(_entry))
		{
			_gun_state = _entry.gun_state;
			_gun_item = _entry.item_id;
		}
		else if (_entry.profile_index >= 0)
		{
			_profile_index = _entry.profile_index;
			
			if (_entry.item_name == "Elite weapon")
			{
				_gun_state = Gun.POWERGUN;
				_gun_item = POWERGUN_INUMBER;
			}
			else if (_entry.item_name == "Damage boost" || _entry.item_name == "Tumble")
			{
				_gun_state = Gun.DRILL;
				_gun_item = DRILL_INUMBER;
			}
		}
		else
		{
			_powerup = _entry.item_id;
			
			if (_entry.item_id == CRUSH_INUMBER || _entry.item_id == HAMMER_TIME_INUMBER)
			{
				_gun_state = Gun.DRILL;
				_gun_item = DRILL_INUMBER;
			}
		}
	}
	
	return {
		gun_state : _gun_state,
		gun_item : _gun_item,
		powerup : _powerup,
		profile_index : _profile_index
	};
}

function ItemsMenuSelectedPowerup(_entry)
{
	if (_entry == undefined || ItemsMenuHasGun(_entry) || _entry.profile_index >= 0) return 0;
	return _entry.item_id;
}

function ItemsMenuResetPreview()
{
	ItemsMenuRefreshPreviewBounds();
	
	preview_x = (items_preview_left + items_preview_right) / 2;
	preview_y = items_preview_ground;
	preview_xspeed = 0;
	preview_yspeed = 0;
	preview_face = 1;
	preview_grounded = true;
	preview_double_jump = true;
	preview_projectiles = [];
	preview_shot_timer = 0;
	preview_beam_timer = 0;
	preview_melee_timer = 0;
	preview_heal_timer = 0;
	preview_charge = 0;
	preview_was_shooting = false;
	preview_recoil = 0;
	preview_hp = 78;
	preview_maxhp = 100;
	preview_bullets = 16;
	preview_maxbullets = 20;
	preview_restore_pool = 0;
	preview_restore_timer = 0;
	preview_shield_ready = true;
	preview_target_hp = 44;
	preview_target_maxhp = 44;
	preview_target_hit_flash = 0;
	preview_target_respawn = 0;
	preview_target_burn = 0;
	preview_station_timer = 0;
	preview_heart_timer = 0;
	preview_battery_timer = 0;
	preview_hazard_timer = 0;
	preview_damage_numbers = [];
}

function ItemsMenuMoveCursor(_left, _right, _up, _down)
{
	var _count = array_length(items_catalog);
	if (_count <= 0) return false;
	
	var _old_cursor = items_cursor;
	
	if (_left)       items_cursor = max(0, items_cursor - 1);
	else if (_right) items_cursor = min(_count - 1, items_cursor + 1);
	else if (_up)    items_cursor = max(0, items_cursor - items_columns);
	else if (_down)  items_cursor = min(_count - 1, items_cursor + items_columns);
	
	return _old_cursor != items_cursor;
}

function ItemsMenuTargetX()
{
	return items_preview_right - 150;
}

function ItemsMenuTargetY()
{
	return items_preview_ground - 34;
}

function ItemsMenuStationX()
{
	return items_preview_left + 116;
}

function ItemsMenuHeartX()
{
	return items_preview_left + 226;
}

function ItemsMenuBatteryX()
{
	return items_preview_left + 312;
}

function ItemsMenuHazardX()
{
	return items_preview_right - 250;
}

function ItemsMenuAddDamageNumber(_x, _y, _text, _colour)
{
	array_push(preview_damage_numbers, {
		x : _x,
		y : _y,
		text : string(_text),
		colour : _colour,
		alpha : 1
	});
}

function ItemsMenuDamagePlayer(_damage)
{
	var _entry = ItemsMenuCurrent();
	var _powerup = ItemsMenuSelectedPowerup(_entry);
	
	if (_powerup == FORCEFIELD_INUMBER && preview_shield_ready)
	{
		preview_shield_ready = false;
		ItemsMenuAddDamageNumber(preview_x, preview_y - 112, 0, c_aqua);
		audio_play_sound(soConfirm, 1, false);
		return;
	}
	
	preview_hp = max(1, preview_hp - _damage);
	ItemsMenuAddDamageNumber(preview_x, preview_y - 112, _damage, make_color_rgb(255, 96, 96));
	
	if (_entry != undefined && _entry.item_name == "FARBAS")
	{
		preview_restore_pool += _damage;
	}
}

function ItemsMenuDamageTarget(_damage, _kind)
{
	if (preview_target_respawn > 0) return;
	
	var _entry = ItemsMenuCurrent();
	var _loadout = ItemsMenuPreviewLoadout(_entry);
	var _final_damage = _damage;
	
	if (_entry != undefined && _entry.item_name == "Dealmaker") _final_damage += 1;
	if (_entry != undefined && _entry.item_name == "Damage boost" && (_loadout.gun_state == Gun.DRILL || _loadout.gun_state == Gun.SHIELD_MELEE)) _final_damage += 1;
	if (_loadout.powerup == HAMMER_TIME_INUMBER && (_loadout.gun_state == Gun.DRILL || _loadout.gun_state == Gun.SHIELD_MELEE)) _final_damage += 1;
	if (_loadout.powerup == CRUSH_INUMBER && (_loadout.gun_state == Gun.DRILL || _loadout.gun_state == Gun.SHIELD_MELEE)) _final_damage += irandom_range(1, 3);
	
	preview_target_hp -= _final_damage;
	preview_target_hit_flash = 6;
	ItemsMenuAddDamageNumber(ItemsMenuTargetX(), ItemsMenuTargetY() - 58, _final_damage, c_white);
	
	if (_loadout.powerup == BURN_INUMBER || _kind == "flame")
	{
		preview_target_burn = 150;
	}
	
	if (_loadout.gun_state == Gun.LIFESTEAL_GUN)
	{
		preview_hp = min(preview_maxhp, preview_hp + (_loadout.powerup == DOUBLEHEART_INUMBER ? 1.5 : 1));
		preview_heal_timer = 18;
	}
	
	if (_entry != undefined && _entry.item_name == "Lightning Strike" && irandom_range(0, 100) < 30)
	{
		preview_target_hp -= 3;
		ItemsMenuAddDamageNumber(ItemsMenuTargetX() + 16, ItemsMenuTargetY() - 88, 3, c_aqua);
		preview_beam_timer = 8;
	}
	
	if (preview_target_hp <= 0)
	{
		preview_target_hp = 0;
		preview_target_respawn = 70;
		
		if (_loadout.powerup == REFRACTOR_INUMBER)
		{
			preview_hp = min(preview_maxhp, preview_hp + 5);
			preview_bullets = min(preview_maxbullets, preview_bullets + 3);
			preview_heal_timer = 24;
		}
	}
}

function ItemsMenuSpendEnergy(_gun_state, _cost)
{
	var _entry = ItemsMenuCurrent();
	var _powerup = ItemsMenuSelectedPowerup(_entry);
	
	if (preview_bullets >= _cost)
	{
		preview_bullets -= _cost;
		return true;
	}
	
	if (_powerup == INFINITYGUN_INUMBER)
	{
		preview_bullets = preview_maxbullets / 2;
		ItemsMenuDamagePlayer(20);
		return true;
	}
	
	return false;
}

function ItemsMenuAddProjectile(_x, _y, _xs, _ys, _life, _colour, _radius, _kind, _sprite = undefined, _damage = 1)
{
	if (_sprite == undefined) _sprite = sBulletBeam;
	
	array_push(preview_projectiles, {
		x : _x,
		y : _y,
		xs : _xs,
		ys : _ys,
		life : _life,
		max_life : _life,
		colour : _colour,
		radius : _radius,
		kind : _kind,
		sprite : _sprite,
		damage : _damage
	});
}

function ItemsMenuFire(_entry, _charged)
{
	if (_entry == undefined) return;
	
	var _x = preview_x + preview_face * 44;
	var _y = preview_y - 54;
	var _loadout = ItemsMenuPreviewLoadout(_entry);
	var _gun_state = _loadout.gun_state;
	var _cost = GetCost(_gun_state);
	
	if (_charged)
	{
		_cost = (_gun_state == Gun.POWERGUN) ? max(1, ceil(preview_charge / 100 * preview_bullets)) : _cost;
	}
	
	if (!ItemsMenuSpendEnergy(_gun_state, _cost)) return;
	
	preview_recoil = 8;
	audio_play_sound(_gun_state == Gun.ROCKET_LAUNCHER ? soRocketShoot : soShoot, 1, false);
	
	switch (_gun_state)
	{
		case Gun.DRILL:
		case Gun.SHIELD_MELEE:
			preview_melee_timer = 10;
			if (abs(preview_x - ItemsMenuTargetX()) < 120)
			{
				ItemsMenuDamageTarget(1, "melee");
			}
			break;
		
		case Gun.SHOTGUN:
			ItemsMenuAddProjectile(_x, _y, preview_face * 13, 0, 38, make_color_rgb(234, 255, 255), 4, "bullet", sBulletBeam, 2);
			preview_shot_timer = 5;
			break;
		
		case Gun.REAL_SHOTGUN:
			ItemsMenuAddProjectile(_x, _y - 8, preview_face * 10, -4, 38, make_color_rgb(234, 255, 255), 4, "pellet", sPellet, 1);
			ItemsMenuAddProjectile(_x, _y - 2, preview_face * 12, -1, 38, make_color_rgb(234, 255, 255), 4, "pellet", sPellet, 1);
			ItemsMenuAddProjectile(_x, _y + 4, preview_face * 12,  1, 38, make_color_rgb(234, 255, 255), 4, "pellet", sPellet, 1);
			ItemsMenuAddProjectile(_x, _y + 10, preview_face * 10, 4, 38, make_color_rgb(234, 255, 255), 4, "pellet", sPellet, 1);
			break;
		
		case Gun.POWERGUN:
		case Gun.CHARGING_GUN:
			var _radius = _charged ? 7 + preview_charge / 7 : 6;
			var _speed = _charged ? 12 : 10;
			var _damage = (_gun_state == Gun.CHARGING_GUN && preview_charge >= 20) ? 7 : max(3, ceil(_radius));
			ItemsMenuAddProjectile(_x, _y, preview_face * _speed, 0, 52, make_color_rgb(255, 84, 223), _radius, "charged", sBulletBeam, _damage);
			break;
		
		case Gun.ROCKET_LAUNCHER:
			for (var _i = 0; _i < 3; ++_i)
			{
				ItemsMenuAddProjectile(_x, _y - 8 + _i * 8, preview_face * (7 + _i), -1 + _i, 62, make_color_rgb(255, 96, 72), 7, "rocket", sRocket, 1);
			}
			break;
		
		case Gun.LIFESTEAL_GUN:
			preview_heal_timer = 18;
			ItemsMenuAddProjectile(_x, _y, preview_face * 10, 0, 50, make_color_rgb(84, 255, 128), 6, "heal", sBulletBeam, 3);
			break;
		
		case Gun.ELECTRIC_GUN:
			preview_beam_timer = 6;
			if (preview_face == sign(ItemsMenuTargetX() - preview_x))
			{
				ItemsMenuDamageTarget(1, "electric");
			}
			break;
		
		case Gun.FLAMETHROWER:
			for (var _i = 0; _i < 3; ++_i)
			{
				ItemsMenuAddProjectile(_x + preview_face * _i * 9, _y + random_range(-8, 8), preview_face * random_range(4, 7), random_range(-1.8, 1.2), 24, make_color_rgb(255, 156, 37), random_range(5, 9), "flame", sFire, 1);
			}
			break;
		
		default:
			ItemsMenuAddProjectile(_x, _y, preview_face * 11, 0, 46, make_color_rgb(132, 236, 255), 5, "bullet", sBulletBeam, 2);
			break;
	}
	
	if (_loadout.powerup == DRONE_INUMBER && irandom_range(0, 100) < 34)
	{
		ItemsMenuAddProjectile(_x, _y - 34, preview_face * 8, -1, 54, make_color_rgb(255, 96, 72), 6, "rocket", sRocket, 1);
	}
}

function ItemsMenuUpdateProjectiles()
{
	var _updated = [];
	var _target_x = ItemsMenuTargetX();
	var _target_y = ItemsMenuTargetY();
	var _target_w = 74;
	var _target_h = 104;
	
	for (var _i = 0; _i < array_length(preview_projectiles); ++_i)
	{
		var _p = preview_projectiles[_i];
		
		if (_p.kind == "rocket" && preview_target_respawn <= 0)
		{
			var _target_direction = point_direction(_p.x, _p.y, _target_x, _target_y - 46);
			var _target_speed = point_distance(0, 0, _p.xs, _p.ys);
			_p.xs = lerp(_p.xs, lengthdir_x(_target_speed, _target_direction), 0.08);
			_p.ys = lerp(_p.ys, lengthdir_y(_target_speed, _target_direction), 0.08);
		}
		
		_p.x += _p.xs;
		_p.y += _p.ys;
		
		if (_p.kind == "flame")
		{
			_p.radius += 0.22;
			_p.ys -= 0.03;
		}
		
		_p.life -= 1;
		
		var _hit_target = preview_target_respawn <= 0
			&& _p.x > _target_x - _target_w / 2
			&& _p.x < _target_x + _target_w / 2
			&& _p.y > _target_y - _target_h
			&& _p.y < _target_y + 8;
		
		if (_hit_target)
		{
			ItemsMenuDamageTarget(_p.damage, _p.kind);
			if (_p.kind == "rocket")
			{
				audio_play_sound(soExplosion, 1, false);
			}
		}
		else if (_p.life > 0 && _p.x > items_preview_left + 18 && _p.x < items_preview_right - 18 && _p.y > items_preview_top + 18 && _p.y < items_preview_bottom - 18)
		{
			array_push(_updated, _p);
		}
	}
	
	preview_projectiles = _updated;
	
	var _damage_numbers_updated = [];
	for (var _i = 0; _i < array_length(preview_damage_numbers); ++_i)
	{
		preview_damage_numbers[_i].y -= 0.7;
		preview_damage_numbers[_i].alpha -= 0.025;
		
		if (preview_damage_numbers[_i].alpha > 0)
		{
			array_push(_damage_numbers_updated, preview_damage_numbers[_i]);
		}
	}
	preview_damage_numbers = _damage_numbers_updated;
	
	if (preview_target_hit_flash > 0) preview_target_hit_flash -= 1;
	if (preview_target_respawn > 0)
	{
		preview_target_respawn -= 1;
		if (preview_target_respawn <= 0)
		{
			preview_target_hp = preview_target_maxhp;
			preview_target_burn = 0;
		}
	}
	
	if (preview_target_burn > 0)
	{
		preview_target_burn -= 1;
		if (preview_target_burn mod 30 == 0)
		{
			ItemsMenuDamageTarget(1, "burn");
		}
	}
}

function ItemsMenuStepPreview(_move_left, _move_right, _jump, _shoot, _shoot_pressed)
{
	ItemsMenuRefreshPreviewBounds();
	
	if (items_last_cursor != items_cursor)
	{
		ItemsMenuResetPreview();
		items_last_cursor = items_cursor;
	}
	
	var _entry = ItemsMenuCurrent();
	var _loadout = ItemsMenuPreviewLoadout(_entry);
	
	preview_maxbullets = (_entry != undefined && _entry.item_name == "Bullet pack") ? 25 : 20;
	preview_maxhp = 100;
	preview_bullets = clamp(preview_bullets, 0, preview_maxbullets);
	preview_hp = clamp(preview_hp, 1, preview_maxhp);
	
	var _speed = 5;
	var _jump_power = 14;
	var _can_double_jump = false;
	
	if (_entry != undefined)
	{
		if (_loadout.powerup == LIGHTNINGBOOTS_INUMBER) _speed = 7.5;
		if (_loadout.powerup == ROCKETBOOTS_INUMBER) _jump_power = 18;
		if (_entry.item_name == "Leaf Boots") _can_double_jump = true;
	}
	
	var _move = 0;
	if (_move_left) _move -= 1;
	if (_move_right) _move += 1;
	
	preview_xspeed = _move * _speed;
	if (_move != 0) preview_face = sign(_move);
	
	if (_jump)
	{
		if (preview_grounded)
		{
			preview_yspeed = -_jump_power;
			preview_grounded = false;
			preview_double_jump = _can_double_jump;
		}
		else if (_can_double_jump && preview_double_jump)
		{
			preview_yspeed = -_jump_power * 0.9;
			preview_double_jump = false;
		}
	}
	
	preview_yspeed += 0.75;
	preview_x += preview_xspeed;
	preview_y += preview_yspeed;
	
	preview_x = clamp(preview_x, items_preview_left + 72, items_preview_right - 72);
	
	if (preview_y >= items_preview_ground)
	{
		preview_y = items_preview_ground;
		preview_yspeed = 0;
		preview_grounded = true;
		preview_double_jump = _can_double_jump;
	}
	
	if (preview_shot_timer > 0) preview_shot_timer -= 1;
	if (preview_beam_timer > 0) preview_beam_timer -= 1;
	if (preview_melee_timer > 0) preview_melee_timer -= 1;
	if (preview_heal_timer > 0) preview_heal_timer -= 1;
	if (preview_recoil > 0) preview_recoil -= 1;
	if (preview_station_timer > 0) preview_station_timer -= 1;
	if (preview_heart_timer > 0) preview_heart_timer -= 1;
	if (preview_battery_timer > 0) preview_battery_timer -= 1;
	if (preview_hazard_timer > 0) preview_hazard_timer -= 1;
	
	if (point_distance(preview_x, preview_y, ItemsMenuStationX(), items_preview_ground) < 72 && preview_station_timer <= 0)
	{
		var _gain = 8;
		if (_loadout.powerup == ENERGYFIST_INUMBER) _gain += 2;
		preview_bullets = min(preview_maxbullets, preview_bullets + _gain);
		preview_station_timer = 120;
		ItemsMenuAddDamageNumber(ItemsMenuStationX(), items_preview_ground - 116, _gain, c_aqua);
		audio_play_sound(soConfirm, 1, false);
	}
	
	if (point_distance(preview_x, preview_y, ItemsMenuHeartX(), items_preview_ground) < 52 && preview_heart_timer <= 0 && preview_hp < preview_maxhp)
	{
		var _heal = (_loadout.powerup == DOUBLEHEART_INUMBER) ? 30 : 20;
		preview_hp = min(preview_maxhp, preview_hp + _heal);
		preview_heal_timer = 24;
		preview_heart_timer = 150;
		ItemsMenuAddDamageNumber(ItemsMenuHeartX(), items_preview_ground - 92, _heal, make_color_rgb(92, 255, 132));
		audio_play_sound(soConfirm, 1, false);
	}
	
	if (point_distance(preview_x, preview_y, ItemsMenuBatteryX(), items_preview_ground) < 52 && preview_battery_timer <= 0)
	{
		preview_bullets = min(preview_maxbullets, preview_bullets + 10);
		preview_battery_timer = 150;
		ItemsMenuAddDamageNumber(ItemsMenuBatteryX(), items_preview_ground - 92, 10, c_aqua);
		audio_play_sound(soConfirm, 1, false);
	}
	
	if (abs(preview_x - ItemsMenuHazardX()) < 58 && preview_hazard_timer <= 0)
	{
		ItemsMenuDamagePlayer(12);
		preview_hazard_timer = 55;
	}
	
	if (preview_restore_pool > 0)
	{
		preview_restore_timer -= 1;
		if (preview_restore_timer <= 0)
		{
			preview_restore_timer = 12;
			preview_restore_pool -= 1;
			preview_hp = min(preview_maxhp, preview_hp + 1);
		}
	}
	
	var _is_charge_gun = (_loadout.gun_state == Gun.POWERGUN || _loadout.gun_state == Gun.CHARGING_GUN);
	
	if (_shoot && _is_charge_gun)
	{
		preview_charge = min(70, preview_charge + 1);
	}
	
	if (!_shoot && preview_was_shooting && _is_charge_gun)
	{
		ItemsMenuFire(_entry, true);
		preview_charge = 0;
		preview_shot_timer = 10;
	}
	else if (_shoot && _loadout.gun_state == Gun.FLAMETHROWER && preview_shot_timer <= 0)
	{
		ItemsMenuFire(_entry, false);
		preview_shot_timer = 3;
	}
	else if (_shoot && _loadout.gun_state == Gun.ELECTRIC_GUN && preview_shot_timer <= 0)
	{
		ItemsMenuFire(_entry, false);
		preview_shot_timer = 4;
	}
	else if (_shoot_pressed && !_is_charge_gun && preview_shot_timer <= 0)
	{
		ItemsMenuFire(_entry, false);
		preview_shot_timer = 12;
	}
	
	preview_was_shooting = _shoot;
	ItemsMenuUpdateProjectiles();
}

function ItemsMenuDrawIcon(_entry, _x, _y, _max_size, _alpha)
{
	var _scale = min(_max_size / sprite_get_width(_entry.sprite), _max_size / sprite_get_height(_entry.sprite));
	draw_set_alpha(_alpha);
	draw_sprite_ext(_entry.sprite, _entry.image, _x, _y, _scale, _scale, 0, c_white, _alpha);
	draw_set_alpha(1);
}

function ItemsMenuDrawGrid()
{
	var _left = 86;
	var _top = 145;
	var _cell = 94;
	var _gap = 16;
	var _count = array_length(items_catalog);
	
	for (var _i = 0; _i < _count; ++_i)
	{
		var _col = _i mod items_columns;
		var _row = _i div items_columns;
		var _x1 = _left + _col * (_cell + _gap);
		var _y1 = _top + _row * (_cell + _gap);
		var _x2 = _x1 + _cell;
		var _y2 = _y1 + _cell;
		var _selected = (_i == items_cursor);
		var _entry = items_catalog[_i];
		
		draw_set_alpha(0.82);
		draw_set_color(_selected ? make_color_rgb(241, 255, 245) : make_color_rgb(13, 75, 80));
		draw_roundrect(_x1, _y1, _x2, _y2, false);
		
		draw_set_alpha(_selected ? 1 : 0.55);
		draw_set_color(_selected ? make_color_rgb(36, 255, 119) : make_color_rgb(148, 227, 225));
		draw_roundrect(_x1, _y1, _x2, _y2, true);
		
		ItemsMenuDrawIcon(_entry, (_x1 + _x2) / 2, (_y1 + _y2) / 2, _cell - 24, _selected ? 1 : 0.82);
	}
	
	draw_set_alpha(1);
}

function ItemsMenuDrawDescription()
{
	var _entry = ItemsMenuCurrent();
	if (_entry == undefined) return;
	
	var _x1 = 86;
	var _y1 = room_height - 250;
	var _x2 = items_preview_left - 52;
	var _y2 = room_height - 78;
	
	draw_set_alpha(0.86);
	draw_set_color(make_color_rgb(18, 55, 59));
	draw_roundrect(_x1, _y1, _x2, _y2, false);
	
	draw_set_alpha(1);
	draw_set_color(make_color_rgb(146, 255, 240));
	draw_roundrect(_x1, _y1, _x2, _y2, true);
	
	ItemsMenuDrawIcon(_entry, _x1 + 76, _y1 + 84, 76, 1);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(CstmFntOutline);
	draw_set_color(c_white);
	draw_text(_x1 + 132, _y1 + 28, _entry.item_name);
	
	draw_set_font(fntItemDescription);
	draw_set_color(make_color_rgb(191, 255, 238));
	draw_text_transformed(_x1 + 132, _y1 + 72, _entry.category, 1.15, 1.15, 0);
	
	draw_set_color(c_white);
	draw_text_ext_transformed(_x1 + 132, _y1 + 104, _entry.description, 28, _x2 - _x1 - 160, 1.15, 1.15, 0);
}

function ItemsMenuDrawPreview()
{
	var _entry = ItemsMenuCurrent();
	if (_entry == undefined) return;
	var _loadout = ItemsMenuPreviewLoadout(_entry);
	
	ItemsMenuRefreshPreviewBounds();
	
	draw_set_alpha(0.9);
	draw_set_color(make_color_rgb(15, 52, 57));
	draw_roundrect(items_preview_left, items_preview_top, items_preview_right, items_preview_bottom, false);
	
	draw_set_alpha(1);
	draw_set_color(make_color_rgb(144, 255, 242));
	draw_roundrect(items_preview_left, items_preview_top, items_preview_right, items_preview_bottom, true);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_font(CstmFntOutline);
	draw_set_color(c_white);
	draw_text((items_preview_left + items_preview_right) / 2, items_preview_top + 24, "TEST AREA");
	
	draw_set_font(fntItemDescription);
	draw_set_color(make_color_rgb(199, 255, 247));
	draw_text_transformed((items_preview_left + items_preview_right) / 2, items_preview_top + 78, "Grid: WASD / D-pad    Player: arrows / stick, Z/Space, X    Back: Esc / B", 1.05, 1.05, 0);
	
	var _world_left = items_preview_left + 34;
	var _world_right = items_preview_right - 34;
	var _world_top = items_preview_top + 116;
	var _world_bottom = items_preview_bottom - 36;
	
	draw_set_alpha(1);
	draw_set_color(make_color_rgb(20, 218, 221));
	draw_rectangle(_world_left, _world_top, _world_right, _world_bottom, false);
	draw_set_color(c_white);
	draw_set_alpha(0.42);
	draw_sprite_stretched(bMountains, 0, _world_left, _world_top + 40, _world_right - _world_left, 220);
	draw_set_alpha(0.55);
	draw_sprite_stretched(bPineForest, 0, _world_left, _world_top + 140, _world_right - _world_left, 220);
	draw_set_alpha(1);
	
	var _row_top = items_preview_ground - 36;
	draw_set_color(make_color_rgb(46, 138, 116));
	draw_rectangle(_world_left, _row_top, _world_right, items_preview_ground + 28, false);
	draw_set_color(make_color_rgb(83, 208, 140));
	draw_rectangle(_world_left, _row_top, _world_right, _row_top + 9, false);
	draw_set_color(make_color_rgb(31, 95, 85));
	draw_line_width(_world_left, items_preview_ground + 28, _world_right, items_preview_ground + 28, 3);
	
	var _bar_x = _world_left + 18;
	var _bar_y = _world_top + 16;
	var _bar_w = 188;
	var _bar_h = 18;
	draw_set_font(fntItemDescription);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	draw_text(_bar_x, _bar_y - 10, "HP");
	draw_set_color(c_black);
	draw_rectangle(_bar_x + 46, _bar_y - _bar_h / 2, _bar_x + 46 + _bar_w, _bar_y + _bar_h / 2, false);
	draw_set_color(c_red);
	draw_rectangle(_bar_x + 46, _bar_y - _bar_h / 2, _bar_x + 46 + _bar_w * (preview_hp / preview_maxhp), _bar_y + _bar_h / 2, false);
	draw_set_color(c_white);
	draw_rectangle(_bar_x + 46, _bar_y - _bar_h / 2, _bar_x + 46 + _bar_w, _bar_y + _bar_h / 2, true);
	
	draw_set_color(c_white);
	draw_text(_bar_x, _bar_y + 26, "ENG");
	draw_set_color(c_black);
	draw_rectangle(_bar_x + 46, _bar_y + 26 - _bar_h / 2, _bar_x + 46 + _bar_w, _bar_y + 26 + _bar_h / 2, false);
	draw_set_color(c_lime);
	draw_rectangle(_bar_x + 46, _bar_y + 26 - _bar_h / 2, _bar_x + 46 + _bar_w * (preview_bullets / preview_maxbullets), _bar_y + 26 + _bar_h / 2, false);
	draw_set_color(c_white);
	draw_rectangle(_bar_x + 46, _bar_y + 26 - _bar_h / 2, _bar_x + 46 + _bar_w, _bar_y + 26 + _bar_h / 2, true);
	
	var _station_alpha = preview_station_timer <= 0 ? 1 : 0.42;
	draw_set_alpha(_station_alpha);
	draw_sprite_ext(sChargeStation, preview_station_timer > 0 ? 2 : 0, ItemsMenuStationX(), items_preview_ground - 8, 0.72, 0.72, 0, c_white, _station_alpha);
	var _heart_alpha = preview_heart_timer <= 0 ? 1 : 0.32;
	draw_set_alpha(_heart_alpha);
	draw_sprite_ext(sItems, HEARTH_INUMBER, ItemsMenuHeartX(), items_preview_ground - 50, 0.42, 0.42, 0, c_white, _heart_alpha);
	var _battery_alpha = preview_battery_timer <= 0 ? 1 : 0.32;
	draw_set_alpha(_battery_alpha);
	draw_sprite_ext(sItems, BATTERY_INUMBER, ItemsMenuBatteryX(), items_preview_ground - 50, 0.42, 0.42, 0, c_white, _battery_alpha);
	draw_set_alpha(1);
	
	var _hazard_x = ItemsMenuHazardX();
	draw_set_color(make_color_rgb(112, 25, 32));
	draw_rectangle(_hazard_x - 66, items_preview_ground - 6, _hazard_x + 66, items_preview_ground + 28, false);
	draw_set_color(make_color_rgb(255, 82, 82));
	for (var _i = 0; _i < 6; ++_i)
	{
		var _spike_x = _hazard_x - 54 + _i * 22;
		draw_triangle(_spike_x - 10, items_preview_ground - 6, _spike_x + 10, items_preview_ground - 6, _spike_x, items_preview_ground - 32, false);
	}
	
	var _target_x = ItemsMenuTargetX();
	var _target_y = ItemsMenuTargetY();
	if (preview_target_respawn <= 0)
	{
		var _target_col = preview_target_hit_flash > 0 ? make_color_rgb(255, 160, 160) : c_white;
		draw_sprite_ext(sTarget, 0, _target_x, _target_y - 38, 0.86, 0.86, 0, _target_col, 1);
		draw_set_color(c_black);
		draw_rectangle(_target_x - 48, _target_y - 116, _target_x + 48, _target_y - 104, false);
		draw_set_color(c_red);
		draw_rectangle(_target_x - 48, _target_y - 116, _target_x - 48 + 96 * (preview_target_hp / preview_target_maxhp), _target_y - 104, false);
		draw_set_color(c_white);
		draw_rectangle(_target_x - 48, _target_y - 116, _target_x + 48, _target_y - 104, true);
	}
	else
	{
		draw_set_alpha(0.45);
		draw_sprite_ext(sTarget, 0, _target_x, _target_y - 38, 0.86, 0.86, 0, c_white, 0.45);
		draw_set_alpha(1);
	}
	
	for (var _i = 0; _i < array_length(preview_projectiles); ++_i)
	{
		var _p = preview_projectiles[_i];
		var _alpha = clamp(_p.life / _p.max_life, 0.12, 1);
		draw_set_alpha(_alpha);
		if (sprite_exists(_p.sprite))
		{
			var _proj_frame = floor(get_timer() / 110000) mod max(1, sprite_get_number(_p.sprite));
			var _proj_angle = point_direction(0, 0, _p.xs, _p.ys);
			var _proj_dir = _p.xs == 0 ? 1 : sign(_p.xs);
			draw_sprite_ext(_p.sprite, _proj_frame, _p.x, _p.y, _proj_dir * 0.7, 0.7, _proj_angle, c_white, _alpha);
		}
		else
		{
			draw_set_color(_p.colour);
			draw_circle(_p.x, _p.y, _p.radius, false);
		}
	}
	
	draw_set_alpha(1);
	
	if (preview_beam_timer > 0)
	{
		var _beam_x = preview_x + preview_face * 38;
		var _beam_y = preview_y - 54;
		var _beam_target_x = preview_face == sign(_target_x - preview_x) ? _target_x : _beam_x + preview_face * 220;
		var _beam_target_y = preview_face == sign(_target_x - preview_x) ? _target_y - 54 : _beam_y + 8;
		draw_set_color(make_color_rgb(170, 255, 255));
		draw_line_width(_beam_x, _beam_y, _beam_target_x, _beam_target_y, 8);
		draw_set_color(c_white);
		draw_line_width(_beam_x, _beam_y, _beam_target_x, _beam_target_y, 3);
	}
	
	if (preview_melee_timer > 0)
	{
		draw_set_color(make_color_rgb(255, 230, 109));
		draw_line_width(preview_x + preview_face * 22, preview_y - 60, preview_x + preview_face * 92, preview_y - 30, 9);
		draw_set_color(c_white);
		draw_line_width(preview_x + preview_face * 28, preview_y - 64, preview_x + preview_face * 82, preview_y - 24, 3);
	}
	
	if (_entry.item_id == FORCEFIELD_INUMBER)
	{
		draw_set_alpha(preview_shield_ready ? 0.22 : 0.08);
		draw_set_color(make_color_rgb(212, 255, 255));
		draw_circle(preview_x, preview_y - 52, 70, false);
		draw_set_alpha(preview_shield_ready ? 0.95 : 0.25);
		draw_circle(preview_x, preview_y - 52, 70, true);
		draw_set_alpha(1);
	}
	
	if (_loadout.powerup == DRONE_INUMBER || _entry.item_name == "Suspicious Eye")
	{
		var _orbit_x = preview_x + sin(get_timer() / 180000) * 74;
		var _orbit_y = preview_y - 108 + cos(get_timer() / 180000) * 12;
		if (_entry.item_name == "Suspicious Eye")
		{
			draw_sprite_ext(sPassiveItems, _entry.image, _orbit_x, _orbit_y, 0.5, 0.5, 0, c_white, 1);
		}
		else
		{
			draw_sprite_ext(sItems, DRONE_INUMBER, _orbit_x, _orbit_y, 0.48, 0.48, 0, c_white, 1);
		}
	}
	
	if (_entry.profile_index >= 0 && _entry.item_name != "Suspicious Eye")
	{
		draw_sprite_ext(sPassiveItems, _entry.image, preview_x - preview_face * 58, preview_y - 112, 0.46, 0.46, 0, c_white, 0.92);
	}
	else if (!ItemsMenuHasGun(_entry) && _entry.item_id != DRONE_INUMBER && _entry.item_id != FORCEFIELD_INUMBER)
	{
		draw_sprite_ext(sItems, _entry.image, preview_x - preview_face * 48, preview_y - 94, 0.42, 0.42, 0, c_white, 0.9);
	}
	
	if (preview_heal_timer > 0 || _entry.item_id == DOUBLEHEART_INUMBER)
	{
		draw_sprite_ext(sItems, HEARTH_INUMBER, preview_x, preview_y - 132 - sin(get_timer() / 120000) * 6, 0.34, 0.34, 0, c_white, 0.95);
	}
	
	var _sprites = GetSpritesFromName(global.character);
	var _player_sprite = _sprites.idle;
	var _player_frame = 0;
	if (!preview_grounded) _player_sprite = _sprites.jump;
	else if (abs(preview_xspeed) > 0.1)
	{
		_player_sprite = _sprites.run;
		_player_frame = floor(get_timer() / 90000) mod max(1, sprite_get_number(_player_sprite));
	}
	else _player_sprite = _sprites.idle;
	
	if (!preview_grounded)
	{
		_player_frame = preview_yspeed > 0 ? min(1, sprite_get_number(_player_sprite) - 1) : 0;
	}
	
	var _player_scale = 1.45;
	draw_sprite_ext(_player_sprite, _player_frame, preview_x, preview_y, preview_face * _player_scale, _player_scale, 0, c_white, 1);
	
	var _hands_sprite = _sprites.hands;
	var _hands_index = (_loadout.gun_state == Gun.ROCKET_LAUNCHER) ? 1 : 0;
	var _gun_sprite = ItemsMenuGunSpriteFromState(_loadout.gun_state);
	var _gun_x = preview_x - (4 + preview_recoil) * preview_face * _player_scale;
	var _gun_y = preview_y - ((_loadout.gun_state == Gun.ROCKET_LAUNCHER) ? 34 : 22) * _player_scale;
	var _hands_y = preview_y - 22 * _player_scale;
	draw_sprite_ext(_hands_sprite, _hands_index, _gun_x, _hands_y, preview_face * _player_scale, _player_scale, 0, c_white, 1);
	if (_gun_sprite != -1)
	{
		draw_sprite_ext(_gun_sprite, 0, _gun_x, _gun_y, preview_face * _player_scale, _player_scale, 0, c_white, 1);
	}
	
	if (preview_charge > 0)
	{
		var _charge_radius = 12 + preview_charge / 4;
		draw_set_alpha(0.28);
		draw_set_color(make_color_rgb(255, 84, 223));
		draw_circle(_gun_x + preview_face * 36, _gun_y, _charge_radius, false);
		draw_set_alpha(1);
	}
	
	draw_set_font(FntDamage);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	for (var _i = 0; _i < array_length(preview_damage_numbers); ++_i)
	{
		var _num = preview_damage_numbers[_i];
		draw_set_alpha(_num.alpha);
		draw_set_color(_num.colour);
		draw_text(_num.x, _num.y, _num.text);
	}
	draw_set_alpha(1);
}

function ItemsMenuDraw()
{
	ItemsMenuRefreshPreviewBounds();
	
	draw_set_alpha(1);
	draw_set_color(make_color_rgb(16, 215, 217));
	draw_rectangle(0, 0, room_width, room_height, false);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(CstmFntOutline);
	draw_set_color(c_white);
	draw_text(86, 56, "ITEMS");
	
	draw_set_font(fntItemDescription);
	draw_set_color(make_color_rgb(21, 59, 63));
	draw_text_transformed(250, 72, "Browse items with WASD or D-pad. The test area uses the normal in-game controls.", 1.18, 1.18, 0);
	
	ItemsMenuDrawGrid();
	ItemsMenuDrawDescription();
	ItemsMenuDrawPreview();
	
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(CstmFntOutline);
}

ItemsMenuBuildCatalog();
ItemsMenuResetPreview();
