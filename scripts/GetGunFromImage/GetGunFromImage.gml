///@deck ImageIndex -> GunState
function GetGunFromImage(argument0) {

	switch (argument0)
	{
		case STDGUN_INUMBER:
			return Gun.STANDART_GUN;
		case SHOTGUN_INUMBER:
			return Gun.SHOTGUN;
		case POWERGUN_INUMBER:
			return Gun.POWERGUN;
		case ROCKET_LAUNCHER_INUMBER:
			return Gun.ROCKET_LAUNCHER;
		case LIFESTEAL_GUN_INUMBER:
			return Gun.LIFESTEAL_GUN;
		case REALSHOTGUN_GUN_INUMBER:
			return Gun.REAL_SHOTGUN;
		default:
			Raise("Wrong gun image_index\n");
			break;
	}


}
