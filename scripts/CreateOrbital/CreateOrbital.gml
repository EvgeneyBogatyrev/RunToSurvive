function CreateOrbital(_host, _speed, _dist){
	with(Create(_host.x, _host.y, oOrbital, _host.row))
	{
		host = _host;
		rotation_speed = _speed;
		distance_to_host = _dist;
	}
}