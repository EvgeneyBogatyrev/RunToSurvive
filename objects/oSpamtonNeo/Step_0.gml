/// @description Insert description here
// You can write your code in this editor

//y = ystart + sin((get_timer() - phase) / 250000) * magnitude;
;

switch (state)
{
	case UniversalStates.INTRO:
		x = lerp(x, oCamera.right - CAMERA_BOUNDS / 3, 0.1);
			
		hp = maxhp;
			
		intro_timer--;
		if (intro_timer == 0)
		{
			state = SpamtonStates.HEART;	
		}
		
		break;
		
	case SpamtonStates.HEART:
		x = lerp(x, oCamera.right - CAMERA_BOUNDS / 3, 0.1);
		// Changing rows
		change_row_timer--;
		if (change_row_timer <= 0)
		{
			change_row_timer = change_row_timer_max * random_range(0.8, 1.2);
	
			var _old_row = row;
			while (_old_row == row)
				row = choose(0, 1, 2);
	
			y_to_go = oGenerator.ground[row] - 100 * GetScale(row);
			if (_old_row < row)
			{
				scale = GetScale(row, true);
			}
			else
			{
				scale = GetScale(row);
			}
		}


		y = lerp(y, y_to_go, 0.1);
		if (abs(y - y_to_go) < 3)
		{
			scale = GetScale(row, true);
		}
		
		// Heart
		if (heart_length <= heart_length_min)
		{
			var _old_angle = heart_angle;
			while (abs(_old_angle - heart_angle) < 30)
				heart_angle = irandom_range(heart_angle_min, heart_angle_max);
			increase_length = true;
		}
		
		if (increase_length)
		{
			heart_length = lerp(heart_length, heart_length_max, 0.2);
		}
		else
		{
			heart_length -= 2.5;	
		}
		
		if (heart_length >= heart_length_max - 10)
		{
			increase_length = false;
			for (var i = 0; i < 10; ++i)
			{
				var _angle;
				if (heart_angle > 180)
				{
					_angle = irandom_range(heart_angle_min, heart_angle);
				}
				else
				{
					_angle = irandom_range(heart_angle, heart_angle_max);
				}
				
				
				with (Create(x + lengthdir_x(heart_length, heart_angle), y + lengthdir_y(heart_length, heart_angle), oSpamtonShard, row))
				{
					xspeed = lengthdir_x(10, _angle);					
					yspeed = lengthdir_y(10, _angle);	
					image_angle = _angle;
				}
			}
		}
		
		
		
		break;
}




// Inherit the parent event
event_inherited();

