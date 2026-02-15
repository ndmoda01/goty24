
//toggle debug mode
if (keyboard_check_pressed(vk_f1)) debug = !debug;	

//restart game shortcut
 if (keyboard_check_pressed(vk_f4)) game_restart();
 
 //reset input for player 1
 //can be used reset player 1's input source from keyboard to the next input source (controller)
 if (keyboard_check_pressed(vk_f9)){}; //No longer available in v10, input_source_clear(0);
 
//pause
//prevent pause after game over and during a transition
//only allow pause during gameplay rooms
if (InputPressed(INPUT_VERB.PAUSE)) and (game_over == false) and (!instance_exists(obj_room_transition)) {
		
	//become paused
	if (!instance_exists(obj_pause)) instance_create_layer(0,0,"Instances",obj_pause);
	else (instance_destroy(obj_pause));
		
}
 
 
 

//check for game over
if (room == rm_level_1_1) {
	
	//if P1 is out of lives, and it is not game over yet
	if (player_1_lives <=0) and (game_over == false){
		//P2 not playing or also not alive, then it's game over
		if (!instance_exists(obj_player_2) or (player_2_lives <=0)) game_over = true;
	}

	//if P2 is out of lives and it is not game over yet
	if (player_2_lives <= 0) and (game_over == false){
		//P1 no longer playing (has dropped out) or also not alive
		if (!instance_exists(obj_player_1) or (player_1_lives <=0)) game_over = true; 
	}
}