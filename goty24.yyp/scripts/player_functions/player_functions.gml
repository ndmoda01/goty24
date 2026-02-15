function player_state_stand_free(){
	//default state (not attacking, not being hit, etc)
	state_name = "stand_free";
	
	player_movement_and_collisions();

	//sprite management
	//update facing direction for sprites
	if (x_speed != 0){
		facing = sign(x_speed);
		if (dashing) sprite_index = sprite_run;
		else sprite_index = sprite_walk;	
	}
	else if (y_speed != 0){
		if (dashing) sprite_index = sprite_run;
		else sprite_index = sprite_walk;	
	}
	else if (x_speed == 0){
		sprite_index = sprite_idle;	
	}

	//flip sprite based on direction (x width * facing direction)
	image_xscale = abs(image_xscale)*facing;
	
	//in the air
	if (in_the_air){	
		
		//set to jump sprite if it isn't already
		if (sprite_index != sprite_jump) sprite_index = sprite_jump;
		if (sprite_index == sprite_jump) and (image_index >= 1) image_speed = 0;
		
		//air attacks
		//if (key_attack){
		if (InputPressed(INPUT_VERB.ATTACK,player_number)){
			 //if (jump_ascending == true){ state = player_state_attack_air_kick_up;}
			// if (jump_ascending == false){ state = player_state_attack_air_kick_down;}
		}
	}
	//on the ground
	else{
		//reset jump delay while on ground so player can jump again
		can_jump = 5;
	
		//standing attack
		//start first attack
	
		//if you're not dashing, and you're not already in another attack state, go into the first attack
		if (dashing == false){
			//regular attack, tap button
			if (InputPressed(INPUT_VERB.ATTACK,player_number)){ 
				
				state = player_state_attack_stand_1;
				
				//start_animation(seq_teen_guy_stand_attack_1,Xobj_hitbox_player,Xobj_hurtbox_player);
				//if (state != player_state_attack_stand_1) or (state != player_state_attack_stand_2) or 
				//   (state != player_state_attack_stand_3) or (state != player_state_attack_stand_4) or 
				//   (state != player_state_attack_stand_5){
				
				//	state = player_state_attack_stand_1;
				//}
			
			}
			
			//charge up attack (button pressed and held)
			if (InputLong(INPUT_VERB.ATTACK,player_number,player_number)){
				//state = player_state_attack_charge_1;
				
			}
			
		}
		//if you are dashing
		//if (InputPressed(INPUT_VERB.ATTACK,player_number)) and (dashing == true) { state = player_state_attack_dash_1;}
	
	}

}
	
function player_movement_and_collisions(_x_move_ok = 1, _y_move_ok = 1, _move_speed = walk_speed){
	//get intended movement input, check for collisions (2D & 3D), then apply if no collisions
	
	move_speed = _move_speed;
	
	//player movement
	//jumping
	if (can_jump > 0) and (InputPressed(INPUT_VERB.JUMP,player_number)) and (sprite_index != sprite_hit){	
		z_speed =  -jump_amount;
		can_jump = 0;
		in_the_air = true;
		jump_ascending = true;
		grav = 1.5;
	}
	//variable jump check
	if (z_speed < 0) and (!InputCheck(INPUT_VERB.JUMP,player_number)) {
		z_speed = max(z_speed, -jump_amount/4);
		grav = 3;
	}
	
	//dash check
	//first check that you're on the ground and not dashing already
	if (in_the_air == false) and (move_speed != run_speed){
		/*
		//check to see if there was a double tap in a direction (and was held? can being held be checked for in Input 10?)
		if (InputRepeat(INPUT_VERB.RIGHT,player_number) or InputRepeat(INPUT_VERB.LEFT,player_number)){
			dashing = true;
			move_speed = run_speed;
		}
		//maybe this can switch to check if input was released to see if the input was "held" in Input v10
		//if it's not held, then go back to walk speed
		else {
			dashing = false;
			move_speed = walk_speed;
		}
		*/
	}
   
	//determine the direction the player is intending to move
	move_direction = InputDirection(0,INPUT_CLUSTER.NAVIGATION,player_number);
	
	//determine the amount player is intending to move
	var _speed = 0;
	var _input_amount = InputDistance(INPUT_CLUSTER.NAVIGATION,player_number);
	//clamp the input_amount so diagonal movement isn't faster
	_input_amount = clamp(_input_amount,0,1);
	_speed = move_speed * _input_amount;
	
	//update x, y, z speed variables
	x_speed = lengthdir_x(_speed, move_direction)*_x_move_ok;
	y_speed = lengthdir_y(_speed, move_direction)*_y_move_ok;
	if (z != 0) z_speed = z_speed+grav;
	
	//collision checks (2d)
	if place_meeting(x+x_speed,y,obj_wall) x_speed = 0;
	if place_meeting(x,y+y_speed,obj_wall) y_speed = 0;
	
	//collision checks (3d)
	if place_meeting_3d(x + x_speed, y, z,obj_climbable_parent) x_speed = 0;
	if place_meeting_3d(x, y+y_speed,z,obj_climbable_parent) y_speed = 0;
	if place_meeting_3d(x,y,z+z_speed+grav,obj_climbable_parent){ 
		z_speed = 0;
		can_jump = 5;
		in_the_air = false;
		climbing = true;
	}
	else climbing = false;
	
	//check to see if player entered a battle region, if so temporarily disable movement (if the region is active (enemies present)
	var _my_battle_region = instance_nearest(x,y,obj_battle_region);
	
	//prevent player from moving outside battle region when active
	if (instance_exists(_my_battle_region)) and (_my_battle_region.is_active == true){
		var _buff = 12; //this buffer should be lower than the one activatig BR in obj_battle_region
		//this buffer is so there can be a border outside main br player can walk through before being locked in
		//this extra width will be used to spawn enemies in, so they can walk into the screen from the sides
		var _br_buffer_width = 64 
		
		var _x1 = _my_battle_region.left_edge+_buff+_br_buffer_width;
		var _y1 = _my_battle_region.top_edge;
		var _x2 = _my_battle_region.right_edge-_buff-_br_buffer_width;
		var _y2 = _my_battle_region.bottom_edge;
		//horizontal (check player's x)
		if (point_in_rectangle(x+x_speed,y,_x1,_y1,_x2,_y2) == false) x_speed = 0;
		
		//vertical (check player's y)
		if (point_in_rectangle(x,y+y_speed,_x1,_y1,_x2,_y2) == false) y_speed = 0;
		
	}

	//save current z to be z previous before updating it below
	z_previous = z;
	
	//apply movement (if no collisions above were detected)
	x += x_speed;
	y += y_speed;
	
	//if your current z + z_speed won't push you through floor, keep moving
	if (z+z_speed <= z_floor) z += z_speed;
	//otherwise, you've hit the floor
	else {
		in_the_air = false;
		z = z_floor;
		z_previous = 0; //only needed if you need to know if player movement going up or down
	}

	//check to see if you're ascending or descending
	if (z_previous < z) jump_ascending = false;
}
	
function player_state_dead(){
	//state once player runs out of hit points
	state_name = "dead";
	
	//decrease your lives number
	//update the obj_game variable that is tracking lives too
	switch(player_number){	
		case 0: obj_game.player_1_lives--; break;
		case 1: obj_game.player_2_lives--; break;
	}
	
	//number of frames to pass before the player will respawn (if they still have lives left)
	respawn_frames_current--;
	
	//rewrite this code so that local player_lives variable is not needed (only checking that variable on obj_game)
	//if you still have lives left
	if (player_lives > 0){
		
	
		//if you haven't set your sprite to the down sprite yet, do it
		//deactivate your hurtbox
		if (sprite_index != sprite_down){
			sprite_index = sprite_down;
		
			player_lives--;
			if (player_lives > 0) blinking = true;
			//audio_play_sound(snd_player_down,5,false);
			
			if (instance_exists(my_body_hurtbox)) instance_deactivate_object(my_body_hurtbox);
		}
		
		//if you've waited the respawn time, respawn back to normal
		if (respawn_frames_current <= 0){
			//reset the respawn for next time, heal, activate hitbox, then change states
			respawn_frames_current = respawn_frames_max;
			hp_current = hp_max
			blinking = false;
			instance_activate_object(my_body_hurtbox);
			state = player_state_stand_free;
		}
		
	}
	//if you don't have any lives left
	else{
		
		fade_out_frames--;
		if (fade_out_frames < 30) blinking = true;
		if (fade_out_frames < 0) instance_destroy();
		
		if (sprite_index != sprite_dead){
			sprite_index = sprite_dead;	
		}
		
	}
	//don't actually destroy the player (not neeeded)
	//instance_destroy();
}
	
function player_draw(){
	//player draw function needed because appearence of vertical height will be achieved by adding the z value to y position
	
	//color_mod.SetShader(pallet);
	draw_sprite_ext(sprite_index,image_index,x,y+z,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	//shader_reset();
	
}