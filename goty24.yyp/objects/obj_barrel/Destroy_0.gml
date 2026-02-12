/// @description Insert description here

if (instance_exists(my_body_hurtbox)) instance_destroy(my_body_hurtbox);

if (my_loot != noone){
	instance_create_layer(x,y,"Instances",my_loot);	
}

//audio_play_sound(snd_barrel_break,20,false);

var _bar = instance_create_layer(x,y,"Instances",obj_animated_effect);
//_bar.sprite_index = spr_barrel_2;
_bar.speed = .4;
_bar.direction = 270;
_bar.image_alpha = .8;
_bar.image_xscale = facing*-1;