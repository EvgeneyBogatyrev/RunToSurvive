///@desc GetScale(row)
///@argc row
function GetScale() {

	///Get proper scale

	var _row = argument[0];

	if (argument_count > 1 && argument[1]) 
	{
		depth = - 100 * _row;
	}

	switch (_row) 
	{
		case 0:
			return SCALE_ZERO;
		case 1:
			return SCALE_ONE;
		case 2:
			return SCALE_TWO;
		default:
			Raise("Cannot find scale for the row number " + string(_row) + "\n");
			break;
	}


}
