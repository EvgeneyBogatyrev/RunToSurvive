globalvar item_description;

item_description = [
{	
	item_id : DRILL_INUMBER,
	gun_state : Gun.DRILL,
	item_name : "Drill",
	description : "Default meele weapon. Deals 1 damage."
},
{
	item_id : STDGUN_INUMBER,
	gun_state : Gun.STANDART_GUN,
	item_name : "Blaster",
	description : "Spend 1 energy to deal 2 damage."
},
{
	item_id : SHOTGUN_INUMBER,
	gun_state : Gun.SHOTGUN,
	item_name : "Rapid gun",
	description : "Spend 4 energy to shoot 4 bullets that deal 2 damage."
},
{
	item_id : POWERGUN_INUMBER,
	gun_state : Gun.POWERGUN,
	item_name : "Charge gun",
	description : "Scalable weapon. Hold shoot to charge it."
},
{
	item_id : ROCKET_LAUNCHER_INUMBER,
	gun_state : Gun.ROCKET_LAUNCHER,
	item_name : "Rocket launcher",
	description : "Spend 3 energy to shoot 5 auto-aiming rockets."
},
{
	item_id : LIFESTEAL_GUN_INUMBER,
	gun_state : Gun.LIFESTEAL_GUN,
	item_name : "Healing gun",
	description : "Spend 2 energy to deal 3 damage and heal you by 1."
},
{
	item_id : REALSHOTGUN_GUN_INUMBER,
	gun_state : Gun.REAL_SHOTGUN,
	item_name : "Shotgun",
	description : "Spend 1 energy to shoot 4 one-damage bullets in various directions."
},
{
	item_id : ELECTRIC_GUN_INUMBER,
	gun_state : Gun.ELECTRIC_GUN,
	item_name : "Electric gun",
	description : "Hold shoot to create electrical bolts in front of you."
},
{
	item_id : ROCKETBOOTS_INUMBER,
	item_name : "Rocket boots",
	description : "Jump height increases."
},
{
	item_id : LIGHTNINGBOOTS_INUMBER,
	item_name : "Lightninig boots",
	description : "Run speed increases.",
},
{	
	item_id : FORCEFIELD_INUMBER,
	item_name : "Force field headphones",
	description : "Prevent the next hit you take."
},
{
	item_id : ENERGYFIST_INUMBER,
	item_name : "Energy fist",
	description : "Increases energy gain from energy stations."
},
{
	item_id : DOUBLEHEART_INUMBER,
	item_name : "Second heart",
	description : "Your healing is increased by 50%."
},
{
	item_id : CRUSH_INUMBER,
	item_name : "Crush",
	description : "Drill deals 1-3 damage."
},
{
	item_id : BATTERY_INUMBER,
	item_name : "Battery",
	description : "Restores energy."
},
{
	item_id : HEARTH_INUMBER,
	item_name : "HP",
	description : "Heals you."
},
{
	item_id : ESSENCE_INUMBER,
	item_name : "Essence",
	description : "Your friend's soul."
},
{
	item_id : CHARGING_GUN_INUMBER,
	gun_state : Gun.CHARGING_GUN,
	item_name : "Charging gun",
	description : "Spend 2 energy to deal 3 damage or charge it to deal 7 damage."
},
{
	item_id : SHIELD_MELEE_INUMBER,
	gun_state : Gun.SHIELD_MELEE,
	item_name : "Shield",
	description : "A melee weapon that deals 1 damage and knocks back enemies."
},
{
	item_id : DRONE_INUMBER,
	item_name : "Rocket Drone",
	description : "While shooting you can fire an aditional missile."
},
{
	item_id : BURN_INUMBER,
	item_name : "Incendium",
	description : "Your bullets causes burn."
},
{
	item_id : INFINITYGUN_INUMBER,
	item_name : "Gun configurator",
	description : "Whenever you are out of energy, take 20 damage and equip a random half-charged gun."
},
];

function GetGunStateFromID(_INUMBER)
{
	for (var _i = 0; _i < array_length(item_description); _i++)
	{
		if (item_description[_i].item_id == _INUMBER)
		{
			return struct_get(item_description[_i], "gun_state");
		}
	}
	return undefined;
}