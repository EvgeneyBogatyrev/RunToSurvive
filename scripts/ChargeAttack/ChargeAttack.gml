///@desc Charge Attack
///@param target
///@param offset
///@param time
///@param count_row?
function ChargeAttack(argument0, argument1, argument2, argument3) {

	var _target = argument0;
	var _offset = argument1;
	var _time = argument2;
	var _count_row = argument3;

	if (state != UniversalStates.CHARGE_ATTACK && distance_to_object(_target) < _offset && (!_count_row || row == _target.row))
	{
		saved_state_mark = state;	
		state = UniversalStates.CHARGE_ATTACK;
		charge_attack_timer = _time;
		speed *= 1.5;
		saved_direction = direction;
	}

	if (state == UniversalStates.CHARGE_ATTACK)
	{
		direction = saved_direction;
		charge_attack_timer--;
		if (CheckCollisions(x, y, _target, row) || (place_meeting(x, y, _target) && !_count_row))
		{
			direction = choose(45, 90, 135);
			saved_direction = direction;
		}
	
		if (CheckCollisions(x, y, oBlock, row)) charge_attack_timer = 0;
	
		if (charge_attack_timer <= 0)
		{
			state = saved_state_mark;	
			return false;
		}
		return true;
	}
	
	return false;




}
