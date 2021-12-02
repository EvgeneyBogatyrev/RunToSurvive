///@desc Return forest properties
function GetStandartRoomProperties() {

	ds_map_destroy(oRoomControl.room_properties);

	oRoomControl.room_properties = ds_map_create();
	//Blocks
	ds_map_add(oRoomControl.room_properties, "BlockSprite", sGrassBlock);
	ds_map_add(oRoomControl.room_properties, "BlockEmptySprite", sGrassBlockEmpty);
	ds_map_add(oRoomControl.room_properties, "BlockRoundedLeftSprite", sGrassBlockRoundedLeft);
	ds_map_add(oRoomControl.room_properties, "BlockRoundedRightSprite", sGrassBlockRoundedRight);
	ds_map_add(oRoomControl.room_properties, "BlockRoundedLeftAndRightSprite", sGrassBlockRoundedLeftAndRight);
	ds_map_add(oRoomControl.room_properties, "BlockBigSprite", sGrassBlockBig);

	//Obstacles
	ds_map_add(oRoomControl.room_properties, "ObstacleBigSprite", sTree);
	ds_map_add(oRoomControl.room_properties, "ObstacleSmallSprite", sStone);

	//Background
	ds_map_add(oRoomControl.room_properties, "BackgroundFront", "bPineForest");
	ds_map_add(oRoomControl.room_properties, "BackgroundBack", "bMountains");

	//Obstacles
	ds_map_add(oRoomControl.room_properties, "ForbiddenObstacles", [0, 0, 0, 0, 0, 0]);

	//Music
	oAudioControl.bgm = musOverworld;
	oAudioControl.music_set = false;



}
