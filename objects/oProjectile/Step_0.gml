if (abs(x - oCamera.x) > oCamera.view_w_half * 3)  instance_destroy();

if (CheckCollisions(x + xspeed, y, oEnemyParent, row))
{
	var _victim = GetCollider(x + xspeed, y, oEnemyParent, row);
	if (_victim.state != UniversalStates.DEAD && _victim.state != HalfBossStates.INACTIVE && _victim.hp > 0) 
	{
		_victim.hp -= damage;
		display = true;
		_victim.hit_flash = 3;
	
		while(!CheckCollisions(x + sign(xspeed), y, oEnemyParent, row))	x += sign(xspeed);		
	
		if (object_is_ancestor(_victim.object_index, oHalfBossParent) && _victim.state != UniversalStates.DEAD)  StartBattle(row, host, _victim);
		instance_destroy();	
	}
}

if (CheckCollisions(x + xspeed, y, oSolidParent, row) || CheckCollisions(x + xspeed / 2, y, oSolidParent, row))
{
	while(!CheckCollisions(x + sign(xspeed), y, oSolidParent, row))	
		x += sign(xspeed);

	instance_destroy();
}

if (place_meeting(x + xspeed, y, oDelver) && oDelver.state == DelverStates.INSECT)
{
	repeat (abs(xspeed))
	{
		if (place_meeting(x + sign(xspeed), y, oDelver))  break;
		x += sign(xspeed);
	}
	oDelver.hp -= damage;
	oDelver.hit_flash = 3;
	display = true;
	instance_destroy();	
}


event_inherited();

if (image_index == 1)  image_speed = 0;


