/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (abs(shown_hp - cum_hp) >= 1)	
	shown_hp = ApproachTo(shown_hp, cum_hp);

if (state == UniversalStates.DEAD && !loot_dropped)
{
	var loot_profile_id = loot_profile_ids[random_range(0, len(loot_profile_ids) - 1)];
	if (loot_profile_id != -1)
	{
		with (Create(x, y - 50, oBossLoot, row))
		{
			depth -= 2;
			profile = passive_items_profiles[loot_profile_id];
		}
	}
	
	loot_dropped = true;
}