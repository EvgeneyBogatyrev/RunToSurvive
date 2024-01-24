PlayerBuffs();

bullets = BoundBetween(bullets, 0, maxbullets);
hp      = BoundBetween(hp, 0, maxhp);

shown_bullets = ApproachTo(shown_bullets, floor(bullets));
shown_hp      = ApproachTo(shown_hp, floor(hp));

switch (state)
{
	case PlayerStates.NORMAL:
		PlayerControl();
		break;
		
	case PlayerStates.TRAPPED:
		PlayerControl();
		_left =  false;
		_right =  false;
		_up =  false;
		_down =  false;
		_shoot =  false;
		_shoot_hold = false;
		break;
	
	case UniversalStates.DEAD:
	
		if (death_alpha <= 0)
		{
			var _flag_dead = true;
			if (instance_number(object_index) > 1)  with (oPlayer) 
			{ 
				if (id != other.id) 
				{ 
					if (state != UniversalStates.DEAD)  
					{
						_flag_dead = false; 
						break;
					}
				} 
			}
			if (_flag_dead)  LevelEnd();
			instance_destroy();
		}
		else
		{
			death_alpha -= 0.02;
		}
		/*
		if (name == "Robo")
		{
			var _flag = true;
			for (var i = 1; i < 6; ++i)
			{
				if (instance_exists(body_parts[i]) && body_parts[i].image_alpha > 0)
				{
					_flag = false;
					break;
				}
			}
			
			if (_flag)
			{
			
				for (var i = 1; i < 6; ++i)  instance_destroy(body_parts[i]);
				
				var _flag_dead = true;
				if (instance_number(object_index) > 1)  with (oPlayer) 
				{ 
					if (id != other.id) 
					{ 
						if (state != UniversalStates.DEAD)  
						{
							_flag_dead = false; 
							break;
						}
					} 
				} 
				else  LevelEnd();
				if (_flag_dead)  LevelEnd();
				else             instance_destroy();
			}
		}
	
		else if (AnimationEnd()) 
		{ 
			var _flag_dead = true;
			if (instance_number(object_index) > 1)  with (oPlayer) 
			{ 
				if (id != other.id) 
				{ 
					if (state != UniversalStates.DEAD)  
					{
						_flag_dead = false; 
						break;
					}
				} 
			} 
			else  LevelEnd();
			if (_flag_dead)  LevelEnd();
			else             instance_destroy();
		}
		*/
		_left =  false;
		_right =  false;
		_up =  false;
		_down =  false;
		_shoot =  false;
		_jump = false;
		_shoot_hold = false;
		break;
	
	case PlayerStates.NON_CONTROL:
		PlayerSprite();
		break;
	
	default:
		Raise("Invalid player state\n");
		break;
}

if (state != PlayerStates.NON_CONTROL)
{
	PlayerMove();
	PlayerCheckDying();
	PlayerSprite();
}

if (damaged)
{
	damage_timer--;	
	if (damage_timer <= 0)  damaged = false;
}

if (knockback_timer > 0) knockback_timer--;
else	                 knockbacked = false;	


event_inherited();

//if (state == UniversalStates.DEAD && name == "Robo")  image_alpha = 0;

if (global.DEBUG)
{
	if (keyboard_check_pressed(ord("G")))
	{
		GiveItemToPlayer(id, passive_items_profiles[irandom(3)]);
		//CreateOrbital(id, 3, 32, oSuspiciousEye);
	}

	if (keyboard_check_pressed(ord("I")))
	{
		hp -= 1;
		if (array_length(connected_orbitals) > 0) instance_destroy(connected_orbitals[0]);
	}

	if (keyboard_check_pressed(ord("O")))
	{
		hp -= 10;
	}
}
