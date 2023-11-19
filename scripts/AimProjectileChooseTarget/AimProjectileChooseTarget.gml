// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function AimProjectileChooseTarget(_row){
	var _target = noone;
	for (var i = 0; i < instance_number(oEnemyParent); ++i)
	{
		var _enemy = instance_find(oEnemyParent, i);
	
		if (_row == _enemy.row || (_enemy.object_index == oDelver && _enemy.state == DelverStates.INSECT))
		{	
			if (_target == noone || distance_to_object(_target) > distance_to_object(_enemy))   _target = _enemy;
		}
	}	
	return _target;
}