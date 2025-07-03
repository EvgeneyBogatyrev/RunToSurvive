if (!quest_completed && oRoomControl.gamestate != GameState.BOSS)
{
	var str = "Destroy " + string(max_kills) + " ";
	switch (quest)
	{
		case QuestType.STUMPS:
			str += "Stumps.\nProgress: " + string(stumps_killed);
			break;
		case QuestType.ARCHERS:
			str += "Archers.\nProgress: " + string(archers_killed);
			break;
		case QuestType.BILLY:
			str += "Billys.\nProgress: " + string(billys_killed);
			break;
		case QuestType.VARIES:
			str += "different enemies.\nProgress: " + string((stumps_killed > 0) + (archers_killed > 0) + (billys_killed > 0));
		default:
			break;
	}
	str += "/" + string(max_kills);
	str += "\n" + string(int64(oBossControlQuest.timer / 60));
	
	draw_set_font(fntItemDescription);
	draw_set_color(c_black);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_text(display_get_gui_width() / 2, 50, str);
}
