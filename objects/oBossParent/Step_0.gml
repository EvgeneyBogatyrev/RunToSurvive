/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var _shown_hp_target = max(0, cum_hp);
if (abs(shown_hp - _shown_hp_target) >= 1)
	shown_hp = ApproachTo(shown_hp, _shown_hp_target);

if (state == UniversalStates.DEAD && !loot_dropped)
{
	var loot_profile_id = loot_profile_ids[irandom_range(0, len(loot_profile_ids) - 1)];
	if (loot_profile_id != -1)
	{
		var _loot_row = row;
		var _loot_player = GetPlayer(PlayerPreferences.CLOSEST);
		if (instance_exists(_loot_player))
		{
			_loot_row = _loot_player.row;
		}
		_loot_row = floor(BoundBetween(_loot_row, 0, 2));

		var _loot_x = BoundBetween(x, oCamera.left + CAMERA_BOUNDS, oCamera.right - CAMERA_BOUNDS);
		var _loot_y = min(y - 50, oGenerator.ground[_loot_row] - 120 * GetScale(_loot_row));

		with (Create(_loot_x, _loot_y, oBossLoot, _loot_row))
		{
			depth -= 2;
			profile = passive_items_profiles[loot_profile_id];
		}
	}
	GetStandartRoomProperties();
	ChangeBackgrounds()
	loot_dropped = true;
}
