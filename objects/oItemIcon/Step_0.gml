/// @description

if (host == noone || !instance_exists(host) || host.state == UniversalStates.DEAD)
{
	instance_destroy();
	exit;
}

row = host.row;
depth = host.depth;
scale = host.scale;
x = host.x;
y = host.bbox_top - offset * scale;

var _keys = Input(host._input_type);
var _accept = _keys[7];
var _cancel = _keys[8];

var _next_gun = -1;
if (index < ROCKETBOOTS_INUMBER)  _next_gun = GetGunStateFromID(index);

if (_accept || index == host.pocket[0])
{
	var _pocket_index;
	if (index < ROCKETBOOTS_INUMBER)
	{
		_pocket_index = 0;
		if (index == host.pocket[0])
		{
		    host.bullets = host.maxbullets;
		}
		else
		{
			host.gun.current_gun = _next_gun;
			host.gun.secondary = false;
		}
	}
	else	_pocket_index = 1;		
	

	host.pocket[_pocket_index] = index;
	instance_destroy();
}
else if (_cancel)	instance_destroy();	


time--;
if (time == 0)  instance_destroy();
