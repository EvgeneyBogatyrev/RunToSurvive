if (!quest_completed && oRoomControl.gamestate != GameState.BOSS)
{
	var _targets = GetQuestTargets();
	var _slot_size = 52;
	var _slot_gap = 10;
	var _center_x = display_get_gui_width() / 2;
	var _title_y = 52;
	var _slot_y = 102;
	var _timer_y = 134;
	var _total_width = array_length(_targets) * _slot_size + max(0, array_length(_targets) - 1) * _slot_gap;
	var _start_x = _center_x - _total_width / 2 + _slot_size / 2;
	
	draw_set_font(fntItemDescription);
	draw_set_color(c_black);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_text(_center_x, _title_y, GetQuestTitle());
	
	for (var _i = 0; _i < array_length(_targets); ++_i)
	{
		var _target = _targets[_i];
		var _slot_x = _start_x + _i * (_slot_size + _slot_gap);
		var _left = _slot_x - _slot_size / 2;
		var _top = _slot_y - _slot_size / 2;
		var _right = _slot_x + _slot_size / 2;
		var _bottom = _slot_y + _slot_size / 2;
		
		draw_set_alpha(0.48);
		draw_set_color(c_black);
		draw_roundrect(_left, _top, _right, _bottom, false);
		draw_set_alpha(0.85);
		draw_roundrect(_left, _top, _right, _bottom, true);
		
		var _sprite = _target.sprite;
		var _bbox_left = sprite_get_bbox_left(_sprite);
		var _bbox_right = sprite_get_bbox_right(_sprite);
		var _bbox_top = sprite_get_bbox_top(_sprite);
		var _bbox_bottom = sprite_get_bbox_bottom(_sprite);
		var _bbox_w = max(1, _bbox_right - _bbox_left);
		var _bbox_h = max(1, _bbox_bottom - _bbox_top);
		var _part_left = max(0, _bbox_left - 8);
		var _part_top = max(0, _bbox_top - 4);
		var _part_right = min(sprite_get_width(_sprite), _bbox_right + 8);
		var _part_bottom = min(sprite_get_height(_sprite), _bbox_top + _bbox_h * 0.58 + 8);
		if (_sprite == sStumpRun)
		{
			_part_top = max(0, _bbox_top - 10);
			_part_bottom = min(sprite_get_height(_sprite), _bbox_bottom + 4);
		}
		var _part_w = max(1, _part_right - _part_left);
		var _part_h = max(1, _part_bottom - _part_top);
		var _sprite_scale = min((_slot_size - 10) / _part_w, (_slot_size - 10) / _part_h);
		var _sprite_x = _slot_x - (_part_w * _sprite_scale) / 2;
		var _sprite_y = _slot_y - (_part_h * _sprite_scale) / 2;
		
		draw_set_alpha(_target.done ? 0.72 : 1);
		draw_sprite_part_ext(_sprite, _target.image, _part_left, _part_top, _part_w, _part_h, _sprite_x, _sprite_y, _sprite_scale, _sprite_scale, _target.done ? c_gray : c_white, 1);
		
		if (_target.done)
		{
			draw_set_alpha(0.85);
			draw_set_color(c_black);
			draw_line_width(_left + 9, _top + 9, _right - 9, _bottom - 9, 7);
			draw_line_width(_right - 9, _top + 9, _left + 9, _bottom - 9, 7);
			draw_set_color(c_red);
			draw_line_width(_left + 9, _top + 9, _right - 9, _bottom - 9, 4);
			draw_line_width(_right - 9, _top + 9, _left + 9, _bottom - 9, 4);
		}
	}
	
	draw_set_alpha(1);
	draw_set_color(c_black);
	draw_text(_center_x, _timer_y, SecondsToString(oBossControlQuest.timer / 60, false));
	draw_set_alpha(1);
}
