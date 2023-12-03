event_inherited();


phase = get_timer();
state = ItemDropStates.SPIN;

index = 0;

player_id = noone;

ysp = -7;

StopRoom();
with (oRoomControl) block_score = true;