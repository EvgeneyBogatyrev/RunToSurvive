///@desc Get key fields for the player
function PlayerControl() {

	var _keys = Input(_input_type);
	//var _keys = InputFromDevice(device);

	if (state == UniversalStates.DEAD || !active)	_keys = array_create(8, 0);

	_left  = _keys[0];
	_right = _keys[1];
	_up    = _keys[2] && !blocked;
	_down  = _keys[3] && !blocked;
	_jump  = _keys[4];
	_shoot = _keys[5];
	_shoot_hold = _keys[6];
	_show_inv = _keys[10];
	//_left_gun = _keys[7];
	//_right_gun = _keys[8];

	if (_shoot && instance_exists(gun))       gun.shoot = true;
	if (_shoot_hold && instance_exists(gun))  gun.shoot_hold = true;

	//if (_left_gun && instance_exists(gun) && pocket[0] != 0)
	//{
	//	var _next_gun = GetGunFromImage(other.pocket[0]);
	//	with (gun)
	//	{
	//		current_gun = _next_gun;
	//		last_gun = Gun.DRILL;
	//		shotgun_times = 0;
	//		shotgun_timer = 0;
	//		temp_bullets = 0;
	//	}
	//	active_pocket_index = 0;
	//}

	//if (_right_gun && instance_exists(gun) && pocket[1] != 0)
	//{
	//	var _next_gun = GetGunFromImage(other.pocket[1]);
	//	with (gun)
	//	{
	//		current_gun = _next_gun;
	//		last_gun = Gun.DRILL;
	//		shotgun_times = 0;
	//		shotgun_timer = 0;
	//		temp_bullets = 0;
	//	}
	//	active_pocket_index = 1;
	//}


}
