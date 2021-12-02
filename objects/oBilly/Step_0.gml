/// @description 
event_inherited();

switch (state)
{
	case HalfBossStates.IDLE:
		if (sprite_index == sBillyWalk)
		{
			if (CheckCollisions(x + xspeed * scale, y, oSolidParent, row))  xspeed = -dir * walkspeed;
			else															xspeed = dir * walkspeed;
			
			if (oRoomControl.gamestate == GameState.BATTLE)// && oRoomControl.opponent == id)
			{
				if (x < oCamera.left)  xspeed = walkspeed;	
				else if (x > oCamera.right)  xspeed = -walkspeed;
			}
		
			var _player = GetCollider(x, y, oPlayer, row);
			if (_player != noone && !_player.damaged)
			{
				sprite_index = sBillyAttack;
				image_index = 0;
				if (DamagePlayer(25, 0))  StartBattle(row, _player, id);
				with (_player)
				{	
					if (pocket[0] < 2 && pocket[1] < 2)  exit;
					
					var _penetrate_index = choose(0, 1);
					while (!pocket[_penetrate_index] || pocket[_penetrate_index] == STDGUN_INUMBER)  _penetrate_index = choose(0, 1);
					
					if (_penetrate_index == 0)  pocket[_penetrate_index] = STDGUN_INUMBER;
					else                        pocket[_penetrate_index] = 0;
					
					if (active_pocket_index == _penetrate_index)
					{
						if (gun.current_gun != Gun.DRILL)  gun.current_gun = Gun.STANDART_GUN;
						else							   gun.last_gun = Gun.STANDART_GUN;
					}
					
				}
			}
		}
		else 
		{
			xspeed = 0;	
			if (saved_player != noone)  dir = abs(saved_player.x - x);
			if (AnimationEnd())
			{
				sprite_index = sBillyWalk;
				image_index = 0;
				saved_player = noone;
			}
		}
			
		break;
		
	case UniversalStates.DEAD:
		sprite_index = sStumpDying;
		xspeed = 0;
		break;

	default:
		break;
}

