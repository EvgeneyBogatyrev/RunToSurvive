with(Create(x, y, oSparkle, row))
{
	if (other.sprite_index == sPellet)
	{
		sprite_index = sPellet;	
	}
	else if other.sprite_index == sBullet 
	{
		sprite_index = sSparkle;	
	}
	else if other.sprite_index = sBlast
	{
		sprite_index = sSparkleBlast;
	}
	else
	{
		sprite_index = sSparkleBeam;
	}
	dir = other.dir;
	scale = other.scale;
	depth = other.depth;
	image_xscale = dir;
}

if (display) with(Create(x, y, oDamageNumber, row))
{
	damage = other.damage;
	depth = other.depth - 2;
}

if (hit_an_enemy)
{
	for (var i = 0; i < array_length(hit_events); i++)
	{
		hit_events[i](id);
	}
}
