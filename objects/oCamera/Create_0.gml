/// @description initialize variables

enum CameraFocus
{
	ROW0,
	ROW1,
	ROW2,
	TARGET_ZOOM
};

enum CameraMode
{
	STATIC,
	MOVING
};

cam = view_camera[0];
view_w_half = camera_get_view_width(cam) * 0.5;
view_h_half = camera_get_view_height(cam) * 0.5;

x = room_width / 2;
y = room_height / 2;

mode = CameraMode.MOVING;
focus = CameraFocus.ROW2;

x_to = x;
y_to = y;

left = x - view_w_half;
right = x + view_w_half;

follow = oPlayer;

shake_lenght = 0;
shake_magnitude = 0;
shake_remain = 0;
buff = 32;

camera_speed = 30;

