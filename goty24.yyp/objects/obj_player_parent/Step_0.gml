if (screen_pause()) exit;

//death / game over
if (hp_current <= 0){ 
	state = player_state_dead;
}


//reduce can_jump each frame
can_jump--;

//if you're not enabled due to an animation, check to see if its done
if (actor_enabled == false){
	check_animation_end();	
}

//player state machine
if (has_control) script_execute(state);

depth = -bbox_bottom;