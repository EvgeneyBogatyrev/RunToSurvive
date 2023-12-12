function SummonRobot() {

	//Obstacles

	//Forbidden
	ds_map_replace(oRoomControl.room_properties, "ForbiddenObstacles", [0, 1, 1, 1, 1, 0]);

	with (Create(oCamera.right - 120, oGenerator.ground[0] - 150, oRobotSpawner, 0))  depth -= 2;

	with (oStructureBlock)
	{
		instance_destroy();	
	}
	
	with (oChest)
	{
		instance_destroy();	
	}

	audio_stop_sound(oAudioControl.bgm);
	audio_play_sound(musBossIntro, 1, false);

	oAudioControl.bgm = musEyeForAnEye;
	oAudioControl.music_set = false;


}
