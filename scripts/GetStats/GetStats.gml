// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function GetStats(_field)
{
	_field = string_trim(_field);
	if !ds_map_exists(oDifficultyController.stats, _field)		return 0;
	return ds_map_find_value(oDifficultyController.stats, _field)[global.difficulty];
}