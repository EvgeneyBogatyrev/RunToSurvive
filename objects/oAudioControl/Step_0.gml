/// @description work with music

if (!loaded)  exit;

audio_group_set_gain(BackGroundMusic, global.music_gain, 1);
audio_group_set_gain(SoundEffects, global.sound_gain/2, 1);


if (!audio_group_is_loaded(SoundEffects) || !audio_group_is_loaded(BackGroundMusic))  music_set = false;


if (room == rPlay && !instance_exists(oBossParent) && audio_is_playing(musBossIntro) && !instance_exists(oChasingStump))
{
	audio_stop_sound(musBossIntro);
	music_set = false;
}

if (!music_set) && (!audio_is_playing(musBossIntro)) && (room == rPlay) 
{
	if (audio_is_playing(last_bgm))  audio_stop_sound(last_bgm);
	

	last_bgm = bgm;
	MusicProp(bgm);	
		
	total_lenght = intro_lenght + loop_lenght;		
	music_set = true;
}

if (room == rMenu)
{
	if (!audio_is_playing(musKyron) || !music_set)
	{
		//audio_stop_all();
		audio_stop_sound(bgm);
		audio_stop_sound(musBossIntro);
		MusicProp(musKyron);
		
		total_lenght = intro_lenght + loop_lenght;		
		music_set = true;
	}
}


if (music_set)
{
	var _pos = audio_sound_get_track_position(bgm);
	if (_pos > total_lenght)   audio_sound_set_track_position(bgm, _pos - loop_lenght);	
}
