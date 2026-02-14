// Inherit the parent event
event_inherited();

height = 26;

hp_max = 1;
hp_current = hp_max;

activated = false;
explode_timer = SEC*1;
exploded = false;

image_speed = 0;

//create your hurtbox
my_body_hurtbox_x_offset = -1;
my_body_hurtbox = hurtbox_create(20,38);

my_loot = noone;

//no longer needed
//init_animation();