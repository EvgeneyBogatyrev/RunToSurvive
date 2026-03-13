/// @description
event_inherited();

state = HalfBossStates.IDLE;
crowned = false;
knockbacked = false;
can_be_knockbacked = false;

hit_flash = 0;

is_invincible = false;

last_inflictor = undefined;
on_kill_events_done = false;

status_effects = {}

// Fire
on_fire = 0;
fire_x_shift = 0;
fire_y_shift = 0;

// HP & BULLETS gain
refreshed = false;


// Wildvines
wildvines_timer = 0;