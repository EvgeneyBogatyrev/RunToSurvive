///@desc PlayerSprite()
function PlayerSprite() {

	if (state == UniversalStates.DEAD) exit;

	if (grounded || state == PlayerStates.TRAPPED)
	{
		if (abs(xspeed) > 1)
		{
			image_speed = 1;
			sprite_index = character.sprites.run;
			idlecounter = 60;
		}
		else 
		{	
			sprite_index = character.sprites.idle;
			idlecounter--;
			if (idlecounter < 0)  
				image_speed = 1;
			else
			{
				image_index = 0;
				image_speed = 0;
			}
		}
	
	}
	else
	{
		sprite_index = character.sprites.jump;
		if (yspeed > 0)  image_index = 1;
		else             image_index = 0;
	}


}
