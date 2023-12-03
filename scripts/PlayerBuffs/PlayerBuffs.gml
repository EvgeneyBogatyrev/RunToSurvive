function PlayerBuffs() {
	jumpspeed = 12;
	protected = false;

	switch (pocket[1])
	{
		case ROCKETBOOTS_INUMBER:
			jumpspeed = 12 * 1.2;
			break;
	
		case FORCEFIELD_INUMBER:
			protected = true;
			break;
	
		case ENERGYFIST_INUMBER:
			//bullets += 0.005;  <- to OP
			break;
	
		default:
			break;
	}	
	
	
	for (var _i = 0; _i < ds_list_size(inventory); ++_i)
	{
		var _item_index = ds_list_find_value(inventory, _i);
		
		
	}
	
}