/// @description

switch (state)
{
	case UniversalStates.INTRO:
		
		PandoraBoxMovement(ystart);
		
		maxhp = box_hp;
		hp = maxhp;
		cum_hp = cum_hp_max;
		
		intro_timer--;
		if (intro_timer == 0)   
		{
			sprite_index = sPandoraBoxSpawn;
			image_index = 0;
		}
		
		if (sprite_index == sPandoraBoxSpawn && image_index + image_speed >= spawn_frame && instance_number(oFloatingEye) == 0)
		{
			for (var _row = 0; _row < spawn_intro; ++_row)
			{
				with (Create(x, y, oFloatingEye, min(_row, 3)))
				{
					direction = 180 / (other.spawn_intro + 1) * (_row + 1);
				}
			}
		}
		
		if (AnimationEnd() && sprite_index == sPandoraBoxSpawn) 
		{
			state = PandoraStates.BOX;
			sprite_index = sPandoraBoxBlink;
		}
		

		break;
		
	case PandoraStates.BOX:
		//Move
		PandoraBoxMovement(ystart);
		//ContactDamage(10, 0);
		
		//Spawn eye
		if (spawn_timer == 0)
		{
			if (sprite_index == sPandoraBoxBlink && instance_number(oFloatingEye) < eyes_amount)  sprite_index = sPandoraBoxSpawn;
		}
		else spawn_timer--;
		
		if (sprite_index == sPandoraBoxSpawn && image_index + image_speed >= spawn_frame && spawn_timer == 0)
		{
			spawn_timer = spawn_timer_max;
			
			if (instance_exists(oPlayer))
			{
				var _player = instance_find(oPlayer, 0);
				with(Create(x, y, oFloatingEye, _player.row))  depth -= 1;	
			}
		}
		if (AnimationEnd() && sprite_index == sPandoraBoxSpawn)  sprite_index = sPandoraBoxBlink;
		
		//Change state
		if (hp <= 0)
		{
			maxhp = gauntlet_hp;
			hp = maxhp;
			cum_hp = gauntlet_hp + eye_hp;
			state = PandoraStates.GAUNTLET;
			xspeed = 0;
			designation = -1;
			dir = -1;
		}
		
		break;
		
	case PandoraStates.GAUNTLET:
		if (ContactDamage(damage, 0))  Knockback(oPlayer, 2);
		
		//Rotation
		if (sprite_index == sPandoraBoxBlink &&  image_angle < 90) 
		{
			image_angle += 5;
			dir = -1;
			exit;
		}
		else
		{
			image_angle = 0;
			sprite_index = sPandoraGauntlet;
		}
		
		yspeed = 0;
		
		if (x > oCamera.right + CAMERA_BOUNDS || x < oCamera.left - CAMERA_BOUNDS)
		{
			if (!direction_changed)
			{
				designation *= -1;
				row = choose(0, 1, 2);
				scale = GetScale(row, true);
				y = oGenerator.ground[row] - y_offset * scale;
				direction_changed = true;
				
				if (spawn_counter == 0 && instance_number(oFloatingEye) < eyes_amount)
				{
					Create(x, y, oFloatingEye, row);
					spawn_counter = spawn_counter_max;
				}
				else spawn_counter--;
			}
		}
		else  direction_changed = false;
		
		xspeed = lerp(xspeed, gauntlet_speed * designation, acceleration);		
		
		if (hp <= 0)
		{
			image_index = 0;
			sprite_index = sPandoraTransform;
			state = PandoraStates.EYE;
			x = oCamera.x;
			y = 200;
			row = 0;
			scale = GetScale(row, true);
			maxhp = eye_hp;
			hp = maxhp;
			cum_hp = eye_hp;
		}
		
		break;
	
	case PandoraStates.EYE:
		PandoraBoxMovement(200);
			
		if (sprite_index == sPandoraTransform && AnimationEnd())
		{
			sprite_index = sPandoraEye;
			image_index = 1;
			start = true;
		}
		
		if (start)
		{
			
			while (instance_number(oFloatingEye) < eye_spawn_counter)
			{
				var _row = choose(0, 1, 2);
				Create(x, y, oFloatingEye, _row);
			}
			
			alive_timer--;
			hp -= 1 / alive_timer_max * eye_hp;			
			cum_hp -= 1 / alive_timer_max * eye_hp;

		}
		
		if (hp <= 0 || alive_timer == 0)
		{
			global.score += 80;
			state = UniversalStates.DEAD;
			with (oFloatingEye) 
			{
				image_index = 0;
				sprite_index = sFloatingEyeDie;
				state = UniversalStates.DEAD;
			}
			ShakeScreen(12, 120);
		}
		
		break;
		
	case UniversalStates.DEAD:
		//Add Animation FIX!
 		oRoomControl.gamestate = GameState.LOOT;
		GetStandartRoomProperties();
		instance_destroy();		
		break;
	
		
}

event_inherited();

if (state == PandoraStates.EYE)
{
	var _scale = GetScale(row) * (alive_timer + 100) / (alive_timer_max + 100);	
	image_xscale = _scale;
	image_yscale = _scale;
}