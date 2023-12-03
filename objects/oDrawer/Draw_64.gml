/// @description Draw stats.

shader_set(shdBloom);
surface_set_target(surf_ping);
draw_surface(application_surface, 0, 0);
surface_reset_target();
shader_reset();

gpu_set_tex_filter(true);
shader_set(shdExtra);
shader_set_uniform_f(u_blur_vector, 1, 0);
surface_set_target(surf_pong);
draw_surface(surf_ping, 0, 0);
surface_reset_target();
shader_reset();


shader_set(shdExtra);
shader_set_uniform_f(u_blur_vector, 0, 1);
surface_set_target(surf_ping);
draw_surface(surf_pong, 0, 0);
surface_reset_target();

gpu_set_tex_filter(false);

shader_reset();

draw_surface(application_surface, 0, 0);

//gpu_set_blendmode(bm_add);
//draw_surface(surf_ping, 0, 0);
//gpu_set_blendmode(bm_normal);

var list_of_players = ds_list_create();

with(oPlayer)  
{
	ds_list_add
	(
		list_of_players,
		id
	);	
}


var cur_y = y + 2*offset;



for (var i = 0; i < ds_list_size(list_of_players); i++)
{
	pl_timer[i]--;
	
	
	var cur_x = x + 2 * offset;	
	var _circle_x = cur_x - soul_radius - 2;
	var _circle_y = cur_y + soul_radius + 4;
	//draw_set_color(merge_color(c_yellow, c_black, 0.3));
	
	for (var k = 0; k < 3; ++k)
	{
		//draw_circle(_circle_x, _circle_y, soul_radius, false);
		_circle_y += soul_radius * 2 + 2;
	}
	
	draw_set_alpha(1);
	
	var _pl = ds_list_find_value(list_of_players, i);
	
	
	if (pl_timer[i] <= 0)
	{
		if (pl_sub[i] == 0)
		{
			pl_timer[i] = 30;	
			pl_sub[i] = choose(1, 2);
		}
		else
		{
			pl_timer[i] = irandom_range(120, 180);
			pl_sub[i] = 0;
		}
	}
	draw_sprite(_pl.sPlayerIcon, pl_sub[i], cur_x, cur_y + 4);
	

	cur_x += offset + rectangle_size;

	var cur_player = ds_list_find_value(list_of_players, i);
	
	draw_sprite_ext(sHealthBar, 1, cur_x, cur_y + 1, (cur_player.shown_hp / cur_player.maxhp), 1, 0, c_red, 1);
	draw_sprite(sHealthBar, 0, cur_x, cur_y);
	
	cur_y += (rectangle_size + offset)/2;
	cur_x = x + 3*offset + rectangle_size;

	
	draw_sprite_ext(sHealthBar, 2, cur_x, cur_y + 1, (cur_player.shown_bullets / cur_player.maxbullets), 1, 0, c_yellow, 1);
	draw_sprite(sHealthBar, 0, cur_x, cur_y);
	
	cur_x += sprite_get_width(sHealthBar) + offset;
	cur_y -= (rectangle_size - offset)/2;
	
	draw_sprite_ext(sInventory, 0, cur_x, cur_y - 5, 1, 1, 0, c_white, 1);
	draw_set_color(c_black);
	for (var j = 0; j <= 1; ++j)
	{
		if (j > 0 && cur_player.pocket[j] == 0)  break;
		
		draw_sprite_ext(sItems, cur_player.pocket[j], cur_x + sprite_get_width(sItems)/4 + (j == 0 ? 2 : -6), cur_y + sprite_get_height(sItems)/4, 0.5, 0.5, 0, c_white, draw_get_alpha());
		cur_x += sprite_get_width(sItemBackground)/2 + offset;
	}	
	
	
	if (_pl._show_inv)
	{
		var _inventory_x = x + 380; // not correct, please look into
		for (var j = 0; j < ds_list_size(_pl.inventory); j++)
		{
		
			var _item_index = ds_list_find_value(_pl.inventory, j);
		
			draw_sprite_ext(sPassiveItems, _item_index, _inventory_x + sprite_get_width(sPassiveItems)/4 + j * sprite_get_width(sPassiveItems)/2, cur_y + sprite_get_height(sPassiveItems)/4, 0.5, 0.5, 0, c_white, draw_get_alpha());
		
		}
	}

	cur_y -= 2;
	cur_y += (rectangle_size - offset)/2;
	
	cur_y += (4 * offset);

	
}

lowest_y = cur_y + 5 * offset;

ds_list_destroy(list_of_players);

