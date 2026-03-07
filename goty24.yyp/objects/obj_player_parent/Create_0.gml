hp_max = 20;
hp_current = hp_max;
//hp_current = 1;
z = 0;

my_name = "P1"
player_number = 1;


//pull your number of lives from obj_game when you're created and store it 
player_lives = obj_game.player_1_lives;
respawn_frames_max = 180;
respawn_frames_current = respawn_frames_max;
fade_out_frames = 100;
blinking = false;

has_control = true;
//has_control = false;
walk_speed	= 20;
run_speed	= 40;
dash_frames_max = 30;
dash_frames_cur = dash_frames_max;
dashing = false;

grabbing_enemy = false;

move_direction = 0;
move_speed = walk_speed;
x_speed = 0;
y_speed = 0;
z_speed = 0;

grav = 2;
//grav = 0.06;
can_jump = 0;
jump_amount = 32;
jump_ascending = false;

in_the_air = false;
climbing = false;

facing = 1;
z = 0;
z_previous = 0; //needed to determine if player jumping up or falling down
z_floor = 0; //determine floor in z-axis for collisions
height = 48;

state = player_state_stand_free;
state_name = "";
flash = 0;
//save the current hitbox into an instance variable so it can be modified in other events (moving air attacks,etc)
current_hitbox = noone;

last_hit_from = RIGHT_SIDE;
stun = 0;
hard_knockdown_max = 30;
hard_knockdown_timer = hard_knockdown_max;

//set default sprites and collision mask
//sprite_idle = spr_brawler_girl_idle;
sprite_idle = spr_teen_guy_idle_2;
sprite_jump = spr_brawler_girl_jump_3;
//sprite_walk = spr_brawler_girl_walk;
sprite_walk = spr_teen_guy_run_2;
sprite_run = spr_brawler_girl_run;
//sprite_shadow = spr_shadow;
sprite_shadow = spr_shadow_3;
sprite_hit = spr_brawler_girl_hurt;
sprite_down = spr_brawler_girl_down;
sprite_dead = spr_brawler_girl_ko_2;

//mask_index = spr_brawler_girl_idle;
mask_index = spr_teen_guy_idle_b;


//color_mod = ColorModFromSprite(spr_brawler_girl_pallet_1,0,true);
var c1 = #eb2464;
var c2 = #D8A1B3;
var c3 = #24EBAB;
var c4 = #A1D8C6;
var c5 = #000000;
var c6 = #D68A52;
var c7 = #6F6666;
var c8 = #FFFFFF;
color_mod = new ColorMod([c1,c2,c5,c6,c7,c8]);
color_mod.PaletteAdd("default",[c1,c2,c5,c6,c7,c8]);
color_mod.PaletteAdd("P1",[c1, c2, c5,c6,c7,c8]);
color_mod.PaletteAdd("P2",[c3, c4, c5,c6,c7,c8]);
pallet = "P1";


/// Step 1: Create a ColorMod struct at the start of the game
///     global.colorModForPlayer = ColorMod([#a084f1, #8966ea, #6759a4, #524280]);
/// 
/// Step 2: Adds palettes to the ColorMod struct
///     global.colorModForPlayer.PaletteAdd("green", [#82cc71, #68b656, #539f42, #479234]);
///     global.colorModForPlayer.PaletteAdd("blue",  [#2aaaf3, #249ee3, #2992ce, #1f7db3]);
/// 
/// Step 3: In a Draw event, set the ColorMod shader, draw a sprite, then reset the shader
///     global.colorModForPlayer.SetShader(paletteName);
///     draw_sprite(sPlayer, 0, x, y);
///     shader_reset();

//create your hurtbox
my_body_hurtbox_x_offset = -1;
my_body_hurtbox = hurtbox_create(120,280);

//no longer needed Sequence based
/*
init_animation();
hitbox = -1;
hurtbox = -1;
*/


//set attack values (change to structs)
attack_stand_1_damage = 3;
attack_stand_1_knockback = 2;
attack_stand_1_hit_spark_x = 30;
attack_stand_1_hit_spark_y = 30;

attack_dash_1_damage = 6;
attack_dash_1_knockback = 6;
attack_dash_1_hit_spark_x = 25;
attack_dash_1_hit_spark_y = 10;

special_attack = false;
//get_player_input(player_number);


//state = player_state_spawning;

//animation based attack data
//save the current hitbox into an instance variable 
//so it can be modified in other events (moving air attacks,etc)
hitbox_inst = noone;
//sprite_attack_stand_1 = spr_teen_guy_sword_1b;
//sprite_attack_stand_1_hitbox = spr_teen_guy_sword_1b_hb;

sprite_attack_stand_1_A = spr_teen_guy_stand_sword_1_A;
sprite_attack_stand_1_A_hitbox = spr_teen_guy_stand_sword_1_A_hb;

sprite_attack_stand_1_B = spr_teen_guy_stand_sword_1_B;
sprite_attack_stand_1_B_hitbox = spr_teen_guy_stand_sword_1_B_hb;

sprite_attack_stand_1_C = spr_teen_guy_stand_sword_1_C;
sprite_attack_stand_1_C_hitbox = spr_teen_guy_stand_sword_1_C_hb;