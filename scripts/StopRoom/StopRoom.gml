function StopRoom() {
	with (oRoomControl)
	{
		if (roomspeed == 0)  return;
		else 
		{
			saved_speed = roomspeed;
			roomspeed = 0;
		}
	}


}
