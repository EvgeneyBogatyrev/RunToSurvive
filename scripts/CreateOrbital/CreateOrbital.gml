function CreateOrbital(_host, _speed, _dist, _type){
	
	Print(_host);
	var _new_orbital = Create(_host.x, _host.y, _type, _host.row).id;
	with(_new_orbital)
	{
		host = _host;
		rotation_speed = _speed;
		distance_to_host = _dist;
	}
	
	var _orbital_count = array_length(_host.connected_orbitals);
	_host.connected_orbitals[_orbital_count++] = _new_orbital;
	
	
	var _angle_between = 360 / _orbital_count;
	
	for (var _i = 0; _i < _orbital_count; _i++)
	{
		var _orb = _host.connected_orbitals[_i];
		_orb.angle = _angle_between * _i;
	}
	
}

function UpdateOrbitals(_host)
{
	var _orbital_count = array_length(_host.connected_orbitals);
	var _filtered_orbitals = [];
	for (var _i = 0; _i < _orbital_count; _i++)
	{
		if (instance_exists(_host.connected_orbitals[_i]))
		{
			_filtered_orbitals[array_length(_filtered_orbitals)] = _host.connected_orbitals[_i];
		}
	}
	_host.connected_orbitals = _filtered_orbitals;
	_orbital_count = array_length(_host.connected_orbitals);
	if (_orbital_count <= 0) return;
	
	var _angle_between = 360 / _orbital_count;
	
	for (var _i = 0; _i < _orbital_count; _i++)
	{
		var _orb = _host.connected_orbitals[_i];
		_orb.angle = _angle_between * _i;
	}
	
}