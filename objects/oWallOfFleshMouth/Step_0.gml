
xspeed = (-oRoomControl.roomspeed + 1);
if (oWallOfFleshController.state != UniversalStates.DEAD && x < oCamera.left - 50)
{
	x = oCamera.left - 50;	
}
event_inherited();

hp = 1;


leech_spawn_timer--;
if (leech_spawn_timer <= 0 && oWallOfFleshController.state != UniversalStates.DEAD)
{
	leech_spawn_timer = leech_spawn_timer_max;

	with(Create(x, y, oWallOfFleshLeech, row))
	{
		depth = other.depth - 1;
		walkspeed = 10;
	}
}

for (var _h = 0; _h < 1000; _h += 50)
{
	var _list = ds_list_create();
	var _count = instance_place_list(x + 50, _h, oSolidParent, _list, true);
	
	repeat(_count) {
		var _current_block = ds_list_find_value(_list, 0);
		
		_current_block.fade_away = true;
		ds_list_delete(_list, 0);	
	}
	ds_list_destroy(_list);
}
