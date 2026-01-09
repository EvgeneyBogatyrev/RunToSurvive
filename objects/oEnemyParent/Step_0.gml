// Inherit the parent event
var _player = noone;
for (var i = 0; i < instance_number(oPlayer); ++i)
{
	var _tmp = instance_find(oPlayer, i);
	if (_tmp.pocket[1] == REFRACTOR_INUMBER)
	{
		_player = _tmp;
		break;
	}
}
if (_player != noone && hp <= 0 && _player.pocket[1] == REFRACTOR_INUMBER && !refreshed)
{
	_player.hp += 5;
	_player.bullets += 3;
	refreshed = true;
}

if (wildvines_timer > 0)
{
	
	if (wildvines_timer % 60 == 0)
	{
		hp -= 3;
		if object_is_ancestor(object_index, oBossParent)
		{
			cum_hp -= 3;	
		}
		with(Create(x, y - 50, oDamageNumber, row))
		{
			damage = 3;
			depth = other.depth - 2;
		}
		hit_flash = 3;
	}
	
	if !object_is_ancestor(object_index, oBossParent)
	{
		xspeed = 0;
		yspeed = 0;
	}
	
	wildvines_timer -= 1;
}


event_inherited();


if (on_fire > 0)
{
	if (on_fire % 60 == 0)
	{
		hp -= 1;
		if object_is_ancestor(object_index, oBossParent)
		{
			cum_hp -= 1;	
		}
		with(Create(x, y - 50, oDamageNumber, row))
		{
			damage = 1;
			depth = other.depth - 2;
		}
		hit_flash = 3;
	}
	on_fire -= 1;
}


