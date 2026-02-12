hp_max = 1;
hp_current = hp_max;
z = 0;
climbing = false;

facing = RIGHT;

flash = 0;
state = enemy_state_stand_free;
dead = false;

target_player = noone;
activate_delay = 0;

target_attack_side = RIGHT;
target_x = x;
target_y = y;


//movement variables
move_speed = 1;
chase_speed = .5;
move_direction = 0;
grav = 0.32; //0.4;
x_speed = 0;
y_speed = 0;
z_speed = 0;
z_floor = 0;
in_the_air = false;



//combat variables
attack_range = 15;
last_hit_from = RIGHT;
stun = 0;
hard_knockdown_max = 30;
hard_knockdown_timer = hard_knockdown_max;

//attack specific variables
attack_1_damage = 1;
attack_1_knockback = 1;
attack_1_hit_spark_x = 30;
attack_1_hit_spark_y = 30;


//set default sprites
sprite_hit			= spr_enemy_punk_guy_hurt_2;
sprite_idle			= spr_enemy_punk_guy_idle;
sprite_shadow		= spr_shadow;
sprite_shadow_long	= spr_shadow_long;
sprite_walk			= spr_enemy_punk_guy_walk;
sprite_attack_1		= spr_enemy_punk_guy_punch_2;
sprite_dead			= spr_enemy_punk_guy_dead;

color_mod = ColorModFromSprite(spr_enemy_punk_guy_pallet_1,0,true);
pallet = 0;
pallet = irandom(4);


fade_out = false;
fade_out_counter = 105;

//create your hurtbox
my_body_hurtbox_x_offset = 1;
my_body_hurtbox = noone;





//enemy ai

move_timer = 60 * 2;	// time until movement recalculates
move_target_x = xstart;
move_target_y = ystart;
can_attack = false;
