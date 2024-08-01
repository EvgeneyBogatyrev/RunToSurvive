/// @description
draw_set_alpha(0.7);

draw_set_color(c_blue);
var _radius = sprite_get_width(sItems) / 2 * scale;
for (var i = 0; i < 360; ++i)
{
	if (i / 360 > time / max_time)  break;
	draw_line_width(x, y, x - dsin(i) * _radius, y - dcos(i) * _radius, 2);
}

draw_set_color(c_white);
draw_sprite_ext(sItemTimer, 0, x, y, 2.2 * scale, 2.2 * scale, 0, c_white, 1);
//draw_circle(x, y, _radius * 2/3, false);

draw_sprite_ext(sItems, index, x, y, 0.7 * scale, 0.7 * scale, 0, c_white, 1);

var _desc = "He has hidden in the howling void. He has hidden within the tempest. He has braved the storm and the darkness and pain. And he whispered to the vessel. All this time he whispered, and delighted and seduced, and the vessel did obey. For none should be more mighty and none should be more wise than the King himself. And the Lord of Time was blind and vain, and knew nothing. On the television prompter I am the loss I am the never I am the night I am the terror I am returning Harriet Arbinger (Harbinger) There is the Toymaker, the god of games. There is Trickster, the god of traps. There is Maestro, the god of music. There is Reprobate, the god of spite. There is the Mara, the god of beasts. And the threefold deity of malice and mischief and misery. There are gods of skin and shame and secrets. There is Incensor, the god of disaster. And her children, called Doubt and Dread. And standing on high is the mother and father and other of them all. For all the god of all gods has returned. And his names are many. His name has been Set. And Seth. And Sithifer. And his one true name for evermore is … Sutekh. Sutekh is the god of death and by his hand, all creation shall fall into dust and ashes and ruin! Susan Triad (Sutekh's Vessel) I bring Sutekh’s gift of death to all humanity. Sutekh, the God of Death I am Sutekh, the god of death. I am the night. I am the terror. I am the loss. And all life will perish at my hand. Susan Triad (Sutekh's Vessel) Did you think I was family, Doctor? I bring Sutekh’s gift of death for you and for all your tiny, vile, incessant universe!";

for (var _i = 0; _i < array_length(item_description); ++_i)
{
	if (item_description[_i].item_id == index)
	{
		_desc = item_description[_i].description;
		break;
	}
}

draw_set_font(fntItemDescription);
draw_set_alpha(0.5);
draw_set_color(c_black);
var _x_offset = 10;
var _y_offset = 10;

var _text_width = 220;
var _text_height = string_height_ext(_desc, 16, _text_width);

var _y_point = y - 75 * scale;


draw_rectangle(x - (_text_width / 2 + _x_offset), _y_point - _text_height / 2 - _y_offset, x + _text_width / 2 + _x_offset, _y_point + _text_height / 2 + _y_offset, false);

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

draw_text_ext_transformed(x, _y_point, _desc, 16, _text_width, 1, 1, 0);