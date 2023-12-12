function Scale() {

	var _scale = scale;
	image_blend = make_color_hsv(0, 0, abs(_scale) * (255 / (SCALE_TWO + 0.05)));
	switch (sprite_index)
	{
		case sDryTree:
		case sGravestone:
		case sPandoraBoxBlink:
		case sPandoraBoxSpawn:
		case sPandoraGauntlet:
		case sPandoraTransform:
		case sPandoraEye:
		case sFloatingEye:
		case sFloatingEyeDie:
		case sThunder:
		case sDelverStand:
		case sDelverAttack:
		case sDelverCasting:
		case sDelverTransform:
		case sDelverZap:
		case sDelverInsect:
		case sDelverInsectAttack:
		case sDelverDying:
		case sShootingRobot:
			_scale -= 0.2;
			break;
	}

	image_xscale = dir * _scale;
	image_yscale = _scale;



}
