event_inherited();


phase = get_timer();
state = ItemDropStates.SPIN;

profile = undefined;

player_ind = noone;

ysp = -15;
destination_x = oCamera.x;
destination_threshold = 5;
xspeed = BoundBetween((destination_x - x) / 50, -6, 6);
destination_ready = false;
stuck_timer = 0;

StopRoom();
with (oRoomControl) block_score = true;
