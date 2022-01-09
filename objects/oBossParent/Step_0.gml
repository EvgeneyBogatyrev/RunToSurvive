/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (abs(shown_hp - cum_hp) >= 1)	
	shown_hp = ApproachTo(shown_hp, cum_hp);

