var _sin = sin(current_time / 350);
var _cos = cos(current_time / 350);

//calculate positions and rotations
//body
var _body_x = draw_x;
var _body_y = draw_y;
var _body_rot = _sin * 5;

//head
var _head_x = _body_x + GetRotatedXOffset(-4, 40, _body_rot) * scale;
var _head_y = _body_y - GetRotatedYOffset(-4, 40, _body_rot) * scale;
var _head_rot = _sin * 15;

//left arm
var _w = (sprite_get_width(sSpamtonNEOBody) - sprite_get_width(sSpamtonNEOArmLeft)) / 2;

var _arm_l_x = _body_x + GetRotatedXOffset(14, 25, _body_rot) * scale;
var _arm_l_y = _body_y - GetRotatedYOffset(14, 25, _body_rot) * scale;
var _arm_l_rot = _cos * 10 * scale;

//right arm
var _arm_r_x = _body_x + GetRotatedXOffset(-15, 25, _body_rot) * scale;
var _arm_r_y = _body_y - GetRotatedYOffset(-15, 25, _body_rot) * scale;
arm_right_x = _arm_r_x;
arm_right_y = _arm_r_y;

var _arm_r_rot = -_cos * 10 * scale;

//left leg
var _leg_l_x = _body_x + GetRotatedXOffset(5, -12, _body_rot) * scale;
var _leg_l_y = _body_y - GetRotatedYOffset(5, -12, _body_rot) * scale;
var _leg_l_rot = _sin * 6 * scale;

//right leg
var _leg_r_x = _body_x + GetRotatedXOffset(-5, -12, _body_rot) * scale;
var _leg_r_y = _body_y - GetRotatedYOffset(-5, -12, _body_rot) * scale;
var _leg_r_rot = _cos * 6 * scale;

//draw sprites

draw_set_color(c_green);
for (var _i = 0; _i < 6; _i++)
{
	var _x1 = _body_x + sin((current_time / 500) + _i) * 10;
	var _x2 = _x1;
	draw_line_width(_x1, oCamera.y - oCamera.view_h_half - 32, _x2, _body_y, 3 * scale);
}
draw_set_color(c_white);

draw_sprite_ext(sSpamtonNEOWingRight, 0, _arm_r_x, _arm_r_y, scale, scale, _arm_r_rot, image_blend, image_alpha);
if (state == SpamtonStates.PIPIS)
{
	draw_sprite_ext(sSpamtonNEOArmRight, 1, _arm_r_x, _arm_r_y, scale, scale, gun_rotation, image_blend, image_alpha);	
}
else
{
	draw_sprite_ext(sSpamtonNEOArmRight, 0, _arm_r_x, _arm_r_y, scale, scale, _arm_r_rot, image_blend, image_alpha);
}

draw_sprite_ext(sSpamtonNEOLeg, 0, _leg_r_x, _leg_r_y, scale, scale, _leg_r_rot, image_blend, image_alpha);
draw_sprite_ext(sSpamtonNEOLeg, 0, _leg_l_x, _leg_l_y, scale, scale, _leg_l_rot, image_blend, image_alpha);


draw_sprite_ext(sSpamtonNEOBody, 0, _body_x, _body_y, scale, scale, _body_rot, image_blend, image_alpha);
draw_sprite_ext(sSpamtonNEOHead, 0, _head_x, _head_y, scale, scale, _head_rot, image_blend, image_alpha);

draw_sprite_ext(sSpamtonNEOArmLeft, 0, _arm_l_x, _arm_l_y, scale, scale, _arm_l_rot, image_blend, image_alpha);
draw_sprite_ext(sSpamtonNEOWingLeft, 0, _arm_l_x, _arm_l_y, scale, scale, _arm_l_rot, image_blend, image_alpha);


if (state == SpamtonStates.HEART)
{
	
	heart_x = _body_x + lengthdir_x(heart_length, heart_angle);	
	heart_y = _body_y + lengthdir_y(heart_length, heart_angle);
	
	var _tmp_x = _body_x;
	var _tmp_y = _body_y;
	
	while (abs(_tmp_x - heart_x) > 5)
	{
		draw_sprite_ext(sSpamtonNEOChain, 0, _tmp_x, _tmp_y, scale, scale, 0, image_blend, image_alpha);
		_tmp_x += lengthdir_x(8, heart_angle);		
		_tmp_y += lengthdir_y(8, heart_angle);

	}
	
	draw_sprite_ext(sSpamtonNEOHeart, 0, heart_x, heart_y, scale, scale, 0, image_blend, image_alpha);

	if (hit_flash > 0)
	{
		hit_flash--;
		shader_set(shdHit);
		draw_sprite_ext(sSpamtonNEOHeart, 0, heart_x, heart_y, scale, scale, 0, image_blend, image_alpha);
		shader_reset();
	}

}
