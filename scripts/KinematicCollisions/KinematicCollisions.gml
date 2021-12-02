///@desc KinematicCollisions()
function KinematicCollisions() {

	/// Apply all physics to any colliding objects

	///!!! This function is not complete !!!

	var colliding_objects_list = ds_list_create();
	var amount_of_objects = instance_place_list(x, y, oKinematicObject, colliding_objects_list, true);

	repeat (amount_of_objects) 
	{
		var _object = ds_list_find_value(colliding_objects_list, 0);
		ds_list_delete(colliding_objects_list, 0);
	
		if (ds_list_find_index(colliding_objects_list, _object) != -1)	
			continue;	

	
		var theta = GetAngleFromTheVector(_object.x - x, _object.y - y);
		var alpha1 = GetAngleFromTheVector(xspeed, yspeed);
		var alpha2 = GetAngleFromTheVector(_object.xspeed, _object.yspeed);
	
		var m1 = mass;
		var m2 = _object.mass;
	
		var E = 0.1;
		xspeed += choose(-1, 1) * E;
		yspeed += choose(-1, 1) * E;
		_object.xspeed += choose(-1, 1) * E;
		_object.yspeed += choose(-1, 1) * E;
	
	
		var V1x = xspeed * cos(alpha1 - theta);
		var V1y = yspeed * sin(alpha1 - theta);
		var V2x = _object.xspeed * cos(alpha2 - theta);
		var V2y = _object.yspeed * sin(alpha2 - theta);
	
		
		var U1x = V1x * (m1 - m2) / (m1 + m2) + V2x * 2 * m2 / (m1 + m2);
		var U2x = V2x * (m2 - m1) / (m1 + m2) + V1x * 2 * m1 / (m1 + m2);
		var U1y = V1y;
		var U2y = V2y;
	
		xspeed = U1x * cos(theta) - U1y * sin(theta);
		yspeed = U1x * sin(theta) + U1y * cos(theta);
		_object.xspeed = U2x * cos(theta) - U2y * sin(theta);
		_object.yspeed = U2x * sin(theta) + U2y * cos(theta);
	
	
		/*
		repeat(100) 
		{
			if (place_meeting(x, y, _object)) {
				x += sign(x - _object.x);
				y += sign(y - _object.y);
				_object.x -= sign(x - _object.x);
				_object.y -= sign(y - _object.y);
		
			} else {
				break;
			}
		}*/
	
		with(_object) 
		{
			ds_list_add(already_checked, other.id);	
		}
	
	}


}
