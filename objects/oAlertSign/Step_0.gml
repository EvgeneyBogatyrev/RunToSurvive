/// @description !
if (instance_exists(host)&&(host != noone)) 
{
	x = host.x;
	y = host.bbox_top - offset;
	offset++;
}
else
{
	instance_destroy();
	exit;
}

if (image_xscale < 2)
{
	image_xscale += 0.1;
	image_yscale += 0.1;
}



if (image_xscale >= 2) image_alpha -= 0.05;

if(image_alpha <= 0) instance_destroy();
