if (screen_pause()) exit;

var _hit_by_attack_this_frame = ds_list_create(); //store all instances hit this frame into list
var _hits = instance_place_list(x,y,obj_hurtbox_parent,_hit_by_attack_this_frame,false);
var _damage = damage; //make it a local variable to pass to victim's with statement
var _facing = sign(image_xscale)*-1;
var _knockback = knockback;
var _hit_spark_x = x+hit_spark_x;
var _hit_spark_y = y-hit_spark_y;
var _stun = stun;

//if you've hit something this frame
if (_hits > 0){
	//check each hit and then process them
	for (var i=0; i <_hits; i++){
		//if this instance hasn't been hit by this attack yet
		var _hurtbox_id = _hit_by_attack_this_frame[| i];
		var _hurtbox_owner = _hurtbox_id.owner;
		
		//prevents the instance that is attacking from hitting itsself 
		//if (_hurtbox_owner == owner) exit;
		//prevents the instance that is attacking from hitting same objects
		//if (_hurtbox_owner.object_index == owner.object_index) exit;
		
		#region Player VS Enemy (hitbox owner exists)
		//confirm that both the hurtbox owner and hitbox owner still exsist before enering
		if (instance_exists(_hurtbox_owner) and instance_exists(owner)){
			//prevents the instance that is attacking from hitting same objects with same parent
			//this works, but if player is overlapping enemy, other enemy hits might not connect
			//if (object_get_parent(_hurtbox_owner.object_index) == object_get_parent(owner.object_index)) exit;
		
			//get a -1 if it's not in the list for this attack
			if (ds_list_find_index(hit_by_attack, _hurtbox_owner) == -1){
				//if it wasn't in there, add it, then apply the effect you want
				ds_list_add(hit_by_attack,_hurtbox_owner);
			
				//check to confirm the owner is within range to be hit
				if (instance_exists(owner)) and (abs(owner.y - _hurtbox_owner.y) <= attack_depth_range){
					
					//prevents the instance that is attacking from hitting same objects with same parent
					//this works, but if player is overlapping enemy, other enemy hits might not connect
					if (object_get_parent(_hurtbox_owner.object_index) == object_get_parent(owner.object_index)) exit;
					
					//increase hits landeded to show this attack has hit
					hits_landed++;
					
					//if they are in range, then apply the attack
					with(_hurtbox_owner){
						hp_current -= _damage;
						flash = 3;
						stun = _stun;
						
						facing = _facing; //turn to face who hit you
						last_hit_from = _facing;
						
						//check to see if there is a wall you could be knocking them into
						var _knockback_dest = x-_knockback*facing;
						//if there is no wall there, apply knockback
						if (!place_meeting(_knockback_dest,y,obj_wall)) x -= _knockback*facing; 
						
						
						var _hit_spark = instance_create_depth(_hit_spark_x,_hit_spark_y,-2000,obj_animated_effect);
						_hit_spark.sprite_index = spr_hit_spark;
						_hit_spark.image_angle = irandom(360);
						//audio_play_sound(snd_player_hit,2,false);
						if (object_is_ancestor(object_index,obj_player_parent)) state = player_state_hit;
						if (object_is_ancestor(object_index,obj_enemy_parent)){
							
							//if you're out of hitpoints, go straight to die
							if (hp_current <= 0) {
								if (state != enemy_state_dead) state = enemy_state_dead;
								last_hit_from = _facing;
								exit;
							}
							//otherwise get hit
							else {
									instance_destroy();
									//if (other.hard_knockdown == false) state = enemy_state_stand_hit;
									//if (other.hard_knockdown == true) state = enemy_state_hard_knockdown;
							}
							
						}
					}
				}
			}
		}
		#endregion
		
		#region Enviornment VS Everyone (hitbox owner doesn't exist)
		if (instance_exists(_hurtbox_owner) and (owner == noone)){	
			
	
		
			//get a -1 if it's not in the list for this attack
			if (ds_list_find_index(hit_by_attack, _hurtbox_owner) == -1){
				//if it wasn't in there, add it, then apply the effect you want
				ds_list_add(hit_by_attack,_hurtbox_owner);
			
				//check to confirm the owner is within range to be hit
				//currently this depth check doesn't work well due to it not having a good
				//origin location for the attacker's y. Just remove the check for now
				//if (abs(bbox_bottom - _hurtbox_owner.y) <= attack_depth_range){
					
					//increase hits landeded to show this attack has hit
					hits_landed++;
					
					//if they are in range, then apply the attack
					with(_hurtbox_owner){
						hp_current -= _damage;
						flash = 3;
						stun = _stun;
						
						if (x <= other.x) _facing = 1;
						if (x > other.x) _facing = -1;
						
						facing = _facing; //turn to face who hit you
						last_hit_from = _facing;
						
						//check to see if there is a wall you could be knocking them into
						var _knockback_dest = x-_knockback*facing;
						//if there is no wall there, apply knockback
						if (!place_meeting(_knockback_dest,y,obj_wall)) x -= _knockback*facing;
					
						//if you're in the air, pop up a little bit to keep the juggle going
						if (in_the_air == true) z_speed-=2;
						
						//var _hit_spark = instance_create_depth(_hit_spark_x,_hit_spark_y,-2000,obj_effect);
						//_hit_spark.sprite_index = spr_hit_spark;
						//_hit_spark.image_angle = irandom(360);
						//play hit sound if you're not playing it already
						if (!audio_is_playing(snd_player_hit)) audio_play_sound(snd_player_hit,2,false);
						
						//hitting a player
						if (object_is_ancestor(object_index,obj_player_parent)) {
							if (other.hard_knockdown == false) state = player_state_hit;
							if (other.hard_knockdown == true) state = player_state_hard_knockdown;
						}
						
						//hitting an enemy
						if (object_is_ancestor(object_index,obj_enemy_parent)){
							
							//if you're out of hitpoints, go straight to die
							if (hp_current <= 0) {
								if (state != enemy_state_dead) state = enemy_state_dead;
								last_hit_from = _facing;
								exit;
							}
							//otherwise get hit
							else {
									if (other.hard_knockdown == false) state = enemy_state_stand_hit;
									if (other.hard_knockdown == true) state = enemy_state_hard_knockdown;
							}	
						}
					}
				//}
			}
		}
		#endregion
		
	}
}
	
ds_list_destroy(_hit_by_attack_this_frame);