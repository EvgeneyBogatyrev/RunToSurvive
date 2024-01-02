///@desc Get the cost of the gun
///@param gun
function GetCost(argument0) {

	switch(argument0)
	{
		case Gun.STANDART_GUN:
			return 1;
	
		case Gun.DRILL:
			return 0;
		
		case Gun.SHOTGUN:
			return 4;
		
		case Gun.POWERGUN:
			return 1;
	
		case Gun.ROCKET_LAUNCHER:
			return 3;
			
		case Gun.LIFESTEAL_GUN:
			return 2;
			
		case Gun.REAL_SHOTGUN:
			return 1/4;
			
		case Gun.ELECTRIC_GUN:
			return 0.01;
	
		default:
			Raise("Invalid gun\n");
			break;
	}

	return NaN;


}
