function SummonDelver() {

	////Obstacles
	//ds_map_replace(oRoomControl.room_properties, "ObstacleBigSprite", sDryTree);
	//ds_map_replace(oRoomControl.room_properties, "ObstacleSmallSprite", sGravestone);

	////Background
	//ds_map_replace(oRoomControl.room_properties, "BackgroundFront", "bGraveyardTrees");
	//ds_map_replace(oRoomControl.room_properties, "BackgroundBack", "bGraveyard");

	//Forbidden
	ds_map_replace(oRoomControl.room_properties, "ForbiddenObstacles", [0, 0, 0, 1, 1, 0]);

	with (Create(oCamera.right - CAMERA_BOUNDS, oGenerator.ground[0] - 150, oDelver, 0))  depth -= 2;


	audio_stop_sound(oAudioControl.bgm);
	audio_play_sound(musBossIntro, 1, false);

	oAudioControl.bgm = musDelverOfSecrets;
	oAudioControl.music_set = false;


}
