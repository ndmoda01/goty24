//dead state
function enemy_state_dead(){
	
	//set death animation and anything else you only need to do 1 time in this state
	if (dead == false){
	
		dead = true;
		
		if (sprite_index != sprite_dead) sprite_index = sprite_dead;
		image_index = 0; //start index over so it animates fully
		
		//delete your hurtbox
		if (instance_exists(my_body_hurtbox)) instance_destroy(my_body_hurtbox);
		

		//if you knock out someone in 1 hit, they will need to know which side they were hit from last and move away from it
		//x_speed = (sign(image_xscale)*-1)*.8;
		x_speed = (last_hit_from*-1)*.8;
		z_speed = -2.5;
		
		
	}
	
	
	//make it so you can't get pushed down or fall too far into the floor
	if (z <= z_floor){
		z_speed += grav;
		
		if (place_meeting(x+x_speed,y,obj_wall)) x_speed=0;
		if (place_meeting(x,y+y_speed,obj_wall)) y_speed=0;
			
		x+= x_speed;
		//y+= y_speed;
		if (z+z_speed <= z_floor) z += z_speed;
		else z = z_floor;
	}
	
	//once animation is over, fade out
	//if (animation_end()){
	//	x_speed = 0;
	//	y_speed = 0;
	//	z_speed = 0;
	//	fade_out = true;
	//}
	
}

//idle state
function enemy_state_stand_free(){
	
	if (activate_delay >= 0){
		activate_delay--;
		
		//create your hurtbox if you don't have one yet
		if (my_body_hurtbox == noone) my_body_hurtbox = hurtbox_create(17,44);
		exit;
	}
	
	//apply gravity in case you are in the air still from another state
	if (z <= z_floor){
		z_speed += grav;
		//you haven't landed, so keep going
		if (z+z_speed <= z_floor) z += z_speed;
		//you've landed
		else{ 
			z = z_floor;
			in_the_air = false;	
		}
	}	
	
	//set target to closest player if you don't already have one
	if (target_player == noone) or (!instance_exists(target_player)){
		if (instance_exists(obj_player_parent)){
			//pick the closest player
			target_player = instance_nearest(x,y,obj_player_parent);
			
			//if the closest player is KO, go to another instance (if there is one)
			//if (target_player.state == player_state_dead){
			//	target_player = instance_furthest(x,y,obj_player_parent);
			//}
		
			//pick target attack side
			target_attack_side = choose(MOVE_LEFT,MOVE_RIGHT);
		
			//set_target_position();
		}
	}
	
	
	//update facing to face target if it exists, and check for attack
	if (instance_exists(target_player)){
		if (target_player.x < x) facing = -1;
		if (target_player.x > x) facing = 1;
		
		//if player is already within attack range, give a chance for attack
		if(distance_to_object(target_player) <= attack_range) and (abs(y-target_player.y) < INTERACT_MAX_DIST){
			//attack
			//state = enemy_state_target_reached;
		}
		//if player is out of range, move in their direction
		else{
			//state = enemy_state_pursue_target;	
			//state = enemy_state_pursue_target_path;	
		}
	}
	
	//flip sprite based on direction
	image_xscale = abs(image_xscale)*facing;
}
	
//inactive while waiting to enter the screen
function enemy_state_br_spawn_wait(){
}
	
	
function draw_self_and_fade_out(){
	
	//fade out and destroy yourself
	if (fade_out == true){
		image_speed = 0;
		fade_out_counter--;
		if (fade_out_counter > 100){
			draw_sprite(sprite_shadow_long,0,x,y);
			enemy_draw();
		}
		if (fade_out_counter > 95 and fade_out_counter < 100){
	
		}
		if (fade_out_counter > 90 and fade_out_counter < 95){
			draw_sprite(sprite_shadow_long,0,x,y);
			enemy_draw();
		}
		if (fade_out_counter > 85 and fade_out_counter < 90){
			
		}
		if (fade_out_counter > 80 and fade_out_counter < 85){
			draw_sprite(sprite_shadow_long,0,x,y);
			enemy_draw();
		}
		
		if (fade_out_counter <= 77) instance_destroy();
	}
	//regular draw
	else {
		//if (state == enemy_state_inactive) and (obj_game.debug == false){
		if (obj_camera.br_cam_in_position == false) and (state == enemy_state_br_spawn_wait){
			//draw yourself if debug is on
			if (obj_game.debug) enemy_draw();
			else { };//skip your draw so you're invisible	
		}
		else enemy_draw(); 

	}
}
	
function enemy_draw(){
	
	//enemy draw
	//color_mod.SetShader(pallet);       //comment this line and shader reset below out to disable pallet swapping
	draw_sprite_ext(sprite_index,image_index,x,y+z,image_xscale*facing,image_yscale,image_angle,image_blend,image_alpha);
	//shader_reset();                    //comment this line and colormod shader set above to disable pallet swapping
	
}