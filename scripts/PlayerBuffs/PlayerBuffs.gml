function PlayerBuffs() {
	jumpspeed = 12;
	protected = false;
	walkspeed = 8;
	drill_damage = base_drill_damage;

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
			
		case LIGHTNINGBOOTS_INUMBER:
			walkspeed = 10;
			break
			
		case DOUBLEHEART_INUMBER:
			break;
		
		case DRONE_INUMBER:
			break;
			
		case BURN_INUMBER:
			break;
			
		case REFRACTOR_INUMBER:
			break;
			
		case INFINITYGUN_INUMBER:
			break;
			
		case CRUSH_INUMBER:
			drill_damage = base_drill_damage + irandom_range(1, 3);
			break;
	
		default:
			break;
	}	
	
	
	for (var _i = 0; _i < ds_list_size(inventory); ++_i)
	{
		var _item_index = ds_list_find_value(inventory, _i);
		
		
	}
	
}