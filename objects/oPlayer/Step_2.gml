/// @description
event_inherited();

if (x > oCamera.right + CAMERA_BOUNDS && state != PlayerStates.TRAPPED)
{
	x = oCamera.right + CAMERA_BOUNDS;	
}


if (should_update_orbitals)
{
	UpdateOrbitals(id);
	should_update_orbitals = false;
}

if (hp < prev_hp && hp > 0 && hp < maxhp)
{
	for (var i = 0; i < array_length(onHurtEvent); i++)
	{
		onHurtEvent[i](id, prev_hp - hp);
	}
}

prev_hp = hp;


if (name == "Cyber")
{
	var _maxbullets_diff = maxbullets - previous_maxbullets;
	var _bullet_diff = bullets - previous_bullets;
	
	hp += _bullet_diff;
	bullets = hp;
	
	maxhp += _maxbullets_diff;
	maxbullets = maxhp;
}