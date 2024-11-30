// Inherit the parent event
event_inherited();

number_of_segments = 10;

walkspeed = 10;

head_sprite = sBullet;
segment_sprite = sBullet;
tail_sprite = sBullet;

segments = [];


sprite_index = head_sprite;

init = false;

collision_detector = undefined;

damage = 0;

hp = 1;

normal_move = true;
random_velocities = [];

real_image_alpha = 1;