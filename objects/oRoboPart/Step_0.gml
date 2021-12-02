/// @description Change the speed
image_blend = make_color_hsv(0, 0, abs(scale) * (255 / SCALE_TWO));
image_xscale = sign(image_xscale) * scale;
image_yscale = scale;

if (CheckCollisions(x + xspeed * scale, y, oBlock, row))
{
	repeat (abs(xspeed))
	{
		if (CheckCollisions(x + sign(xspeed), y, oBlock, row))  break;
		x += sign(xspeed);
	}
	xspeed = 0;
}

if (CheckCollisions(x, y + yspeed * scale, oBlock, row))
{
	repeat (abs(yspeed))
	{
		if (CheckCollisions(x, y + sign(yspeed), oBlock, row))  break;
		y += sign(yspeed);
	}
	yspeed = 0;
	grounded = true;
} 
else  yspeed -= grav * scale;

if (grounded)  xspeed = lerp(xspeed, 0, ground_res/100);

x += xspeed;
y += yspeed;

//if (CheckCollisions(x, y, oObstacle, row))  x += scale;

if (abs(xspeed) < 0.1 && grounded)
{
	if (image_index != 0)  image_alpha -= 0.01;
}

if (player_id != noone)
{
	if (global.multiplayer)  with (Create(x, y, oEssence, row))
	{
		depth -= 2;
		player_id = other.player_id;
	}
	player_id = noone;
}

x += oRoomControl.roomspeed * abs(scale);

if (x < oCamera.left - CAMERA_BOUNDS)  instance_destroy();

