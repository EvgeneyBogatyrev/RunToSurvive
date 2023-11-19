///@desc If players have lost
function LevelEnd() {
	if (global.score > global.highscore)
	{
		global.highscore = global.score;
		SaveGame();
	}
	global.show_title = false;
	room_goto(rMenu);
}
