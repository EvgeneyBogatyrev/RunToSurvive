var _sin = sin(current_time / 350);
var _cos = cos(current_time / 350);

//calculate positions and rotations
//body
var _body_x = x;
var _body_y = y;
var _body_rot = _sin * 5;

//head
var _head_x = _body_x + GetRotatedXOffset(-4, 40, _body_rot);
var _head_y = _body_y - GetRotatedYOffset(-4, 40, _body_rot);
var _head_rot = _sin * 15;

//left arm
var _w = (sprite_get_width(sSpamtonNEOBody) - sprite_get_width(sSpamtonNEOArmLeft)) / 2;

var _arm_l_x = _body_x + GetRotatedXOffset(14, 25, _body_rot);
var _arm_l_y = _body_y - GetRotatedYOffset(14, 25, _body_rot);
var _arm_l_rot = _cos * 10;

//right arm
var _arm_r_x = _body_x + GetRotatedXOffset(-15, 25, _body_rot);
var _arm_r_y = _body_y - GetRotatedYOffset(-15, 25, _body_rot);
var _arm_r_rot = -_cos * 10;

//left leg
var _leg_l_x = _body_x + GetRotatedXOffset(5, -12, _body_rot);
var _leg_l_y = _body_y - GetRotatedYOffset(5, -12, _body_rot);
var _leg_l_rot = _sin * 6;

//right leg
var _leg_r_x = _body_x + GetRotatedXOffset(-5, -12, _body_rot);
var _leg_r_y = _body_y - GetRotatedYOffset(-5, -12, _body_rot);
var _leg_r_rot = _cos * 6;

//draw sprites

draw_set_color(c_green);
for (var _i = 0; _i < 6; _i++)
{
	var _x1 = _body_x + sin((current_time / 500) + _i) * 10;
	var _x2 = _x1;
	draw_line_width(_x1, oCamera.y - oCamera.view_h_half - 32, _x2, _body_y, 3);
}
draw_set_color(c_white);

draw_sprite_ext(sSpamtonNEOArmRight, 0, _arm_r_x, _arm_r_y, scale, scale, _arm_r_rot, image_blend, image_alpha);
draw_sprite_ext(sSpamtonNEOWingRight, 0, _arm_r_x, _arm_r_y, scale, scale, _arm_r_rot, image_blend, image_alpha);

draw_sprite_ext(sSpamtonNEOLeg, 0, _leg_r_x, _leg_r_y, scale, scale, _leg_r_rot, image_blend, image_alpha);
draw_sprite_ext(sSpamtonNEOLeg, 0, _leg_l_x, _leg_l_y, scale, scale, _leg_l_rot, image_blend, image_alpha);


draw_sprite_ext(sSpamtonNEOBody, 0, _body_x, _body_y, scale, scale, _body_rot, image_blend, image_alpha);
draw_sprite_ext(sSpamtonNEOHead, 0, _head_x, _head_y, scale, scale, _head_rot, image_blend, image_alpha);

draw_sprite_ext(sSpamtonNEOArmLeft, 0, _arm_l_x, _arm_l_y, scale, scale, _arm_l_rot, image_blend, image_alpha);
draw_sprite_ext(sSpamtonNEOWingLeft, 0, _arm_l_x, _arm_l_y, scale, scale, _arm_l_rot, image_blend, image_alpha);

