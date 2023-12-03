event_inherited();

notice_player = PlayerVisible;

walkspeed = irandom_range(1, 3);
walk_timer = irandom_range(25, 75);

action_timer = 0;
action_timer_max = 40;

arrow_speed = 17;
shoot_index = 5;

hp = irandom_range(5, 8);
maxhp = hp;
shown_hp = hp;

already_attacked = false;