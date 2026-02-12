//check for alt being pressed to prevent selecting when putting into or out of fullscreen
if (place_meeting(x,y,obj_button) and (input_check_pressed("select")) and (!keyboard_check_direct(vk_alt))){
	var _button = instance_place(x,y,obj_button);
	with (_button){
		//only activate if the button is selectable
		if (selectable == true){
			//audio_play_sound(snd_menu_selected,5,false);
			activate_button();
		}
	}
}


//move up and down
if (input_check_pressed("up") and position_index > 0) {
	//audio_play_sound(snd_cursor_move,5,false);
	position_index --;
};
if (input_check_pressed("down") and position[position_index+1] != -1){
	//audio_play_sound(snd_cursor_move,5,false);
	position_index ++	
}

x = position[position_index,0];
y = position[position_index,1];
