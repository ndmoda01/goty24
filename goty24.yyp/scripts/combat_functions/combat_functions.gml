#region Sequence attack fucntions
/* Sequcenced based code, can be removed
//attack sequence functions
function init_animation(){
	//this function is called in create event of any actor that will use sequences 
	//establishing animation variables and functions for sequence playback 
	//ideally these same scripts will be usable by players, enemies, and level hazards

	//initialize animation related varaibles
	actor_enabled = true;
	active_animation = -1;
	sequence_layer = -1; //should this be set to undefined instead of -1?
	active_sequence = -1;

	//////////////////////////////////////////////
	//Enable actor's movement and make actor visible
	function enable_actor() 
	{
		actor_enabled = true;
		has_control = true;
		image_alpha = 1;
	}
	
	//////////////////////////////////////////////
	//Disable actor's movement and make actor invisible
	function disable_actor() 
	{
		actor_enabled = false;
		has_control = false;
		image_alpha = 0;
	}
	
	//////////////////////////////////////////////
	//start animation by creating a new layer for the sequence to play on
	//play the sequence, then override the hitbox and hurtbox objects created by sequence
	function start_animation(_sequence,_actor_hitbox,_actor_hurtbox) 
	{
		active_animation = _sequence;
		sequence_layer = layer_create(depth);
		active_sequence = layer_sequence_create(sequence_layer, x, y, _sequence);
		layer_sequence_xscale(active_sequence, image_xscale);
		layer_sequence_yscale(active_sequence, image_yscale);
		
		var _seq_inst = layer_sequence_get_instance(active_sequence);
		//sequence_instance_override_object(_seq_inst, _attacker_hitbox, hitbox);
		//sequence_instance_override_object(_seq_inst, _attacker_hurtbox, hurtbox);

		//sequence_object_array = sequence_get_objects(active_animation);
		//if (sequence_object_array[0] == obj_hitbox_parent.object_index){
		//	sequence_object_array[0].damage_strength = _damage_strength;
		//}
		disable_actor();
	}
	
	//////////////////////////////////////////////
	//check to see if the sequence has completed, if it has, destroy it and the new layer
	//reset the animation and damage variables, then enable the player to move again
	function check_animation_end() 
	{
		if (active_sequence == undefined) return 1;
		
		var _xx = x;
		var _yy = y;

		layer_sequence_x(active_sequence, _xx);
		layer_sequence_y(active_sequence, _yy);
	
		if (layer_sequence_is_finished(active_sequence)) 
		{
			//destroy the newly created layer and sequence
			layer_sequence_destroy(active_sequence);
			layer_destroy(sequence_layer);
		
			//reset animation variables
			active_animation = -1;
			active_sequence = -1; //should this be set to undefined instead of -1?
			sequence_layer = -1;
			
			//reset damage variables 
			current_attack_damage = 0;
			current_attack_pushback = 0;
			
			enable_actor();
			
		}
	}
	
	//////////////////////////////////////////////
	//cancel the current sequence and enable the player to move again
	function cancel_animation()
	{
		if (active_sequence != undefined)
		{
			layer_sequence_destroy(active_sequence);
			layer_destroy(sequence_layer);
		
			active_animation = -1;
			active_sequence = -1; //should this be set to undefined instead of -1?
			sequence_layer = -1;
		
			enable_actor();
		}
	}
	
	//current attack variable
	//this variable will temporarily hold struct that has all attack data for the current attack (its damage, pushback, etc)
	//the hitbox will pull the data for the current attack from the struct stored in this variable
	//after the attack is over, the variable will all be reset (struct removed)
	current_attack = -1;
}

	
//attack data constructor
function attack(

	//default arguments (these will be used if not specific in the created struct)
	_name = "attack_1",
	_damage = 1,
	_knockback = 1,
	_stun = 1,
	_sequence = seq_teen_guy_stand_attack_1,
	_attack_depth_range = 10)
	
	constructor{
	
	//these variables will hold all of the data for each attack
	name = _name;
	damage = _damage;
	knockback = _knockback;
	stun = _stun;
	sequence = _sequence;
	attack_depth_range = _attack_depth_range;
	
}
*/
#endregion	

//attack data constructor
function attack(

	//default arguments (these will be used if not specific in the created struct)
	_name = "attack_1",
	_damage = 1,
	_knockback = 1,
	_stun = 1,
	_hb_sprite = spr_teen_guy_sword_1b_hb,
	_attack_depth_range = 10)
	
	constructor{
	
	//these variables will hold all of the data for each attack
	name = _name;
	damage = _damage;
	knockback = _knockback;
	stun = _stun;
	hitbox_sprite = _hb_sprite;
	attack_depth_range = _attack_depth_range;
	
}

function player_state_attack_stand_1(){
	//attack 1
	state_name = "attack_stand_1";
	
	//stop the player's momentem / movement during attack
	x_speed = 0;
	y_speed = 0;
	
	//if you are already attacking
	//need to check this first, so you can set it to be this sprite if it isn't
	if (sprite_index == sprite_attack_stand_1){
		///check for an additional attack input and confirm you are past the min frames to cancel (past the first frame in the jab sprite)
		//also check to see if the attack connected or not
		//if (key_attack){
		//if (input_check_pressed("attack",player_number)){
			//find your previous attack and check if it has connected
			//switch to next state and destroy the previous attack hitbox
			//if (instance_exists(current_hitbox) and (current_hitbox.hits_landed >=1)){
			//	instance_destroy(current_hitbox);
			//	state = player_state_attack_stand_2;	
			//}
		//}
	}
	
	//if you're on the ground, press attack, in free state (not already attacking), and not moving
	//this check keeps this code from repeating each step
	else {
	
		sprite_index = sprite_attack_stand_1;
		image_index = 0; //need to make sure you're starting from 0 so hitbox sync
	
		//might need to change attack to an object scope varaible, so it can be accessed below 
		hitbox_inst = instance_create_layer(x,y,"Instances",obj_hitbox_parent);
		//speed of attack sprite an hitbox sprite must be same speed and start from index 0
		//so that the sprites will be in sync
		hitbox_inst.sprite_index = sprite_attack_stand_1_hitbox;
		hitbox_inst.damage = attack_stand_1_damage;
		hitbox_inst.owner = id;
		hitbox_inst.knockback = attack_stand_1_knockback;
		hitbox_inst.hit_spark_x = attack_stand_1_hit_spark_x*facing;
		hitbox_inst.hit_spark_y = attack_stand_1_hit_spark_y;
		hitbox_inst.image_xscale = hitbox_inst.image_xscale*facing;
		hitbox_inst.stun = 15;
		
	}
	
	//reset back to idle if your animation would loop after this frame
	if (animation_end()){
		sprite_index = sprite_idle;	
		state = player_state_stand_free;
		hitbox_inst = noone;
	}
}
	
	
	
