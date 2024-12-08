/// @description Initialize global variables.

global.DEBUG = (os_get_config() == "DEBUG");

global.multiplayer = false;
	
globalvar input_type, names;
	
input_type[0] = InputTypes.KEYBOARD;
input_type[1] = InputTypes.GAMEPAD0;

names = [];


globalvar number_of_players;

globalvar player_colors;
player_colors = [];

global.music_gain = 1.0;
global.sound_gain = 0.5;

global.display_width = 1024;
global.display_height = 768;

global.score = 0;
global.highscore = 0;
global.difficulty = undefined;

global.filename = /*working_directory + */"file.name";

globalvar save_map;
global.character = "Kyron";
LoadGame();

	
display_set_gui_size(global.display_width, global.display_height);	
window_set_size(global.display_width, global.display_height);
surface_resize(application_surface, global.display_width, global.display_height);


globalvar grav;
grav = -0.7;

global.show_title = true;
global.show_animation = true;

global.level_started = false;

global.difficulty = Difficulty.NORMAL;

randomize();

globalvar CstmFnt,CstmFntOutline,FntDamage;

var mapstring = CF_LETTERS+CF_DIGITS+ "!?.,()+-=/*><':" + CF_ICONS_CONTROLLER + CF_ICONS_CHARS;
Print(mapstring);
CstmFnt = font_add_sprite_ext(sFont, mapstring, false, 0);
CstmFntOutline = font_add_sprite_ext(sFontOutline, mapstring, false, 0);

FntDamage = font_add_sprite_ext(sDamageIndicator, CF_DIGITS, false, 0);

room_goto(rMenu);