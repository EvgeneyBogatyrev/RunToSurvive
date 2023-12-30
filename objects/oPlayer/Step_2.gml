/// @description
event_inherited();

if (x > oCamera.right)
{
	x = oCamera.right;	
}

if (item_picked_up)
{
	onHurtEvent = GetItemActions(id, "on_hurt")
	
	item_picked_up = false;
}

if (should_update_orbitals)
{
	UpdateOrbitals(id);
	should_update_orbitals = false;
}

if (hp < prev_hp && hp > 0)
{
	for (var i = 0; i < array_length(onHurtEvent); i++)
	{
		onHurtEvent[i](id);
	}
}

prev_hp = hp;