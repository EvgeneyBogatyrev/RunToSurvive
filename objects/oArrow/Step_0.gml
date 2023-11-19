event_inherited();


if (angled)
{
		if (exhausted)			image_angle = saved_angle;	
		else if (yspeed == 0)	image_angle = 0;
		else					image_angle = darctan2(-yspeed, xspeed);
		
		if (!exhausted)			yspeed -= grav;
}
else	image_angle = 0;


if (!exhausted && CheckCollisions(x + xspeed * scale, y + yspeed * scale, oSolidParent, row)) 
{
	//while (!CheckCollisions(x, y + yspeed * scale, oSolidParent, row))  x += sign(xspeed);
	//while (!CheckCollisions(x, y, oSolidParent, row))					y += sign(yspeed);
	
	x += xspeed * scale;
	y += yspeed * scale;
	
	exhausted = true;
	saved_angle = darctan2(-yspeed, xspeed) + ((dir < 0) ? 180 : 0);
	xspeed = 0;
	yspeed = 0;
}

if (!exhausted && CheckCollisions(x, y, oPlayer, row))
{
	var _player = GetCollider(x, y, oPlayer, row);
	Knockback(_player, 1/3);
	ContactDamage(10, 0);
	if (instance_exists(host) && host.state != UniversalStates.DEAD && host.state != HalfBossStates.INACTIVE)  StartBattle(row, _player, host);
	instance_destroy();
}

if (x < oCamera.left - CAMERA_OFFSET)  instance_destroy();