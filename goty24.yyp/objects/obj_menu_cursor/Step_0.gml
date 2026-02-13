//check for alt being pressed to prevent selecting when putting into or out of fullscreen
if (place_meeting(x,y,obj_button) and (InputPressed(INPUT_VERB.SELECT)) and (!keyboard_check_direct(vk_alt))){
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
if (InputPressed(INPUT_VERB.UP) and position_index > 0) {
	//audio_play_sound(snd_cursor_move,5,false);
	position_index --;
};
if (InputPressed(INPUT_VERB.DOWN) and position[position_index+1] != -1){
	//audio_play_sound(snd_cursor_move,5,false);
	position_index ++	
}

x = position[position_index,0];
y = position[position_index,1];
