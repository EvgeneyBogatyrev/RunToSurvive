/// @description Insert description here
// You can write your code in this editor
if (x < oCamera.left - CAMERA_BOUNDS * scale)  x = oCamera.left - CAMERA_BOUNDS * scale;
event_inherited();


if (host == noone || !instance_exists(host))
{
	instance_destroy();
	exit;
}
angle += rotation_speed;
x = host.x + lengthdir_x(distance_to_host * scale, angle);
y = host.y + lengthdir_y(distance_to_host * scale, angle) - height_offset * scale;

row = host.row;
depth = host.depth - 1;
scale = host.scale;
