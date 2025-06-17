enum QuestType
{
	STUMPS,
	ARCHERS,
	BILLY,
	VARIES
};

quest = undefined;

stumps_killed = 0;
archers_killed = 0;
billys_killed = 0;
quest_completed = false;

max_kills = 10;

function ClearBuffers()
{
	stumps_killed = 0;
	archers_killed = 0;
	billys_killed = 0;
	quest_completed = false;
}


function SetNewQuest()
{
	ClearBuffers();
	
	quest = choose(QuestType.STUMPS, QuestType.ARCHERS, QuestType.BILLY, QuestType.VARIES);
	max_kills = choose(3, 4, 5);
	
	if (global.DEBUG)
	{
		max_kills = 1;	
	}
	
	if (quest == QuestType.BILLY || quest == QuestType.VARIES)
	{
		max_kills = 3;	
	}
}


function CheckQuest()
{
	switch (quest)
	{
		case QuestType.STUMPS:
			if (stumps_killed >= max_kills)
			{
				quest_completed = true;	
			}
			break;
		case QuestType.ARCHERS:
			if (archers_killed >= max_kills)
			{
				quest_completed = true;	
			}
			break;
		case QuestType.BILLY:
			if (billys_killed >= max_kills)
			{
				quest_completed = true;	
			}
			break;
		case QuestType.VARIES:
			if (billys_killed > 0 && stumps_killed > 0 && archers_killed > 0)
			{
				quest_completed = true;	
			}
		default:
			break;
	}
}