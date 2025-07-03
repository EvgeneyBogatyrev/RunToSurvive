/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

// Inherit the parent event
event_inherited();

hp = 5 + floor(oDifficultyController.minions_defeated * GetStats("Increase hp") / 5);
damage = GetStats("SpamtonClone")

movement_speed = 4;
can_be_knockbacked = true;
lerp_speed = 0.2;

/*
1) Создаем переменную movement_speed <- записываем именно модуль
1.5) В Create создаем current_absolute_speed - в нее записываем текущий модуль скорости
2) При создании (with(Create(...)) меняем на movement_speed
3) В Step делаем
	- current_absolute_speed = abs(xspeed);
	- var _direction = sign(xspeed);
	- current_absolute_speed = lerp(current_absolute_speed, movement_speed, step);
	- xspeed = _direction * current_absolute_speed;
*/