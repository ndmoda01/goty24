/// @description Insert description here


// Inherit the parent event
event_inherited();

if (hp_current <= 0) activated = true;

//activate 
if (activated == true){ 
	//change to animated flashing barrel
	image_speed = 1;
	sprite_index = spr_exploding_barrel_activated;
	explode_timer--;
}

//if (explode_timer <= 0) and (active_sequence == -1) and (exploded == false){
	//start_animation(seq_barrel_explosion,Xobj_hitbox_hazard,Xobj_hurtbox_hazard);
	//exploded = true;
//}

//if you're not enabled due to an animation, check to see if its done
//get restored and destroy your sequence
//if (actor_enabled == false) and (exploded == true){
	//check_animation_end();
//}

//if you've been reenabled and exploded, then destroy yourself
//if (actor_enabled == true) and (exploded == true){
	//instance_destroy();
//}