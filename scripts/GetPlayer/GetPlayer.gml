///@desk Get player based on the criteria
///@param criteria
function GetPlayer() {

	enum PlayerPreferences
	{
		RANDOM,
		LOWEST_HEALTH,
		CLOSEST,
		NOT_STANDARD_WEAPON,
	}

	var _players_number = instance_number(oPlayer);
	if (_players_number == 0)  return noone;

	var _criteria = PlayerPreferences.RANDOM;

	if (argument_count > 0)  _criteria = argument[0];



	switch (_criteria)
	{
		case PlayerPreferences.RANDOM:
			return instance_find(oPlayer, irandom_range(0, _players_number - 1));
		
		case PlayerPreferences.LOWEST_HEALTH:
			var _target = noone;
			for (var i = 0; i < _players_number; ++i)
			{                                              
				var _player = instance_find(oPlayer, i);                     
				Assert(_player != noone, "No player");                       
				if ((_target == noone || _player.hp < _target.hp) && _player.state != UniversalStates.DEAD)  _target = _player;
			}
			return _target;	
		
		case PlayerPreferences.CLOSEST:
			var _target = noone;
			for (var i = 0; i < _players_number; ++i)
			{
				var _player = instance_find(oPlayer, i);
				if ((_target == noone || distance_to_object(_player) < distance_to_object(_target)) && _player.state != UniversalStates.DEAD)  _target = _player;
			}
			return _target;
			
		case PlayerPreferences.NOT_STANDARD_WEAPON:
			var _target = noone;
			for (var i = 0; i < _players_number; ++i)
			{
				var _player = instance_find(oPlayer, i);
				if (_player.state != UniversalStates.DEAD &&  _player.gun.current_gun != Gun.STANDART_GUN && _player.bullets > 0)  _target = _player;
			}
			if (_target == noone)
			{
				return GetPlayer(PlayerPreferences.RANDOM);	
			}
			return _target;
	
		default:
			Raise("Invalid player preference\n");
			break;
	}


}
