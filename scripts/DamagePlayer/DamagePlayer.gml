///@desc ContactDamage(damage, percent);
///@args damage
///@args percent
function GetDamageSourceName(_source) {
	if (_source == undefined || !instance_exists(_source))  return "unknown damage";

	if (variable_instance_exists(_source, "host") && instance_exists(_source.host) && _source.host.object_index != oPlayer)
	{
		return GetDamageSourceName(_source.host);
	}

	switch (_source.object_index)
	{
		case oArrow: return "an arrow";
		case oBilly: return "Billy";
		case oBlock: return _source.lava_block ? "a lava block" : "a block";
		case oChasingStump: return "the chasing stump";
		case oDelver: return "the Delver";
		case oDelverZap: return "Delver lightning";
		case oFloatingEye: return "a floating eye";
		case oFlyingRobot: return "a flying robot";
		case oMissileLauncher:
		case oMissileVertical: return "a missile";
		case oObstacle: return "an obstacle";
		case oPandora: return "Pandora";
		case oRobotBoss: return "the robot boss";
		case oRunningStump: return "a running stump";
		case oShootingRobot: return "a shooting robot";
		case oShootingRobotBullet: return "a robot bullet";
		case oSpamtonNeo: return "Spamton NEO";
		case oSpamtonPipis: return "Pipis";
		case oSpamtonShard: return "a Spamton shard";
		case oSpamtonSmall: return "a Spamton clone";
		case oStump: return "a stump";
		case oStumpTree: return "the stump tree";
		case oTallRobot: return "a tall robot";
		case oThunderDelver: return "Delver thunder";
		case oWallOfFleshBullet: return "a Wall of Flesh projectile";
		case oWallOfFleshLeech: return "a Wall of Flesh leech";
		case oWallOfFleshMovement: return "the Wall of Flesh";
		case oWildvine: return "wildvine";
		default:
			var _name = object_get_name(_source.object_index);
			if (string_char_at(_name, 1) == "o")  _name = string_delete(_name, 1, 1);
			return _name;
	}
}

function GetDamageSourceSprite(_source) {
	if (_source == undefined || !instance_exists(_source))
	{
		return { sprite : noone, image : 0 };
	}

	if (variable_instance_exists(_source, "host") && instance_exists(_source.host) && _source.host.object_index != oPlayer)
	{
		return GetDamageSourceSprite(_source.host);
	}

	if (!sprite_exists(_source.sprite_index))
	{
		return { sprite : noone, image : 0 };
	}

	return { sprite : _source.sprite_index, image : max(0, floor(_source.image_index)) };
}

function RememberPlayerDamage(_player, _damage, _source_name, _source=undefined) {
	if (!instance_exists(_player))  return;

	_player.last_damage_reason = "was defeated by " + _source_name;
	_player.last_damage_amount = _damage;
	_player.last_damage_time = oRoomControl.run_timer;

	var _source_sprite = GetDamageSourceSprite(_source);
	_player.last_damage_sprite = _source_sprite.sprite;
	_player.last_damage_image = _source_sprite.image;
}

function ContactDamage() {

	/// Deal damage to the player straight or in percents.

	var _damage  = argument[0];
	var _percent = 0;
	if (argument_count > 1)  _percent = argument[1];

	var _ignore_damaged = false;
	if (argument_count > 2 && argument[2])  _ignore_damaged = true;

	var _source_name = GetDamageSourceName(id);
	if (argument_count > 3 && argument[3] != undefined)  _source_name = argument[3];

	var _list = ds_list_create();
	var _count = instance_place_list(x, y, oPlayer, _list, true);


	var _dealt = false;

	repeat(_count)
	{
		var _player = ds_list_find_value(_list, 0);

		if (_player.row == row && (!_player.damaged || _ignore_damaged))
		{
			_player.damaged = true;
			_player.damage_timer = 5*30;

			var _final_damage = _damage;
			if (_percent)  _final_damage = max(10, int64(_player.hp * _percent / 100));
			_dealt = true;

			if (!_player.protected)
			{
				RememberPlayerDamage(_player, _final_damage, _source_name, id);
				_player.hp -= _final_damage;
			}
			else
			{
				_player.protected = false;
				if (_player.pocket[1] == FORCEFIELD_INUMBER)
				{
					_player.pocket[1] = 0;
				}
			}

		}

		ds_list_delete(_list, 0);
	}

	ds_list_destroy(_list);

	if (_dealt)  ShakeScreen(10, 15);

	return _dealt;

}

function CircleDamage(_damage, _percent, _x, _y, _radius, _ignore_damaged=false, _source_name=undefined) {

	/// Deal damage to the player straight or in percents (in circle).

	if (_source_name == undefined)  _source_name = GetDamageSourceName(id);

	var _list = ds_list_create();
	//var _count = instance_place_list(x, y, oPlayer, _list, true);
	var _count = collision_circle_list(_x, _y, _radius, oPlayer, false, false, _list, true);

	var _dealt = false;

	repeat(_count)
	{
		var _player = ds_list_find_value(_list, 0);

		if (_player.row == row && (!_player.damaged || _ignore_damaged))
		{
			_player.damaged = true;
			_player.damage_timer = 5*30;

			var _final_damage = _damage;
			if (_percent)  _final_damage = max(10, int64(_player.hp * _percent / 100));
			_dealt = true;

			if (!_player.protected)
			{
				RememberPlayerDamage(_player, _final_damage, _source_name, id);
				_player.hp -= _final_damage;
			}
			else
			{
				_player.protected = false;
				if (_player.pocket[1] == FORCEFIELD_INUMBER)
				{
					_player.pocket[1] = 0;
				}
			}

		}

		ds_list_delete(_list, 0);
	}

	ds_list_destroy(_list);

	if (_dealt)  ShakeScreen(10, 15);

	return _dealt;


}

function ContactDamageKnockback(_damage, _force_x, _force_y, _source_name=undefined)
{
	if (_source_name == undefined)  _source_name = GetDamageSourceName(id);

	var _list = ds_list_create();
	var _count = instance_place_list(x, y, oPlayer, _list, true);

	var _dealt = false;

	repeat(_count)
	{
		var _player = ds_list_find_value(_list, 0);

		if (_player.row == row)
		{
			KnockbackForce(_player, _force_x, _force_y);
			if (!_player.damaged)
			{
				_player.damaged = true;
				_player.damage_timer = 5*30;
				_dealt = true;

				if (!_player.protected)
				{
					RememberPlayerDamage(_player, _damage, _source_name, id);
					_player.hp -= _damage;
				}
				else
				{
					_player.protected = false;
					if (_player.pocket[1] == FORCEFIELD_INUMBER)
					{
						_player.pocket[1] = 0;
					}
				}
			}
		}

		ds_list_delete(_list, 0);
	}

	ds_list_destroy(_list);

	if (_dealt)  ShakeScreen(10, 15);

	return _dealt;
}


function DamageSpecificPlayer(_player, _damage, _ignore_damaged=false, _source_name=undefined)
{
	if (_player.damaged && !_ignore_damaged)
	{
		return false;
	}

	if (_source_name == undefined)  _source_name = GetDamageSourceName(id);

	_player.damaged = true;
	_player.damage_timer = 5*30;


	var _dealt = true;

	if (!_player.protected)
	{
		RememberPlayerDamage(_player, _damage, _source_name, id);
		_player.hp -= _damage;
	}
	else
	{
		_player.protected = false;
		if (_player.pocket[1] == FORCEFIELD_INUMBER)
		{
			_player.pocket[1] = 0;
		}
	}

	if (_dealt)  ShakeScreen(10, 15);

	return _dealt;
}
