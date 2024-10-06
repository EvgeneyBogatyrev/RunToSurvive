event_inherited();

if (trail == undefined)
{
	trail = part_type_create();
	part_type_shape(trail, pt_shape_line);
	part_type_size(trail, 0.2 * GetScale(row), 1 * GetScale(row), -0.05, 0);
	part_type_color1(trail, c_red);
	part_type_alpha1(trail, 0.1);
	part_type_speed(trail, 0, 0, -0.10, 0);
	part_type_direction(trail, 0, 359, 0, 20);
	part_type_life(trail,  40, 40);	
}

ContactDamage(damage, 0);

// Particles
var _len = point_distance(x, y, xprevious, yprevious);
var _ang = point_direction(xprevious, yprevious, x, y);
var _x = xprevious;
var _y = yprevious;

image_angle = _ang;
	
for (var i = 0; i < _len; ++i)
{	
	part_particles_create(global.particle_systems[row], _x + lengthdir_x(i, _ang), _y + lengthdir_y(i, _ang), trail, 1);
}

if (CheckCollisions(x, y, oSolidParent, row))
{
	instance_destroy();	
}