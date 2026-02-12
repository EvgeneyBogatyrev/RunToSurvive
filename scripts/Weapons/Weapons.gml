function Weapon(_profile) constructor
{
	profile = _profile;
	
	
	cooldown = 0;
	
	
	hold = false;
	
	bullets_queue = 0;
	queue_timer = 0;
	
	//Visual
	amim_frame = 0;
	offset_x = 0;
	offset_y = 0;
	
	Step = function() //Temprorary, move to some object later
	{
		
		var _input;
		
		if (_input && cooldown <= 0)
		{
			//Shoot function
			if profile.shoot_type == WeaponTypes.Release
			{
				
			}
		}
		
		
	}
	
}


enum WeaponTypes
{
	Normal,
	Release,
	Hold,
	Special,
	Melee
}

globalvar weapon_profiles;
weapon_profiles = 
{
	standart_gun :
	{
		sprite : sStandartGun,
		damage : 1,
		
		ammo_cost : 1,
		cooldown : 1,
		
		shoot_type : WeaponTypes.Normal,
		
		
	},
	burst_gun : 
	{
		sprite : sShotgun,
		damage : 1,
		ammo_cost : 1,
		cooldown : 1,
		shoot_type : WeaponTypes.Normal,
		shoot_func : function()
		{
			
			
		},
		refire_func : function()
		{
			
		},
	}
}
