function SummonGunMan() {

	//Obstacles
	//ds_map_replace(oRoomControl.room_properties, "ObstacleBigSprite", sDryTree);
	//ds_map_replace(oRoomControl.room_properties, "ObstacleSmallSprite", sGravestone);

	//Background
	//ds_map_replace(oRoomControl.room_properties, "BackgroundFront", "bGraveyardTrees");
	//ds_map_replace(oRoomControl.room_properties, "BackgroundBack", "bGraveyard");

	//Blocks
	//ds_map_replace(oRoomControl.room_properties, "BlockSprite", sGrassBlock1);
	//ds_map_replace(oRoomControl.room_properties, "BlockEmptySprite", sGrassBlockEmpty1);
	//ds_map_replace(oRoomControl.room_properties, "BlockRoundedLeftSprite", sGrassBlockRoundedLeft1);
	//ds_map_replace(oRoomControl.room_properties, "BlockRoundedRightSprite", sGrassBlockRoundedRight1);
	//ds_map_replace(oRoomControl.room_properties, "BlockRoundedLeftAndRightSprite", sGrassBlockRoundedLeftAndRight1);
	//ds_map_replace(oRoomControl.room_properties, "BlockBigSprite", sGrassBlockBig1);

	//Forbidden
	ds_map_replace(oRoomControl.room_properties, "ForbiddenObstacles", [0, 1, 1, 1, 1, 1]);

	with (Create(oCamera.right + 1750, oGenerator.ground[0] - 10, oGunMan, 0))  depth -= 2;
	


	audio_stop_sound(oAudioControl.bgm);
	audio_play_sound(musBossIntro, 1, false);

	oAudioControl.bgm = musEyeForAnEye;
	oAudioControl.music_set = false;

}
