with(Create(x, y, oSparkle, row))
{
	sprite_index = sSparkleBeam;
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

for (var i = 0; i < array_length(hit_events); i++)
{
	hit_events[i]();
}
