/// @description Set the position.

//positioning
x = 0;
y = 0;
 
offset = 12;
lowest_y = y;

rectangle_size = 5*offset;

//icon setting
pl_timer = [];
pl_sub = [];

for (var i = 0; i < number_of_players; ++i)
{
	pl_timer[i] = 150;
	pl_sub[i] = 0;
}


soul_radius = 9;

u_blur_vector = shader_get_uniform(shdExtra, "blur_vector")

//surf_ping = surface_create(room_width, room_height);
//surf_pong = surface_create(room_width, room_height);

//application_surface_draw_enable(false);


