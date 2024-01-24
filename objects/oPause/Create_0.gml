button[0] = "CONTINUE";
button[1] = "RESTART";
button[2] = "EXIT";
//button[3] = "EXIT";
cursor_position = 0;
max_cursor = 2;

MODE = "Menu";
ebutton[0] = "BACK";

paused = false;

allowed_to_move = true;
allowed_to_move_hor = true;

allowed_array = [];
allowed_hor_array = [];

for (var i = 0; i <= 4; ++i)
{
	allowed_array[i] = true;
	allowed_hor_array[i] = true;
}

paused_on_this_frame = false;

unpause = function()
{
	if (paused_on_this_frame) return;
	if (file_exists("screen.png"))  file_delete("screen.png");
	MODE = "Menu";
	cursor_position = 0;
	max_cursor = 2;
	paused = false;
	layer_set_visible("Pause", false);
	instance_activate_all();
	oCamera.cam = view_camera[0];
	view_set_visible(1, false);
	view_set_visible(0, true);
	audio_resume_all();
}