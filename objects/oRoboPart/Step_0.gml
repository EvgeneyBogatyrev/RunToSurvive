/// @description Change the speed
image_blend = make_color_hsv(0, 0, abs(scale) * (255 / SCALE_TWO));
image_xscale = sign(image_xscale) * scale;
image_yscale = scale;
if (!grounded) image_angle += rotation_speed;

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
	image_alpha -= 0.01;
}


x += oRoomControl.roomspeed * abs(scale);

if (x < oCamera.left - CAMERA_BOUNDS)  instance_destroy();

