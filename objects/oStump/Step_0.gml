event_inherited();

switch(state)
{
	
	case HalfBossStates.TRIGGERED:	
		
		var _dist = player.x - x;
		
		if (abs(_dist) < 4 && player.grounded) 
		{
			retrieve = true;
			retrieve_counter = retrieve_counter_max;
		}
		
		var _new_x = x + sign(_dist) * walkspeed_charged * scale * (retrieve ? -1 : 1);
		
		if (!CheckCollisions(_new_x, y, oSolidParent, row))  
		{
			xspeed = sign(_dist) * walkspeed_charged * (retrieve ? -1 : 1);
		}
		else                                                
		{
			xspeed = -sign(_dist) * walkspeed_charged * (retrieve ? -1 : 1); 
			retrieve = false; 
		}
		
		
		if (_new_x < oCamera.left || _new_x > oCamera.right ) retrieve = false;
		
		if (retrieve)
		{
			retrieve_counter--;
			if (retrieve_counter == 0)	retrieve = false;
		}
			
			
		break;
	case HalfBossStates.IDLE:
		sprite_index = sStumpRun;
		retrieve = false;
		
		if (xspeed == 0 || walk_timer <= 0) 
		{
			xspeed = choose(-1, 1) * walkspeed_normal;
			walk_timer = irandom_range(25, 150);
		} 
		else  walk_timer--;	
		
		if (CheckCollisions(x + xspeed, y, oSolidParent, row))  xspeed = -dir * walkspeed_normal;	
		
		break;
		
	case UniversalStates.DEAD:
		sprite_index = sStumpDying;
		xspeed = 0;
		break;

	default:
		break;
}

if (state != UniversalStates.DEAD && state != HalfBossStates.INACTIVE && ContactDamage(damage, 0))
{
	StartBattle(row, player, id);
	retrieve = true;
	retrieve_counter = retrieve_counter_max;
}


