/// !!! IN PROGRESS !!!
function SummonChasingStump() 
{
	ds_map_replace(oRoomControl.room_properties, "ForbiddenObstacles", [0, 0, 0, 0, 0, 0]);

	with (Create(oCamera.right + CAMERA_BOUNDS, oGenerator.ground[2] - 150, oChasingStump, 0))  depth -= 2;


	audio_stop_sound(oAudioControl.bgm);
	audio_play_sound(musBossIntro, 1, false);

	oAudioControl.bgm = musForestRush;
	oAudioControl.music_set = false;


}
