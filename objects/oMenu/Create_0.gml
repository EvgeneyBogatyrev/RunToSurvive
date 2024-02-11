cursor_pos = 0;


main_menu = new Menu();
options_menu = new Menu();
mode_select_menu = new Menu();

current_menu = main_menu;

window_center();

//Main menu fields
main_menu.is_main = true;
main_menu.AddField("START", function() { current_menu = mode_select_menu; } );
main_menu.AddField("OPTIONS", function() { current_menu = options_menu; } );
main_menu.AddField("EXIT", game_end);//function() { game_end(); } );
main_menu.AddField("OLD MENU", function() { instance_change(oMainMenu, true); } );

//Mode select fields
mode_select_menu.previous_menu = main_menu;

mode_select_menu.AddField("SINGLEPLAYER", function()
{
	number_of_players = 1;
	names[0] = global.character;
	input_type[0] = InputTypes.ANY; // FIX!
	room_goto(rPlay);
});
mode_select_menu.AddField("MULTIPLAYER", function()
{
	instance_change(oPlayerSelect, true);
});
mode_select_menu.AddBackField();

//Options fields
options_menu.previous_menu = main_menu;


options_menu.AddBackField();


//weird shit, should probably fix
allowed_to_move = true;
allowed_to_move_hor = true;

allowed_array = [];
allowed_hor_array = [];

for (var i = 0; i <= 4; ++i)
{
	allowed_array[i] = true;
	allowed_hor_array[i] = true;
}