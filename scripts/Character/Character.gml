// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GetSpritesFromName(_name)
{
	// Log all sprites so GameMaker does not remove it as unused
	var _player_sprites = [sKyronStand,sKyronIdle,sKyronRun,sKyronJump,sKyronDying,sKyronIcon,sKyronOutOfScreen,sKyronHands];
	_player_sprites = [sLongHairStand,sLongHairIdle,sLongHairRun,sLongHairJump,sLongHairDying,sLongHairIcon,sLongHairOutOfScreen,sLongHairHands];
	_player_sprites = [sSteampunkStand,sSteampunkIdle,sSteampunkRun,sSteampunkJump,sSteampunkDying,sSteampunkIcon,sSteampunkOutOfScreen,sSteampunkHands];
	_player_sprites = [sCyberStand,sCyberIdle,sCyberRun,sCyberJump,sCyberDying,sCyberIcon,sCyberOutOfScreen,sCyberHands];
	_player_sprites = [sBuruchIdle,sBuruchRun,sBuruchJump,sBuruchDying,sBuruchIcon,sBuruchOutOfScreen,sBuruchHands];
	_player_sprites = [sRoboStand,sRoboIdle,sRoboRun,sRoboJump,sRoboIcon,sRoboOutOfScreen,sRoboHands];
	
	var _stand = asset_get_index("s" + _name + "Stand");
	var _idle = asset_get_index("s" + _name + "Idle");
	var _run = asset_get_index("s" + _name + "Run");
	var _jump = asset_get_index("s" + _name + "Jump");
	var _die = asset_get_index("s" + _name + "Dying");
	var _icon = asset_get_index("s" + _name + "Icon");
	var _out = asset_get_index("s" + _name + "OutOfScreen");
	var _hands = asset_get_index("s" + _name + "Hands");
	
	
	return 
	{
		stand : sprite_exists(_stand) ? _stand : sKyronStand,
		idle : sprite_exists(_idle) ? _idle : sKyronIdle,
		run : sprite_exists(_run) ? _run : sKyronRun,
		jump : sprite_exists(_jump) ? _jump : sKyronJump,
		die : sprite_exists(_die) ? _die : sKyronDying,
		icon : sprite_exists(_icon) ? _icon : sKyronIcon,
		out : sprite_exists(_out) ? _out : sKyronOutOfScreen,
		hands : sprite_exists(_hands) ? _hands : sKyronHands
		
	}
	
	
}

function GetWeaponFromName(_name)
{
	switch (_name)
	{
		default:
			return Gun.DRILL;
		case "Steampunk":
			return Gun.STEAMPUNK_HAMMER;
	}
}

function Character(_name) constructor
{
	name = _name;
	
	sprites = GetSpritesFromName(_name);
	
	secondary_weapon = GetWeaponFromName(_name);
	
	passive_skill = undefined;
}


function SpawnPlayerCharacter(_player_id, _name, _x, _y, _row)
{
	
	var _player_instance = Create(_x, _y, oPlayer, _row);
	
	_player_instance.depth = -100 * _row - 2;
	_player_instance.character = new Character(_name);
	_player_instance._input_type = input_type[_player_id];
	_player_instance.name = _name;
	_player_instance.player_index = _player_id;
	
	return _player_instance;
	
}