///@desc ContactDamage(damage, percent);
///@args damage
///@args percent
function ContactDamage() {

	/// Deal damage to the player straight or in percents.

	var _damage  =  argument[0];
	var _percent =  argument[1];

	var _ignore_damaged = false;
	if (argument_count > 2 && argument[2])  _ignore_damaged = true;

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
		
			if (_percent)  _damage = max(10, int64(_player.hp * _percent / 100));		
			_dealt = true;
		
			if (!_player.protected)  _player.hp -= _damage;
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

function CircleDamage(_damage, _percent, _x, _y, _radius, _ignore_damaged=false) {

	/// Deal damage to the player straight or in percents (in circle).

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
		
			if (_percent)  _damage = max(10, int64(_player.hp * _percent / 100));		
			_dealt = true;
		
			if (!_player.protected)  _player.hp -= _damage;
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

function ContactDamageKnockback(_damage, _speed_coef)
{
	var _list = ds_list_create();
	var _count = instance_place_list(x, y, oPlayer, _list, true);
	
	var _dealt = false;

	repeat(_count) 
	{	
		var _player = ds_list_find_value(_list, 0);
	
		if (_player.row == row && !_player.damaged)
		{
			_player.damaged = true;	
			_player.damage_timer = 5*30;
			Knockback(_player, _speed_coef);
		
			_dealt = true;
		
			if (!_player.protected)  _player.hp -= _damage;
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