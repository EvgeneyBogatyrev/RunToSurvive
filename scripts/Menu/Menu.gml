// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Menu() constructor
{
	fields = ds_list_create();
	is_main = false;
	previous_menu = undefined;
	
	AddField = function(_name, _func, _extra = false)
	{
		var _field = new MenuField(_name, _extra);
		_field.is_selection_field = _extra;
		_field.action = _func;
		
		ds_list_add(fields, _field);
	}
	
	FieldIsSelection = function(_index)
	{
		return fields[|_index].is_selection_field;
	}
	
	InteractWithField = function(_index, _extra = undefined)
	{
		var _field = fields[|_index];
		var _action = fields[|_index].action;
		
		
		if (_field.is_selection_field)
			with (oMenu) _action(_extra);
		else
			with (oMenu) _action();
	}
	
	GoBack = function()
	{
		if (previous_menu != undefined)
		{
			var _prev = previous_menu;
			with (oMenu) current_menu = _prev;
		}
		else
		{
			Print("Previous menu is undefined");
		}		
	}
	
	AddBackField = function()
	{
		var _field = new MenuField("BACK");
		
		_field.action = GoBack;
		
		ds_list_add(fields, _field);
	}
	
}

function MenuField(_name, _selecting = false, _action = undefined) constructor
{
	name = _name;
	is_selection_field = _selecting;
	
	if (is_selection_field)
		action = function(_a) {Print("Invalid field action! " + string(_a))};
	else
		action = function() {Print("Invalid field action!")};
	
}
