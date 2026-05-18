var _center_x = display_get_gui_width() / 2;
var _label = global.score < global.highscore ? "SCORE" : "BEST";
var _score = global.score < global.highscore ? string(global.score) + " / " + string(global.highscore) : string(global.score) + " HIGHSCORE";

draw_set_font(fntItemDescription);
var _label_width = string_width(_label);
draw_set_font(fntMenu);
var _score_width = string_width(_score);

var _padding_x = 14;
var _gap = 12;
var _panel_width = max(230, _label_width + _gap + _score_width + _padding_x * 2);
var _panel_height = 38;
var _panel_x1 = _center_x - _panel_width / 2;
var _panel_y1 = 12;
var _panel_x2 = _center_x + _panel_width / 2;
var _panel_y2 = _panel_y1 + _panel_height;

draw_set_alpha(0.58);
draw_set_colour(c_black);
draw_roundrect(_panel_x1, _panel_y1, _panel_x2, _panel_y2, false);
draw_set_alpha(0.35);
draw_set_colour(c_white);
draw_roundrect(_panel_x1, _panel_y1, _panel_x2, _panel_y2, true);

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_font(fntItemDescription);
draw_set_colour(global.score < global.highscore ? c_ltgray : c_yellow);
var _score_y = _panel_y1 + _panel_height / 2 + 1;
draw_text(_panel_x1 + _padding_x, _score_y + 4, _label);

draw_set_font(fntMenu);
draw_set_colour(c_white);
draw_text(_panel_x1 + _padding_x + _label_width + _gap, _score_y, _score);

var _reward_stands_visible = false;
if (instance_exists(oRewardStand) && instance_exists(oCamera))
{
	for (var _stand_i = 0; _stand_i < instance_number(oRewardStand); ++_stand_i)
	{
		var _stand = instance_find(oRewardStand, _stand_i);
		if (_stand.x > oCamera.left - 96 && _stand.x < oCamera.right + 96)
		{
			_reward_stands_visible = true;
			break;
		}
	}
}

if (gamestate == GameState.LOOT && _reward_stands_visible && !instance_exists(oDeathScreen))
{
	var _guide = "Stand on a reward and press A / Y";
	draw_set_font(fntItemDescription);
	var _guide_width = string_width(_guide) * 1.25;
	var _guide_height = string_height(_guide) * 1.25;
	var _guide_padding_x = 12;
	var _guide_padding_y = 7;
	var _guide_x1 = _center_x - _guide_width / 2 - _guide_padding_x;
	var _guide_y1 = _panel_y2 + 8;
	var _guide_x2 = _center_x + _guide_width / 2 + _guide_padding_x;
	var _guide_y2 = _guide_y1 + _guide_height + _guide_padding_y * 2;
	
	draw_set_alpha(0.52);
	draw_set_colour(c_black);
	draw_roundrect(_guide_x1, _guide_y1, _guide_x2, _guide_y2, false);
	draw_set_alpha(1);
	draw_set_colour(c_white);
	draw_set_halign(fa_center);
	draw_text_transformed(_center_x, _guide_y1 + (_guide_y2 - _guide_y1) / 2 + 1, _guide, 1.25, 1.25, 0);
}

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);
draw_set_font(CstmFntOutline);
