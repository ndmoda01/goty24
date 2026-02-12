event_inherited();

//set your specific variables
hp_current = 40;

//set your specific sprites
sprite_hit = spr_enemy_punk_guy_hurt_2;
sprite_idle = spr_enemy_punk_guy_idle;
sprite_shadow = spr_shadow;
sprite_walk = spr_enemy_punk_guy_walk;
sprite_attack_1 = spr_enemy_punk_guy_punch_2;


color_mod = ColorModFromSprite(spr_enemy_punk_guy_pallet_1,0,true);

attack_1_knockback = 3;
attack_1_hit_spark_x = 36;
attack_1_hit_spark_y = 30;

//inactive waiting to move into a BR
if (place_meeting(x,y,obj_battle_region)) state = enemy_state_br_spawn_wait;
//inactive but outside a BR
else {
	//state = enemy_state_inactive;
	my_body_hurtbox = hurtbox_create(17,44);
}


//state = enemy_state_inactive;
//state = enemy_state_queuing;
