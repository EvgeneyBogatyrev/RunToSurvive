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
	max_kills = choose(1, 2, 3);
	
	if (global.DEBUG)
	{
		max_kills = 1;	
	}
	
	if (quest == QuestType.BILLY)
	{
		max_kills = choose(1, 2);	
	}
	
	if (quest == QuestType.VARIES)
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

function QuestTarget(_sprite, _done)
{
	return {
		sprite : _sprite,
		image : 0,
		done : _done
	};
}

function GetQuestTargets()
{
	var _targets = [];
	
	switch (quest)
	{
		case QuestType.STUMPS:
			for (var _i = 0; _i < max_kills; ++_i)
			{
				array_push(_targets, QuestTarget(sStumpRun, _i < stumps_killed));	
			}
			break;
		case QuestType.ARCHERS:
			for (var _i = 0; _i < max_kills; ++_i)
			{
				array_push(_targets, QuestTarget(sArcherStand, _i < archers_killed));	
			}
			break;
		case QuestType.BILLY:
			for (var _i = 0; _i < max_kills; ++_i)
			{
				array_push(_targets, QuestTarget(sBillyWalk, _i < billys_killed));	
			}
			break;
		case QuestType.VARIES:
			array_push(_targets, QuestTarget(sStumpRun, stumps_killed > 0));
			array_push(_targets, QuestTarget(sArcherStand, archers_killed > 0));
			array_push(_targets, QuestTarget(sBillyWalk, billys_killed > 0));
			break;
		default:
			break;
	}
	
	return _targets;
}

function GetQuestTitle()
{
	switch (quest)
	{
		case QuestType.STUMPS:
			return "Destroy Stumps";
		case QuestType.ARCHERS:
			return "Destroy Archers";
		case QuestType.BILLY:
			return "Destroy Billys";
		case QuestType.VARIES:
			return "Destroy one of each";
		default:
			return "Destroy enemies";
	}
}
