// Inherit the parent event
event_inherited();

//set your specific variables
hp_current = 40;

//set your specific sprites
sprite_hit = spr_enemy_punk_guy_hurt_2;
sprite_idle = spr_teen_wolf_idle;
sprite_shadow = spr_shadow_3;
sprite_walk = spr_teen_wolf_walk;
sprite_attack_1 = spr_enemy_punk_guy_punch_2;


//inactive waiting to move into a BR
if (place_meeting(x,y,obj_battle_region)) state = enemy_state_br_spawn_wait;
//inactive but outside a BR
else {
	//state = enemy_state_inactive;
	my_body_hurtbox = hurtbox_create(170,300);
}

//color_mod = ColorModFromSprite(spr_enemy_punk_guy_pallet_1,0,true);
