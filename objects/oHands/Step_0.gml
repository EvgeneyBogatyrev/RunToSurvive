if (not instance_exists(host))
	instance_destroy();	
else
{
	sprite_index = host.character.sprites.hands;
	row = host.row;
	image_xscale = host.image_xscale;
	image_yscale = host.image_yscale;
	image_alpha = host.image_alpha;
	
	switch (host.gun.current_gun)
	{	
		case Gun.BASIC_REPEATER:
			depth = host.gun.depth - 1;
			x = host.xprevious + (12 * host.dir * host.scale);
			y = host.yprevious - 22 * host.scale;
			image_index = 2;
			break;
		case Gun.SHORTRANGE_BLASTER:
			depth = host.gun.depth - 1;
			x = host.xprevious + (12 * host.dir * host.scale);
			y = host.yprevious - 22 * host.scale;
			image_index = 2;
			break;
		case Gun.ROCKET_LAUNCHER:
			depth = host.depth + 1;
			x = host.x - (4 + host.gun.recoil) * host.dir * host.scale;
			y = host.yprevious - 22 * host.scale;
			image_index = 1;
			enabled = true;
			break;
		case Gun.STEAMPUNK_HAMMER:
		case Gun.KICKS_N_PUNCHES:
			enabled = false;
			break;
		default:
			depth = host.gun.depth - 1;
			x = host.xprevious - (4 + host.gun.recoil) * host.dir * host.scale;
			y = host.yprevious - 22 * host.scale;
			image_index = 0;
			enabled = true;
			break;
	}
}