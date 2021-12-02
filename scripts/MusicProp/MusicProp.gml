/// @desc MusicProp(sound)
function MusicProp(argument0) {

	/// @arg sound


	var s = argument0;


	//if (s == so_pandora)
	//{
	//	bgm = audio_play_sound(so_pandora, 0, false);
	//	intro_lenght = 24.037;
	//	loop_lenght = 3.25;
	//}
	//else if (s == so_plagueDoctor)
	//{
	//	bgm = audio_play_sound(so_plagueDoctor, 0, false);
	//	intro_lenght = 30.048;
	//	loop_lenght = 4.804;	
	//}
	//else if (s == so_main)
	//{
	//	bgm = audio_play_sound(so_main, 0, false);
	//	intro_lenght = 13.125;
	//	loop_lenght = 3.824;	
	//}
	//else if (s == so_delver)
	//{
	//	bgm = audio_play_sound(so_delver, 0, false);
	//	intro_lenght = 0.485;
	//	loop_lenght = 22.835;	
	//}
	//else if (s == so_track)
	//{
	//	bgm = audio_play_sound(so_track, 0, false);
	//	intro_lenght = 0;
	//	loop_lenght = 48.004;
	//}
	//else 
	if (s == musOverworld)
	{
		bgm = audio_play_sound(musOverworld, 0, false);
		intro_lenght = 0;
		loop_lenght = 29.558;
	}
	else if (s == musForestWeirdness)
	{
		bgm = audio_play_sound(musForestWeirdness, 0, false);
		intro_lenght = 0;
		loop_lenght = 30.006;
	}
	else if (s == musEyeForAnEye)
	{
		bgm = audio_play_sound(musEyeForAnEye, 0, false);
		intro_lenght = 0;
		loop_lenght = 51.690;
	}
	else if (s == musDelverOfSecrets)
	{
		bgm = audio_play_sound(musDelverOfSecrets, 0, false);
		intro_lenght = 0;
		loop_lenght = 48.004;
	}
	//else if (s == so_frost_and_iron)
	//{
	//	bgm = audio_play_sound(so_frost_and_iron, 0, false);
	//	intro_lenght = 13.617;
	//	loop_lenght = 96.034;
	//}
	//else if (s == so_forest_rush)
	//{
	//	bgm = audio_play_sound(so_forest_rush, 0, false);
	//	intro_lenght = 0;
	//	loop_lenght = 33.234;
	//}
	//else if (s == so_factory)
	//{
	//	bgm = audio_play_sound(so_factory, 0, false);
	//	intro_lenght = 0;
	//	loop_lenght = 36.016;	
	//}
	else if (s == musForestRush)
	{
		bgm = audio_play_sound(musForestRush, 0, false);
		intro_lenght = 0;
		loop_lenght = 22.243;	
	}
	else if (s == musKyron)
	{
		bgm = audio_play_sound(musKyron, 0, false);
		intro_lenght = 3.872;
		loop_lenght = 46.328;// - 3.434;		
	}
	//else if (s == so_ending)
	//{
	//	bgm = audio_play_sound(so_ending, 0, false);
	//	intro_lenght = 22.007;
	//	loop_lenght = 95.719;	
	//}

	total_lenght = intro_lenght + loop_lenght;		
	music_set = true;
	last_bgm = bgm;

	//return [bgm, intro_lenght, loop_lenght, total_lenght];


}
