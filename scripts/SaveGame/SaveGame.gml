function SaveGame() {
	//var _list = ds_list_create();
	//for (var i = 0; i < collection_size; i++){
	//	ds_list_add(_list, global.collection[i]);
	//}
	
	//var _string = ds_list_write(_list)	

	//ds_map_replace(save_map, "Collection", _string);
	ds_map_replace(save_map, "Music gain", global.music_gain);
	ds_map_replace(save_map, "Sound gain", global.sound_gain);
	ds_map_replace(save_map, "Resolution_width", global.display_width);
	ds_map_replace(save_map, "Resolution_height", global.display_height);
	ds_map_replace(save_map, "Character", global.character);	
	ds_map_replace(save_map, "Highscore", global.highscore);	
	ds_map_replace(save_map, "Difficulty", global.difficulty);
	ds_map_replace(save_map, "Fullscreen", window_get_fullscreen());


	//var p1 = player1_pocket[0] + 10 * player1_pocket[1] + 100 * player1_pocket[2];
	//var p2 = player2_pocket[0] + 10 * player2_pocket[1] + 100 * player2_pocket[2];

	//ds_map_replace(save_map, "Player1_pocket", p1);
  	//ds_map_replace(save_map, "Player2_pocket", p2);

	ds_map_secure_save(save_map, global.filename);


	//ds_list_destroy(_list);


}
