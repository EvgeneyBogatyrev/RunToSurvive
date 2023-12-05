// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function AimProjectileChooseTarget(_row){
	var _target = noone;
	var _number_of_enemies = instance_number(oEnemyParent);
	var _choose_array = [];
	for (var i = 0; i < instance_number(oEnemyParent); ++i)
	{
		_choose_array[array_length(_choose_array)] = instance_find(oEnemyParent, i);
	}
	//Print("Before", _choose_array);
	array_shuffle_ext(_choose_array);
	//Print("Before", _choose_array);

	for (var i = 0; i < array_length(_choose_array); ++i)
	{
		var _enemy = _choose_array[i];
	
		if (_row == _enemy.row || (_enemy.object_index == oDelver && _enemy.state == DelverStates.INSECT))
		{	
			_target = _enemy;
			//if (_target == noone || distance_to_object(_target) > distance_to_object(_enemy))   _target = _enemy;
		}
	}	
	return _target;
}