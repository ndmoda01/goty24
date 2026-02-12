if (screen_pause()) exit;

if (hp_current <= 0) {
	//instance_destroy();
	if (state != enemy_state_dead) state = enemy_state_dead;
}

//script_execute(state);

depth = -bbox_bottom;

//enemy ai
//here we can handle different ai scripts
// ... but for now there is only one
enemy_ai_movement_basic();	//basic enemy ai movement 
enemy_ai_movement_keepaway();