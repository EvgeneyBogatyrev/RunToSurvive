// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function SecondsToString(_seconds, _use_hours = true){
	var _full_time_in_seconds = floor(_seconds);

	var _sec = _full_time_in_seconds % 60;
	var _time_in_min = floor(_full_time_in_seconds / 60);
	var _min = _time_in_min % 60;
	var _hrs = floor(_time_in_min / 60);

	var _hrs_str = string(_hrs);
	_hrs_str = string_length(_hrs_str) > 1 ? _hrs_str : "0" + _hrs_str;
	
	var _s;
	if (_use_hours)
	{
		_s = _hrs_str + ":" + string_replace_all(string_format(_min, 2, 0) + ":" + string_format(_sec, 2, 0), " ", "0");	
	}
	else
	{
		_s = string_replace_all(string_format(_min, 2, 0) + ":" + string_format(_sec, 2, 0), " ", "0");
	}
	
	return _s;
	
}