///@desc Change variable1 in a direction of variable2
///@param variable1 variable
///@param variable2 goal
function ApproachTo(argument0, argument1) {

	return argument0 + sign(argument1 - argument0);


}

function Approach(_from, _to, _speed)
{
	var _diff = sign(_to - _from);
	
	var _res = _from + _diff * _speed;
	
	if (_diff > 0)
		_res = min(_to, _res);
	else
		_res = max(_to, _res);
	
	return _res;
}