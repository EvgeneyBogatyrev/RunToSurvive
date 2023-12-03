if (prev_player_x == noone || player == noone || !instance_exists(player))
{
	player = GetPlayer(PlayerPreferences.RANDOM);
	if (player == noone)
	{
		exit;	
	}
	prev_player_x = player.x;
}

spawn_timer--;
if (spawn_timer <= 0) 
{
	spawn_timer = spawn_timer_max;
	
	if (player == noone)
	{
		exit;	
	}
	
	var spawn_block = noone;
	var closest_distance = -1;
	
	for (var i = 0; i < instance_number(oBlock); ++i;)
	{
	    var cur_block = instance_find(oBlock, i);
		if (cur_block.row != player.row)
		{
			continue;	
		}
		var cur_distance;
		with (cur_block)
		{
			cur_distance = distance_to_point(other.player.x + other.predict_scale * (other.player.x - other.prev_player_x), other.player.y);	
		}
		if (closest_distance == -1 || closest_distance > cur_distance)
		{
			closest_distance = cur_distance;
			spawn_block = cur_block;
		}
	}
	
	if (spawn_block != noone)
	{
		Create(spawn_block.x, spawn_block.y, oWildvine, spawn_block.row);	
	}
	player = noone;
} 
else 
{
	prev_player_x = player.x;
}