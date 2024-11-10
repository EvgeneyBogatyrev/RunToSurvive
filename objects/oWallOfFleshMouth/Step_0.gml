
xspeed = (-oRoomControl.roomspeed + 1);
if (x < oCamera.left - 100)
{
	x = oCamera.left - 50;	
}
event_inherited();

hp = 1;


leech_spawn_timer--;
if (leech_spawn_timer <= 0)
{
	leech_spawn_timer = leech_spawn_timer_max;

	with(Create(x, y, oWallOfFleshLeech, row))
	{
		depth = other.depth - 1;
		walkspeed = 10;
	}
}
