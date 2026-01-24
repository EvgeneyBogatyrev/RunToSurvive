PlayerBuffs();

bullets = BoundBetween(bullets, 0, maxbullets);
hp      = BoundBetween(hp, 0, maxhp);

shown_bullets = ApproachTo(shown_bullets, floor(bullets));
shown_hp      = ApproachTo(shown_hp, floor(hp));

if (y > oGenerator.ground[2] + 100)
{
	hp = -100;	
}

switch (state)
{
	case PlayerStates.NORMAL:
		PlayerControl();
		if (force_down > 0)
		{
			// Tumble from GunMan Drone
			if (row == 0)	
			{
				_down = true;
			}
			_left = false;
			_right = false;
			_up = false;
			force_down--;
		}
		if (_shoot && instance_exists(gun))       gun.shoot = true;
		if (_shoot_hold && instance_exists(gun))  gun.shoot_hold = true;
		
		PlayerSprite();
		PlayerCheckDying();
		PlayerMove();
		
		break;
	
	case PlayerStates.KNOCKBACKED:
		PlayerControl();
		if (_left || _right)
		{
			state = PlayerStates.NORMAL;
		}
		
		
	case PlayerStates.TRAPPED:
		PlayerControl();
		// Disallow everything except left and right
		_up =  false;
		_down =  false;
		_shoot =  false;
		_shoot_hold = false;
		_jump = false;

		yspeed = 0;
		xspeed = sign(_right - _left) * walkspeed;
		dir = sign(xspeed) != 0 ? sign(xspeed) : dir;
		//PlayerMove()
		row_der = 0;
		row = 0;
		PlayerSprite();
		xspeed = 0;
		//;
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
		_left =  false;
		_right =  false;
		_up =  false;
		_down =  false;
		_shoot =  false;
		_jump = false;
		_shoot_hold = false;
		
		PlayerMove();
		PlayerSprite();
		break;
	
	case PlayerStates.NON_CONTROL:
		
		if (knockbacked)
		{
			PlayerControl();
			PlayerCheckDying();
			var _xspeed = xspeed;
	
			var _move = _right - _left;
			dir = (_move != 0) ? sign(_move) : dir;
	
			_left =  false;
			_right =  false;
			_up =  false;
			_down =  false;
			_jump = false;
	
			PlayerMove();
	
			xspeed = _xspeed;
	
			if (_shoot && instance_exists(gun))       gun.shoot = true;
			if (_shoot_hold && instance_exists(gun))  gun.shoot_hold = true;
		}
		PlayerSprite();
		PlayerCheckDying();
		break;
	
	default:
		Raise("Invalid player state\n");
		break;
}

if (damaged)
{
	damage_timer--;	
	if (damage_timer <= 0)  damaged = false;
}


event_inherited();

// Debug stuff
if (global.DEBUG)
{
	if (keyboard_check_pressed(ord("G")))
	{
		GiveItemToPlayer(id, passive_items_profiles[irandom_range(0, array_length(passive_items_profiles) - 1) ]);
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
