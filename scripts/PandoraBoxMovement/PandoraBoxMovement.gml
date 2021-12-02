function PandoraBoxMovement(argument0) {
	y = argument0 + sin((get_timer() - phase) / 250000) * magnitude;

		
	if (x < oCamera.right - room_width / 2)  xspeed = (flyspeed - oRoomControl.roomspeed) * GetScale(row);
	else if (x > oCamera.right - 100)        xspeed = -oRoomControl.roomspeed * GetScale(row);



}
