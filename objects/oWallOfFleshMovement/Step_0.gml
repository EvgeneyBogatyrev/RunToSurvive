
if (CheckCollisions(x + 100, y, oSolidParent, row))
{
	y -= 2;
	moving_down_counter = moving_down_counter_max;
}

moving_down_counter--;

if (moving_down_counter <= 0 && !CheckCollisions(x, y + 1, oSolidParent, row))
{
	y += 1;	
}

for (var _h = 0; _h < 500; _h += 50)
{
	while (CheckCollisions(x - 50, y + _h, oSolidParent, row))
	{
		with (GetCollider(x - 50, y + _h, oSolidParent, row))
		{
			instance_destroy();	
		}
	}
}

event_inherited();

