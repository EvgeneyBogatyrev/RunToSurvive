
var _add_y = 0;
var _chosen_player = undefined;

for (var _i = 0; _i < instance_number(oPlayer); _i++)
{
	var _player = instance_find(oPlayer, _i);
	if _player == noone continue;
	if _player.state == UniversalStates.DEAD continue;
	if _player.row != row continue;
	
	if ((_chosen_player == undefined || _chosen_player.x > _player.x) && _player.x > x - walkspeed)
	{
		_chosen_player = _player;	
	}
}

if (_chosen_player != undefined)
{
	_add_y = (_chosen_player.y - 30 - y) * 0.8;
}
else
{
	_add_y = (oGenerator.ground[row] - y) * 0.1;
}

xspeed = walkspeed;
yspeed = magnitude * -cos((get_timer() - start_time) * timescale) + _add_y;


// Inherit the parent event
event_inherited();


if (x > oCamera.right + 1000)
{
	instance_destroy();
}
