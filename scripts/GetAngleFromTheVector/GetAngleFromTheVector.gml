///@desc GetAngleFromTheVector(x, y)
///@argc x
///@argc y
function GetAngleFromTheVector(argument0, argument1) {

	///!!! This function is not complete !!!

	var _x = argument0;
	var _y = argument1;

	if (_x == 0) 
	{
		return (pi/2 - 0.001) * sign(_y);	
	}

	return arctan(_y/_x);



}
