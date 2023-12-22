/// @description Insert description here
// You can write your code in this editor

var target_color = attack_timer > 60 ? c_red : (sin(get_timer() / 25000) > 0 ? c_red : c_white);

draw_sprite_ext(sTarget, 0, x, oGenerator.ground[row] + 10 * scale, scale * 1.5, scale * 1.5, 0, target_color, 1);





// Inherit the parent event
event_inherited();

