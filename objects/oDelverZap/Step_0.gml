/// @description

if (!instance_exists(host))
{
	instance_destroy();
	exit;
}

x = host.x - 41 * host.dir;

y -= spd;
spd = lerp(spd, max_speed, acc);

if (y <= bound)
{
	
	for (var _offset = -1; _offset <= 1; ++_offset) 
	{
		with (Create(x, y, oThunderDelver, row)) 
		{
			offset = _offset;
			image_index = abs(offset);
			
			player = other.player;
	
			row = other.rrow;
			GetScale(row, true);
			x = other.xx + offset * sprite_width * image_xscale;	
		}
	}
	instance_destroy();	
}