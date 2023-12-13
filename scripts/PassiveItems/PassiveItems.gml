function Piss()
{
	Print("piss");
}

function Shit()
{
	Print("shit");
}

globalvar passive_items_profiles;
passive_items_profiles = 
[
	{
		name : "Lightning Strike",
		icon_index : 0,
		on_hit : function(_host, _x_offset = 0)
		{
			var _chance = random(1);
			if (_chance < 0.2)
			{
				with(Create(_host.x + _x_offset, _host.y, oThunder, _host.row))
				{
					host = _host.host;
				}
			}
		}
	},
	
	{
		name : "Suspicious Eye",
		icon_index : 1,
		on_hurt : function(_host)
		{
			var _amount = irandom_range(2, 4);
			
			for (var _i = 0; _i < _amount; _i++)
			{
				with(Create(_host.x, _host.y,  oFloatingEye, _host.row))
				{
					
				}
			}
		}
	}
]

