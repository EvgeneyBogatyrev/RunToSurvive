draw_set_font(FntDamage);
draw_set_color(c_white);
draw_set_alpha(image_alpha);
//var _sign = (damage > 0) ? "+" : "";
draw_text(x, y, string(damage));
draw_set_alpha(1);