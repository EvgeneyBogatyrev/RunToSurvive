image_angle = point_direction(x, y, x + xspeed, y + yspeed);

if (sprite_index == sPellet)
{
	image_speed = 0;
	image_index = 0;
	/*
	if (trail == undefined)
	{
		trail = part_type_create();
		part_type_shape(trail, pt_shape_sphere);
		part_type_size(trail, 0.2 * GetScale(row), 0.2 * GetScale(row), -0.05, 0);
		part_type_color1(trail, c_red);
		part_type_alpha1(trail, 0.1);
		part_type_speed(trail, 0, 0, -0.10, 0);
		part_type_direction(trail, image_angle, image_angle, 0, 20);
		part_type_life(trail,  80, 80);
	}
	*/

}

if (abs(x - oCamera.x) > oCamera.view_w_half * 3)  instance_destroy();


if (CheckCollisions(x + xspeed, y + yspeed, oEnemyParent, row))
{
	var _victim = GetCollider(x + xspeed, y + yspeed, oEnemyParent, row);

	if (_victim.state != UniversalStates.DEAD && _victim.state != HalfBossStates.INACTIVE && _victim.hp > 0) 
	{
		_victim.hp -= damage;
		if object_is_ancestor(_victim.object_index, oBossParent)
		{
			_victim.cum_hp -= damage;	
		}
		display = true;
		_victim.hit_flash = 3;
	
		repeat (abs(xspeed))
		{
			if (CheckCollisions(x + sign(xspeed), y + sign(yspeed) * yspeed / xspeed, oEnemyParent, row))	break;	

			x += sign(xspeed);	
			y += sign(yspeed) * yspeed / xspeed
		}
		
		hit_an_enemy = true;
	
		if (object_is_ancestor(_victim.object_index, oHalfBossParent) && _victim.state != UniversalStates.DEAD)  StartBattle(row, host, _victim);
		instance_destroy();	
	}
}

if (CheckCollisions(x + xspeed, y + yspeed, oSolidParent, row) || CheckCollisions(x + xspeed / 2, y + yspeed, oSolidParent, row))
{
	repeat (abs(xspeed))
	{
		if (CheckCollisions(x + sign(xspeed), y + sign(yspeed) * yspeed / xspeed, oSolidParent, row))	break;
		
		x += sign(xspeed);		
		y += sign(yspeed) * yspeed / xspeed;
		
	}

	instance_destroy();
}

if (place_meeting(x + xspeed, y + yspeed, oDelver) && oDelver.state == DelverStates.INSECT)
{
	repeat (abs(xspeed))
	{
		if (place_meeting(x + sign(xspeed), y + sign(yspeed) * yspeed / xspeed, oDelver))  break;
		
		x += sign(xspeed);		
		y += sign(yspeed) * yspeed / xspeed;
		
	}
	oDelver.hp -= damage;
	oDelver.cum_hp -= damage;
	oDelver.hit_flash = 3;
	display = true;
	
	hit_an_enemy = true;
	instance_destroy();	
}

if (instance_exists(host) && host.object_index != oPlayer)
{
	ContactDamage(damage, 0);	
}

if (trail != undefined)
{
	// Particles
	var _len = point_distance(x, y, xprevious, yprevious);
	var _ang = point_direction(xprevious, yprevious, x, y);
	var _x = x;
	var _y = y;
	
	for (var i = 0; i < _len; ++i)
	{	
		part_particles_create(global.particle_systems[row], _x + lengthdir_x(3 *i, _ang), _y + lengthdir_y(3 * i, _ang), trail, 1);
	}	
}

event_inherited();

if (image_index == 1)  image_speed = 0;


