var _keys = Input(InputTypes.MENU);
var _left = _keys[0];
var _right = _keys[1];
var _up = _keys[2];
var _down = _keys[3];
var _OK = _keys[4];
var _pause = _keys[5];

#region Sounds
if (paused)
{
	if (_up || _down)  audio_play_sound(soSelect, 1, false);
	if (_OK)           audio_play_sound(soConfirm, 10, false);
	
}
#endregion

if (_pause)
{
	_pause = false;
	if (!paused)
	{
		screen_save("screen.png");
		background = sprite_add("screen.png", 0, false, false, 0, 0);
		paused = true;
		layer_set_visible("Pause", true);
		oCamera.cam = view_camera[1];
		view_set_visible(1, true);
		view_set_visible(0, false);
		audio_pause_all();
		
		instance_deactivate_all(true);
	}
	else
	{
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
}

if (paused)
{
	
	if (_up)   cursor_position--;
	
	
	if (_down) cursor_position++;
	
	
	if (cursor_position < 0 )           cursor_position = max_cursor;
	if (cursor_position > max_cursor)   cursor_position = 0;
	
	#region menu
	if (MODE == "Menu")
	{
		if (_OK)
		{
			switch(cursor_position)
			{
				case 0 : 
					paused = false;
					layer_set_visible("Pause", false);
					instance_activate_all();
					oCamera.cam = view_camera[0];
					view_set_visible(1, false);
					view_set_visible(0, true);
					audio_resume_all();
					break;
				
				case 1 :
					instance_activate_all();				

					paused = false;
					global.gamestate = GameState.NORMAL;
					oCamera.cam = view_camera[0];
					view_set_visible(1, false);
					view_set_visible(0, true);
					oAudioControl.bgm = musOverworld;
					oAudioControl.music_set = false;
					layer_set_visible("Pause", false);
					room_restart();	
					break;
				
				case 2 : 
					paused = false;
					global.gamestate = GameState.NORMAL;
					instance_activate_all();
					layer_set_visible("Pause", false);
					oCamera.cam = view_camera[0];
					view_set_visible(1, false);
					view_set_visible(0, true);
					audio_stop_sound(oAudioControl.bgm);
					oAudioControl.music_set = false;
					SaveGame();
					global.show_title = false;
					room_goto(rMenu);
					break;
				
			}
		}
	}
	#endregion
			
}