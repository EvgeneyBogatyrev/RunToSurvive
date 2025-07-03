enabled = false;

history = ds_list_create();
cmd_history = ds_list_create();

cmd_queue = ds_list_create();



commands = 
{
	"hp" : function (_args) { oPlayer.hp = int64(_args[0]) },
	"ammo" : function(_args) { oPlayer.bullets = int64(_args[0]) },
	"gun" : function(_args) { oPlayer.gun.current_gun = int64(_args[0]); },
	"boss" : function(_args) { array_insert(oBossControl.tmp_bosses_array, 0, _args[0]); },
	"bossbegin" : function(_args) { oBossControl.timer = 0; },
	"spawnitem" : function(_args) {
		with (Create(oCamera.right, oGenerator.ground[0] - 100, oItemDrop, 0))
		{
			depth -= 2;
			image = int64(_args[0]);
		}
	},
}