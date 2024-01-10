minibosses_defeated = 0;
bosses_defeated = 0;


enum Difficulty 
{
	EASY,
	NORMAL,
	HARD,
	EXTREME
};

stats = ds_map_create();

file_grid = load_csv("RunToSurvive_difficulty.csv");
var ww = ds_grid_width(file_grid);
var hh = ds_grid_height(file_grid);

for (var i = 1; i < hh; i++;)
{
	var _name = string_trim(file_grid[# 0, i]);
	var _data = [];
    for (var j = 1; j < ww; j++;)
    {
		_data[j - 1] = int64(file_grid[# j, i]);
    }
	ds_map_add(stats, _name, _data);
	Print(_name, _data);
}