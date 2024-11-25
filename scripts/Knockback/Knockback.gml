///@desc Knockback Target
///@param object
///@param speed coeff
function Knockback() {

	var _victim = argument[0];
	var _k = argument[1];

	if (_victim == noone)  exit;

	with (_victim)
	{
		if (!knockbacked)	
		{
			xspeed += other.xspeed * _k;	
			knockbacked = true;
			knockback_timer = 15;
		}
	}


}

function KnockbackForce(_victim, _force_x, _force_y) {


	if (_victim == undefined)  exit;

	with (_victim)
	{
		if (!knockbacked)	
		{
			xspeed += _force_x;
			yspeed += _force_y;
			knockbacked = true;
			knockback_timer = 15;
		}
	}


}
