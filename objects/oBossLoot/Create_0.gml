event_inherited();


phase = get_timer();
state = ItemDropStates.SPIN;

profile = undefined;

player_ind = noone;

ysp = -15;
xspeed = (oCamera.x - x) / 50;
destination_x = oCamera.x;
destination_threshold = 5;

StopRoom();
with (oRoomControl) block_score = true;
oRoomControl.gamestate = GameState.NORMAL;