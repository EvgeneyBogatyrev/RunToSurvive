///@desc Create(x, y, instance_name, row);
///@argc x
///@argc y
///@argc instance_name
///@argc row
function Create(argument0, argument1, argument2, argument3) {

	///Creates specific object straight on the row

	var _x = argument0;
	var _y = argument1;
	var _instance_name = argument2;
	var _row = argument3;

	var _obj = instance_create_layer(_x, _y, "MainLayer", _instance_name);
	with (_obj)
	{
		row = _row;
		depth = - 100 * row;
		scale = GetScale(row);
	}

	return _obj;



}