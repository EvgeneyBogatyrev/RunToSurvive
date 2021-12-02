/// @description

Print(y);

switch (state)
{
	case UniversalStates.INTRO:
		hp = maxhp;
		image_index = 2;
		
		xspeed = -0.0001;
		
		while (CheckCollisions(x, y, oBlock, row))  y--;
		
		if (x < oCamera.right - CAMERA_BOUNDS)  
		{
			StopRoom();
			with (oCamera)  follow = other.object_index;	
		}
		
		intro_timer--;
		if (intro_timer == 0)
		{
			ResumeRoom();
			state = ChasingStumpState.CHASE;
			with (oCamera)  follow = oPlayer;	
			exit;
		}
		
		break;
		
	case ChasingStumpState.CHASE:
		
		if (CheckCollisions(x, y - 1, oBlock, row))  DamagePlayer(30, 0);
		
		target = GetPlayer(PlayerPreferences.CLOSEST);
		
		if (target == noone || !instance_exists(target))
		{
			state = ChasingStumpState.VICTORY;
			exit;
		}
		
		xspeed = walkspeed * sign(target.x - x);
		
		
		break;
		
	default:
		instance_destroy();
}

if (state != ChasingStumpState.VICTORY && state != UniversalStates.INTRO)
{
	if ((CheckCollisions(x + xspeed * scale, y, oBlock, row)  || row != target.row) && CheckCollisions(x, y + 1, oBlock, row))
	{
		yspeed -= jumpspeed * scale;
	}
	
	if (row != target.row)
	{
		var _saved_scale = scale;
		image_xscale = sign(xspeed) * GetScale(row + sign(target.row - row));
		image_yscale = abs(image_xscale);
		
		if (!CheckCollisions(x, y, oBlock, row + sign(target.row - row)))
		{
			row += sign(target.row - row);
			scale = image_yscale;
		}
		else
		{
			image_xscale = sign(xspeed) * _saved_scale;
			image_yscale = _saved_scale;
		}
	}
}


if (CheckCollisions(x + xspeed * scale, y, oBlock, row))
{
	repeat (abs(xspeed * scale))
	{
		if (CheckCollisions(x + sign(xspeed), y, oBlock, row))  break;
		x += sign(xspeed);
	}
	xspeed = 0;
}

yspeed -= grav;

if (CheckCollisions(x, y + yspeed * scale, oBlock, row))
{
	repeat (abs(yspeed * scale))
	{
		if (CheckCollisions(x, y + sign(yspeed), oBlock, row))  break;
		y += sign(yspeed);
	}
	yspeed = 0;
}


event_inherited();


