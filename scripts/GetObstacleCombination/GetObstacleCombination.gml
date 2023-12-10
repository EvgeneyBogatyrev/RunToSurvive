///@desk GetObstacleCombination(forbidden[0...5])
///@argc forbidden[0...5]
function GetObstacleCombination(argument0, argument1) {

	///Get one possible combination of obstacles.

	var _forbidden = argument0;
	var _previous  = argument1;

	Assert(_forbidden[0] == 0, "Cannot forbid an empty space\n");

	enum Obstacles 
	{
		EMPTY = 0,
		BIG = 1,
		SMALL = 2,
		BLOCKS = 3,
		AREA = 4,
		CHARGE_STATION = 5,
	};

	var _chance_of_occurance = [6, 11, 12, 10, 6, 4];


	var _pool;
	var _counter = 0;
	for (var i = 0; i < 6; ++i)
	{
		//if (!_forbidden[i]) 
		//{
		for (var j = 0; j < _chance_of_occurance[i]; ++j)   _pool[_counter++] = i;
		//}
	}

	if (_counter == 1)  return array_create(3, Obstacles.EMPTY);

	var _result = array_create(3, Obstacles.BIG);

	while (_result[0] == _result[1]  && _result[1] ==  _result[2] && _result[2] == Obstacles.BIG)
	{
		for (var i = 0; i < 3; ++i) 
		{
			do 
			{
				_result[i] = _pool[irandom_range(1, _counter - 1)];
			
				if (i > 0 && _result[i] == Obstacles.BLOCKS)
				{
					var _flag = false;
					for (var j = i - 1; j >= 0; --j)	
					{
						if (_result[j] == Obstacles.SMALL)	
						{
							_flag = false;
							break;
						}
					}
					if (_flag)  continue;
				}
			
				if (_result[i] == Obstacles.AREA && _previous[i] == Obstacles.CHARGE_STATION)  continue;
			
			} until (_result[i] != _previous[i]);
		}
	}
	
	// Remove forbidden obstacles
	for (var i = 0; i < 3; ++i)
	{
		if (_forbidden[_result[i]])
		{
			_result[i] = 0;	
		}
	}

	return _result;


}
