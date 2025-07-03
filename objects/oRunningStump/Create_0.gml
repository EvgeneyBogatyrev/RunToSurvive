/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

hp = 1 + floor(oDifficultyController.minions_defeated * GetStats("Increase hp") / 5);

draw_alpha = 1;

state = 1;

given = false;

damage = GetStats("Running stump");

can_be_knockbacked = true;
