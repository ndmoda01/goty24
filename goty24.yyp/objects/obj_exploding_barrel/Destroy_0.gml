if (instance_exists(my_body_hurtbox)) instance_destroy(my_body_hurtbox);

if (my_loot != noone){
	instance_create_layer(x,y,"Instances",my_loot);	
}

var _exp_offset =  32;



//audio_play_sound(snd_barrel_explode,5,false);


//var _hb = instance_create_layer(x,y-_exp_offset,"Instances",obj_hitbox_parent);
//_hb.sprite_index = spr_explosion_hitbox_2;

//_hb.damage = 5;
//_hb.owner = noone;
//_hb.knockback = 10;
//_hb.hard_knockdown = true;

//explosion sprite
/*
var _exp = instance_create_layer(x,y-_exp_offset,"Instances",obj_animated_effect);
_exp.sprite_index = spr_large_explosion;
_exp.image_xscale = 8;
_exp.image_yscale = 8;
_exp.depth = -bbox_bottom;

