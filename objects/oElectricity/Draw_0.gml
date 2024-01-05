draw_set_color(merge_color(c_blue, c_white, 0.75));
DrawLightning(x, y, dir > 0 ? bbox_right : bbox_left, y + random_range(-5, 5) * scale, 5 * scale, 20 * scale, 5 * scale, 30 * scale);
draw_set_color(merge_color(c_yellow, c_white, 0.75));
DrawLightning(x, y, dir > 0 ? bbox_right : bbox_left, y + random_range(-5, 5) * scale, 5 * scale, 20 * scale, 5 * scale, 30 * scale);
draw_set_color(c_black);