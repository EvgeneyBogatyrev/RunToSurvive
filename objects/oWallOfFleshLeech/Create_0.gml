/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

// Inherit the parent event
event_inherited();

start_time = get_timer();
timescale = 1/100000;
magnitude = 15;

hp = 3 + floor(oDifficultyController.minions_defeated * GetStats("Increase hp") / 5);;
damage = GetStats("WallOfFleshLeech");

real_image_aplha = 1;