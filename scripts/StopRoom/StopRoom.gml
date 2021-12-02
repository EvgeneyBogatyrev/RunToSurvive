function StopRoom() {
	with (oRoomControl)
	{
		if (roomspeed == 0)  return;
		saved_speed = roomspeed;
		roomspeed = 0;
	}


}
