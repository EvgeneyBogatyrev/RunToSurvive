// Inherit the parent event



if (last_inflictor != undefined && instance_exists(last_inflictor) && last_inflictor.state != UniversalStates.DEAD && state == UniversalStates.DEAD && !on_kill_events_done)
{
	on_kill_events_done = true;
	
	
	var _events = last_inflictor.onKillEvent;
	Print(len(_events));
	for (var i = 0; i < array_length(_events); i++)
	{
		_events[i](id, last_inflictor);
	}
}

if (wildvines_timer > 0)
{
	
	if (wildvines_timer % game_get_speed(gamespeed_fps) == 0)
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


var _effect_names = struct_get_names(status_effects)

for (var _i = 0; _i < len(_effect_names); _i++)
{
	var _effect = struct_get(status_effects, _effect_names[_i]);
	if (_effect.time_remaining <= 0)
	{
		struct_remove(status_effects, _effect_names[_i]);
		_i--;
		continue;
	}
	
	_effect.profile.update(id, _effect.time_applied, _effect.time_remaining);
	
	_effect.time_remaining -= 1;
	
}

event_inherited();


if (on_fire > 0)
{
	if (on_fire % game_get_speed(gamespeed_fps) == 0)
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


