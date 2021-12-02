///@desc PlayerSprite()
function PlayerSprite() {

	if (state == UniversalStates.DEAD) exit;

	if (grounded)
	{
		if (abs(xspeed) > 1)
		{
			sprite_index = sPlayerRun;
			idlecounter = 60;
		}
		else 
		{	
			idlecounter--;
			if (idlecounter < 0)  sprite_index = sPlayerIdle;
			else				  sprite_index = sPlayerStand;
		}
	
	}
	else
	{
		sprite_index = sPlayerJump;
		if (yspeed > 0)  image_index = 1;
		else             image_index = 0;
	}


}
