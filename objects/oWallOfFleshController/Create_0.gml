/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

// Inherit the parent event
event_inherited();

hp = 10;
cum_hp = 10;
cum_hp_max = 10;
maxhp = 10;


further_eye = undefined;

for (var _row = 0; _row < 3; ++_row)
{
	if (_row == 1)
	{
		with (Create(0, oGenerator.ground[_row], oWallOfFleshMouth, _row))
		{
			depth += 1;	
		}
	}
	else
	{
		with (Create(0, oGenerator.ground[_row], oWallOfFleshEye, _row))
		{
			depth -= 4;
			if row == 0 other.further_eye = id;
		}
	}
}

StopRoom();