// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SummonSpamton(){
	//Obstacles
	ds_map_replace(oRoomControl.room_properties, "BlockSprite", sSpamRails);	
	ds_map_replace(oRoomControl.room_properties, "BlockBigSprite", sSpamRailsBig);
	ds_map_replace(oRoomControl.room_properties, "BlockEmptySprite", sSpamRailsEmpty);
	
	ds_map_replace(oRoomControl.room_properties, "BlockRoundedLeftSprite", sSpamRails);
	ds_map_replace(oRoomControl.room_properties, "BlockRoundedRightSprite", sSpamRails);
	ds_map_replace(oRoomControl.room_properties, "BlockRoundedLeftAndRightSprite", sSpamRails);



	ds_map_replace(oRoomControl.room_properties, "BackgroundBack", "bSpamCity");
	ds_map_replace(oRoomControl.room_properties, "BackgroundFront", "bGraveyardTrees");
	
	//Forbidden
	ds_map_replace(oRoomControl.room_properties, "ForbiddenObstacles", [0, 1, 1, 1, 1, 0]);

	with (Create(oCamera.right - CAMERA_BOUNDS, -200, oSpamtonNeo, 0)) {}

	audio_stop_sound(oAudioControl.bgm);
	audio_play_sound(musBossIntro, 1, false);

	oAudioControl.bgm = musNowsYourShot;
	oAudioControl.music_set = false;
}