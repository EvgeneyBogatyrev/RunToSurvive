/// @description

if (shown_hp != hp)  healthbar_alpha = 1;
shown_hp = ApproachTo(shown_hp, hp);

switch (state)
{
	case UniversalStates.INTRO:
		hp = maxhp;
		image_index = 1;
		
		xspeed = -0.0001;
		dir = -1;
		
		while (CheckCollisions(x, y, oBlock, row))  y--;
		
		if (x < oCamera.right - CAMERA_BOUNDS)  
		{
			StopRoom();
			with (oCamera)  follow = other.object_index;	
		}
		
		intro_timer--;
		if (intro_timer <= 0)
		{
			first_phase_timer = first_phase_timer_max;
			ResumeRoom();
			state = ChasingStumpState.CHASE;
			with (oCamera)  follow = oPlayer;	
			exit;
		}
		
		break;
		
	case ChasingStumpState.CHASE:
		
		if (CheckCollisions(x, y + 1, oBlock, row))  ContactDamage(damage, 0);
		
		target = GetPlayer(PlayerPreferences.CLOSEST);
		
		if (target == noone || !instance_exists(target))
		{
			state = UniversalStates.VICTORY;
			exit;
		}
		if (current_speed != slowspeed)
		{
			if (fast_timer == 0) 
			{ 
				current_speed = walkspeed;
			}
			else
			{
				current_speed = fastspeed;
				fast_timer--;
			}
		
			if (x < oCamera.left - 30)
			{
				fast_timer = fast_timer_max;	
			}
			if (x < oCamera.left - 40)
			{
				x = oCamera.left - 40;	
			}
		}
			
		
		if (abs(target.x - x) > 180)
			xspeed = current_speed * sign(target.x - x);
		else if (abs(target.x - x) < 20 && abs(target.y - y) < 30)
			xspeed = -current_speed * sign(target.x - x);
		else if (abs(xspeed) < 1)
			xspeed = current_speed * sign(target.x - x);
		
		
		break;
	case UniversalStates.VICTORY:
		xspeed = -walkspeed;
		break;
		
	case UniversalStates.DEAD:
		xspeed = 0;
		if (AnimationEnd())
		{
			image_speed = 0;
		}
		if (x < oCamera.left - CAMERA_BOUNDS)
		{
			instance_destroy();	
		}
		break;
		
	default:
		break;
}
first_phase_timer--;
if (first_phase_timer < 0)	first_phase_timer = -1;
if (state != UniversalStates.VICTORY && state != UniversalStates.INTRO && state != UniversalStates.DEAD)
{
	if ((CheckCollisions(x + xspeed * sign(scale), y, oBlock, row)  || row != target.row) && CheckCollisions(x, y + 1, oBlock, row))
	{
		yspeed = -jumpspeed * sign(scale);
	}
	
	if (row != target.row)
	{
		var _saved_scale = sign(scale);
		image_xscale = sign(xspeed) * GetScale(row + sign(target.row - row));
		image_yscale = abs(image_xscale);
		
		if (!CheckCollisions(x, y, oBlock, row + sign(target.row - row)))
		{
			row += sign(target.row - row);
			scale = image_yscale;
			image_xscale = sign(xspeed) * GetScale(row, true);
		}
		else
		{
			image_xscale = sign(xspeed) * _saved_scale;
			image_yscale = _saved_scale;
		}
	}
	
	if (hp <= 0)
	{
		if (!not_give_score) global.score += 200;
		sprite_index = sStumpBossDying;
		state = UniversalStates.DEAD;
		if (first_phase_timer > 0) first_phase_timer = 0;
		with (Create(x, y, oItemDrop, row))
		{
			depth -= 2;
			image = choose(HEARTH_INUMBER, BATTERY_INUMBER); //FIX! Give better loot
		}
	}
}


if (CheckCollisions(x + xspeed * sign(scale), y, oBlock, row))
{
	repeat (abs(xspeed * sign(scale)))
	{
		if (CheckCollisions(x + sign(xspeed), y, oBlock, row))  break;
		x += sign(xspeed);
	}
	xspeed = 0;
}

yspeed -= grav;

if (CheckCollisions(x, y + yspeed * scale, oBlock, row) && yspeed >= 0)
{
	repeat (abs(yspeed * scale))
	{
		if (CheckCollisions(x, y + sign(yspeed), oBlock, row))  break;
		y += sign(yspeed);
	}
	yspeed = 0;
}


if (first_phase_timer <= first_phase_timer_max / 2 && !instance_exists(oWildvineController) && oRoomControl.gamestate == GameState.BOSS)
{
	Create(x, y, oWildvineController, 0);
	
}

if (first_phase_timer == first_phase_timer_max / 4)
{
	ds_map_replace(oRoomControl.room_properties, "ForbiddenObstacles", [0, 1, 0, 1, 1, 0]);
}

if (first_phase_timer == 0/* || (first_phase_timer > 0 && hp <= 0)*/)
{
	with (Create(oCamera.right + CAMERA_BOUNDS, oGenerator.ground[1], oStumpTree, 1))  
	{
		depth -= 4;
		with (GetCollider(x, y, oObstacle, 1))
		{
			instance_destroy();	
		}
	}
	current_speed = slowspeed;
}



event_inherited();


