/// @description 
event_inherited();

hp = irandom_range(15, 25);
maxhp = hp;
shown_hp = hp;

walkspeed = choose(2, 3, 4);
xspeed = -walkspeed;

saved_player = noone;
state = HalfBossStates.IDLE;

notice_player = ReturnNoone;