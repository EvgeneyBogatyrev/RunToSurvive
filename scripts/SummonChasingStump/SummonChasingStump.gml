/// !!! IN PROGRESS !!!
function SummonChasingStump() {
	ds_map_replace(oRoomControl.room_properties, "ForbiddenObstacles", [0, 0, 0, 0, 1, 0]);

	with (Create(oCamera.right + CAMERA_BOUNDS, oGenerator.ground[0] - 150, oChasingStump, 2))  depth -= 2;


	audio_stop_sound(oAudioControl.bgm);
	audio_play_sound(musTension, 1, false);

	oAudioControl.bgm = musForestRush;
	oAudioControl.music_set = false;


}
