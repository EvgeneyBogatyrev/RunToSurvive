function SummonRobot() {

	//Obstacles
	ds_map_replace(oRoomControl.room_properties, "BlockSprite", sMetalBlock);	
	ds_map_replace(oRoomControl.room_properties, "BlockBigSprite", sMetalBlockBig);

	ds_map_replace(oRoomControl.room_properties, "BackgroundFront", "bGraveyardTrees");
	//ds_map_replace(oRoomControl.room_properties, "BackgroundBack", "bGraveyard");

	//Forbidden
	ds_map_replace(oRoomControl.room_properties, "ForbiddenObstacles", [0, 1, 1, 1, 1, 0]);

	with (Create(oCamera.left - 20, oGenerator.ground[0] - 250, oRobotBoss, 0)) {}

	//with (oStructureBlock)
	//{
	//	instance_destroy();	
	//}
	
	//with (oChest)
	//{
	//	instance_destroy();	
	//}

	audio_stop_sound(oAudioControl.bgm);
	audio_play_sound(musBossIntro, 1, false);

	oAudioControl.bgm = musRobots;
	oAudioControl.music_set = false;


}
