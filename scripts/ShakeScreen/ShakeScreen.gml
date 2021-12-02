///@desc Shake screen
///@param magtitude
///@param length
function ShakeScreen(argument0, argument1) {

	var _magnitude = argument0;
	var _length    = argument1;

	with (oCamera)
	{
		if (_magnitude > shake_remain) 
		{
			shake_magnitude = _magnitude;
			shake_remain = _magnitude;
			shake_lenght = _length;
		}
	}



}
