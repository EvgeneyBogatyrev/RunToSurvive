event_inherited();

switch (state)
{
	case VenusStates.IDLE:
		if (CheckCollisions(x, y, oPlayer, row))
		{
			state = VenusStates.CATCH;
			target = GetCollider(x, y, oPlayer, row);
			ContactDamage(25, 0);
		}
		break
	case VenusStates.CATCH:
		image_index = 1;
		break;
	default:
		instance_destroy();
		exit;
}
