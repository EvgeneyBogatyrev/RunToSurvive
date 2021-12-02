event_inherited();

walkspeed_charged = irandom_range(3, 5);
walkspeed_normal = walkspeed_charged - 2;
xspeed = -walkspeed_normal;
walkspeed = walkspeed_normal;
walk_timer = irandom_range(25, 75);

retrieve = false;
retrieve_counter = 0;
retrieve_counter_max = 60;

hp = irandom_range(8, 12);
maxhp = hp;
shown_hp = hp;

notice_player = PlayerNear;