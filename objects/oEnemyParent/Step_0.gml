// Inherit the parent event
event_inherited();

if (on_fire > 0)
{
	if (on_fire % 60 == 0)
	{
		hp -= 1;
		if object_is_ancestor(object_index, oBossParent)
		{
			cum_hp -= 1;	
		}
		with(Create(x, y - 50, oDamageNumber, row))
		{
			damage = 1;
			depth = other.depth - 2;
		}
		hit_flash = 3;
	}
	on_fire -= 1;
}