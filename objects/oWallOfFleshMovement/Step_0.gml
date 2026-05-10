
if (instance_exists(oWallOfFleshController) && (oWallOfFleshController.state == UniversalStates.DEAD || oWallOfFleshController.state == UniversalStates.VICTORY))
{
	x -= slide_back_speed;	
}
else
{
	if (CheckCollisions(x + 120, y, oSolidParent, row))
	{
		y -= 2;
		moving_down_counter = moving_down_counter_max;
	}

	moving_down_counter--;

	if (moving_down_counter <= 0 && !CheckCollisions(x, y + 1, oSolidParent, row))
	{
		y += 1;	
	}
}

// Knockback player

for (var _i = 0; _i < instance_number(oPlayer); ++_i)
{
	var _player = instance_find(oPlayer, _i);	
	
	if (_player.x < x + 30 * scale)
	{
		if (!_player.damaged)
		{
			DamageSpecificPlayer(_player, contact_damage, false, "the Wall of Flesh");
		}
		
		
		KnockbackForce(_player, 15*scale, -15*scale);	
		
	}
}

event_inherited();

