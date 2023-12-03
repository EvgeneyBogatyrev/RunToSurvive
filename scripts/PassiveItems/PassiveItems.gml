function Piss()
{
	Print("piss");
}

function Shit()
{
	Print("shit");
}

function LightningStrike()
{
	var _chance = random(1);
	if (_chance < 0.2)
	{
		with(Create(x, y, oThunder, row))
		{
			host = other.host;
		}
	}
}