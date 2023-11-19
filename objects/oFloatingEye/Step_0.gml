/// @description

normal_speed = 1 - oRoomControl.roomspeed;
charged_speed = 4 - oRoomControl.roomspeed;

if (hp <= 0 && state != UniversalStates.DEAD)
{
	global.score += 10;
	state = UniversalStates.DEAD;
	sprite_index = sFloatingEyeDie;
	image_index = 0;
	saved_angle = image_angle;
}

switch (state)
{
	
	case EyeStates.SEEK:
		charge_counter = ApproachTo(charge_counter, 0);
		
		if (speed > normal_speed * scale)  speed -= scale;
		
		if (charge_counter == 0)
		{
			charge_counter = charge_counter_max;
			direction = 45 * irandom_range(0, 7);
			
			speed = 2 * charged_speed * scale;
		}
		
		with (oPlayer) 
		{
			if (row == other.row && state != UniversalStates.DEAD) 
			{
				other.state = EyeStates.CHASE;
				var _id = other.id
				Assert(_id != noone, "Problems with FloatingEye id\n");
				with(Create(other.x, other.y - other.sprite_height * other.scale, oAlertSign, other.row))  host = _id;
			}
		}
		
		if (y > oGenerator.ground[row] - offset)   
		{
			//y--;
			direction = 45 * irandom_range(1, 3);
		}
		if (y < offset)   
		{
			//y++;
			direction = 45 * irandom_range(5, 7);	
		}
		//while (x < oCamera.left + offset) 
		//{
		//	x++;
		//	direction = 45 * irandom_range(-1, 1);
		//}
		
		break;
		
	case UniversalStates.CHARGE_ATTACK:
	case EyeStates.CHASE:
		
		player = noone;
		for (var i = 0; i < instance_number(oPlayer); ++i)
		{
			with (instance_find(oPlayer, i))
			{
				if (row == other.row && state != UniversalStates.DEAD)
				{
					if (other.player == noone || abs(other.player.x - other.x) > abs(id.x - other.x))  other.player = id;
				}	
			}
		}
		
		if (player == noone)
		{
			state = EyeStates.SEEK;
			exit;
		}	
		
		if (ChargeAttack(player, 20, 0.5 * 60, true))  break;
		
		direction = point_direction(x, y, player.x, player.y - (player.sprite_height/2 * scale));
		speed = charged_speed * scale;
		
		break;
		
	case UniversalStates.DEAD:
		if (AnimationEnd())  instance_destroy();
		x += oRoomControl.roomspeed * scale;
		speed = 0;
		image_angle = saved_angle;
		break;

}

if (state != UniversalStates.DEAD)  if (player != noone && !player.changing_row && DamagePlayer(15, 0))  
{
	state = UniversalStates.DEAD;
	sprite_index = sFloatingEyeDie;
	image_index = 0;
	saved_angle = image_angle;
}

Scale();
image_angle = (180 + direction) % 360;
if (image_angle > 270 || image_angle < 90) 
{
	image_angle += 180;
	image_xscale *= -1;
}

if (x < oCamera.left - CAMERA_BOUNDS)  instance_destroy();




