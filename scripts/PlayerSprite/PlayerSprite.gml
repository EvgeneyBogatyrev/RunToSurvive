///@desc PlayerSprite()
function PlayerSprite() {

	if (state == UniversalStates.DEAD) exit;

	if (grounded)
	{
		if (abs(xspeed) > 1)
		{
			sprite_index = character.sprites.run;
			idlecounter = 60;
		}
		else 
		{	
			idlecounter--;
			if (idlecounter < 0)  sprite_index = character.sprites.idle;
			else				  sprite_index = character.sprites.stand;
		}
	
	}
	else
	{
		sprite_index = character.sprites.jump;
		if (yspeed > 0)  image_index = 1;
		else             image_index = 0;
	}


}
