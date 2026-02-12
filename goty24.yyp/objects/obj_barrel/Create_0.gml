// Inherit the parent event
event_inherited();

height = 26 *(image_yscale);

hp_max = 5;
hp_current = hp_max;

image_speed = 0;

//create your hurtbox
my_body_hurtbox_x_offset = -1;
my_body_hurtbox = hurtbox_create(20,38);

my_loot = noone;