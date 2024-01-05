// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function GetGunSprite(gun_type){
	switch (gun_type)
	{
		case Gun.STANDART_GUN:
			return sStandartGun;
		
		case Gun.DRILL:
			return sDrill;
		
		case Gun.SHOTGUN:
			return sShotgun;
		
		case Gun.POWERGUN : 
			return sPowerGun;
			
		case Gun.ROCKET_LAUNCHER:
			return sRocketLauncher;
		
		case Gun.LIFESTEAL_GUN:
			return sLifestealGun;
			
		case Gun.REAL_SHOTGUN:
			return sRealShotgun;
			
		case Gun.ELECTRIC_GUN:
			return sElectricGun;
	}

}