///@desc Increase(variable, increase_to, increment_value)
///@args variable
///@args increase_to
///@args increment_value
function Increase(argument0, argument1, argument2) {

	///Increase value to some limit.

	var value = argument0 + argument2;

	if (argument2 > 0)
	{
		if (value >= argument1)  value = argument1;
	}
	else
	{
		if (value <= argument1)  value = argument1;
	}

	return value;


}
