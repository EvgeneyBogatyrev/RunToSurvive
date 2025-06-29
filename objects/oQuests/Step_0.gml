if (!quest_completed && oRoomControl.gamestate == GameState.NORMAL)
{
	CheckQuest();	
	if (global.DEBUG)
	{
		quest_completed = true;
	}
	
	if (quest_completed)
	{
		Create(oCamera.x + 2500, oGenerator.ground[0], oReward, 0);	
	}
}