function LoadGame() {
	if (not file_exists(global.filename))
	{
		save_map = ds_map_create();
		ds_map_add(save_map, "Resolution_width", 1024);
		ds_map_add(save_map, "Resolution_height", 768);
		ds_map_add(save_map, "Music gain", global.music_gain);
		ds_map_add(save_map, "Sound gain", global.sound_gain);
		ds_map_add(save_map, "Character", global.character);		
		ds_map_add(save_map, "Highscore", global.highscore);
		ds_map_add(save_map, "Difficulty", Difficulty.NORMAL);

		//ds_map_add(save_map, "Player1_pocket", 1);
		//ds_map_add(save_map, "Player2_pocket", 1);

		//SetCollectionToZero();
	
		//var _list = ds_list_create();
	
		//for (var i = 0; i < collection_size; i++){
		//	ds_list_add(_list, global.collection[i]);
		//}
	
		//var _string = ds_list_write(_list)

		//ds_map_add(save_map, "Collection", _string);
	
		//ds_list_destroy(_list);
	
	}
	else
	{
		save_map = ds_map_secure_load(global.filename);
		global.display_width = ds_map_find_value(save_map, "Resolution_width");
		global.display_height = ds_map_find_value(save_map, "Resolution_height");
		global.music_gain = ds_map_find_value(save_map, "Music gain");
		global.sound_gain = ds_map_find_value(save_map, "Sound gain");
		global.character = ds_map_find_value(save_map, "Character");		
		global.highscore = ds_map_find_value(save_map, "Highscore");		
		global.difficulty = ds_map_find_value(save_map, "Difficulty");
		

		
		if (global.character == undefined) 
		{
			global.character = "Kyron";	
		}
		if (global.highscore == undefined)
		{
			global.highscore = 0;	
		}
		if (global.difficulty == undefined)
		{
			global.difficulty = Difficulty.NORMAL;
		}
		//var p1 = ds_map_find_value(save_map, "Player1_pocket");
		//var p2 = ds_map_find_value(save_map, "Player2_pocket");
	
		//player1_pocket[0] = p1 % 10;
		//player1_pocket[1] = ((p1 % 100) - (p1 % 10))/10;
		//player1_pocket[2] = int64(p1/100);
	
		//player2_pocket[0] = p2 % 10;
		//player2_pocket[1] = ((p2 % 100) - (p2 % 10))/10;
		//player2_pocket[2] = int64(p2/100);
	
		//var _string = ds_map_find_value(save_map, "Collection");
		//var _list = ds_list_create();
		//ds_list_read(_list, _string);
	
		//for (var i = 0; i < collection_size; i++){
		//	global.collection[i] = ds_list_find_value(_list, i);
		//}
	
		//ds_list_destroy(_list);
	}


}
