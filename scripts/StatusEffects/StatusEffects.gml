// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function ApplyStatusEffect(_target, _effect_profile, _duration)
{
	if (_target == undefined) return;
	if (!object_is_ancestor(_target.object_index, oEnemyParent)) return;
	
	var _effect
	
	if (struct_exists(_target.status_effects, _effect_profile.id))
	{
		_effect = struct_get(_target.status_effects, _effect_profile.id);
		_effect.time_remaining = _duration
	}
	else
	{
		var _time = floor((current_time / 1000) * 60)
		_effect = 
		{
			time_remaining : _duration,
			time_applied : _time,
			profile : _effect_profile
		}
		struct_set(_target.status_effects, _effect_profile.id, _effect);
	}
}

globalvar status_effects_profiles;

status_effects_profiles = 
{
	burn : 
	{
		update : function(_host, _time_applied, _time_remaining)
		{
			var _time = floor((current_time / 1000) * 60)
			var _time_diff = _time - _time_applied;
			if (_time_diff % 1000 == 0)
			{
				_host.hp -= 1;
			}
		},
		draw : function(_host)
		{
			draw_sprite(sFire, current_time / 60, _host.x, _host.y);
		}
	}
}

ProfileStructSetIDs(status_effects_profiles);