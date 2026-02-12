function PlayerBuffs() {
	jumpspeed = 12;
	protected = false;
	walkspeed = 8;
	melee_damage = base_melee_damage;
	
	double_jump = false;
	maxbullets = 20;
	damageBoost = 0;
	
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
			melee_damage += irandom_range(1, 3);
			break;
	
		default:
			break;
	}	
	
	
	onHurtEvent = GetItemActions(id, "on_hurt");	
	onJumpEvent = GetItemActions(id, "on_jump");
	onBulletHitEvent  = GetItemActions(id, "on_hit");
	onShootEvent = GetItemActions(id, "on_shoot");
	onKillEvent = GetItemActions(id, "on_kill");

	var _pickup_event = GetItemActions(id, "on_pickup");
	for (var i = 0; i < array_length(_pickup_event); i++)
	{
		_pickup_event[i](id);
	}
	
	if (damage_to_restore > 0)
	{
		damage_to_restore_timer--;
		if (damage_to_restore_timer <= 0)
		{
			damage_to_restore_timer = damage_to_restore_timer_max;
			hp += 1;
			damage_to_restore -= 1;
		}
	}
	
}