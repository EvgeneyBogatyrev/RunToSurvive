///@desc CheckCollisions(x, y, object, row);
///@args x
///@args y
///@args object
///@args row
function GetCollider(argument0, argument1, argument2, argument3) {

	/// Return the closest colliding object of specific type or noone.

	///Made by Evgeney Zimin

	var _x = argument0;
	var _y = argument1;
	var _object = argument2;
	var _row = argument3;

	var _list = ds_list_create();
	var _count = instance_place_list(_x, _y, _object, _list, true);
	
	repeat(_count){
		var current_block = ds_list_find_value(_list, 0);
		
		if (current_block.row == _row)
		{
			return current_block;
		}
		ds_list_delete(_list, 0);	
	}
	ds_list_destroy(_list);

	return noone;


}
