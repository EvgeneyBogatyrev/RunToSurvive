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


}
