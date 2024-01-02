/// @description
event_inherited();

if (x > oCamera.right)
{
	x = oCamera.right;	
}

if (item_picked_up)
{
	onHurtEvent = GetItemActions(id, "on_hurt");	
	onJumpEvent = GetItemActions(id, "on_jump");

	
	var _item = inventory[| ds_list_size(inventory) - 1];
	var _action = struct_exists(_item, "on_pickup") ? struct_get(_item, "on_pickup") : undefined;
	
	if (_action != undefined)
	{
		_action(id);
	}
	
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