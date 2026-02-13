var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);
var _cam_w = camera_get_view_width(view_camera[0]);
var _cam_h = camera_get_view_height(view_camera[0]);

//hud coordinates
var _border = 32
var _ui_x = _cam_x + _border;
var _ui_y = _cam_y + _border;
var _name_x_buff = 6 // 36;
var _name_y_buff = -6;
var _head_x_buff = 4;
var _head_y_buff = 12;
var _hb_y_buff = 32;
var _scale = 3;

//regular gameplay level UI
if (room == rm_level_1_1) or
(room == rm_level_1_2a) or
(room == rm_level_1_2b) or
(room == rm_level_1_2c){
	
	//draw each player ui (name, stats, etc)
	var _current_players = instance_number(obj_player_parent);
	var _player_ui_space_gap = 300;
	var _inst = [];
	
	//display ui for all active players
	for (var p = 0; p < _current_players; p++){
		
			//loop through all instances and draw each player's UI
			_inst[p] = instance_find(obj_player_parent,p);
		
			//draw player number and stats
			draw_sprite_stretched(spr_player_ui_bg,0,_ui_x+(_player_ui_space_gap*p),_ui_y+_name_y_buff-5,280,110);
			draw_set_font(fnt_ui_large);
			draw_set_valign(fa_top);
			draw_set_halign(fa_left);
			draw_text(_ui_x+_name_x_buff+(_player_ui_space_gap*p),_ui_y+_name_y_buff,string(_inst[p].my_name));
			draw_text(_ui_x+_name_x_buff+200+(_player_ui_space_gap*p),_ui_y+_name_y_buff,string("x"+string(_inst[p].player_lives)));
	
			//health bar
			color_mod.SetShader(_inst[p].pallet);
			draw_sprite_ext(spr_player_health_bar_2,0,_ui_x+(_player_ui_space_gap*p),_ui_y+_hb_y_buff,_scale,_scale,0,c_white,1);
		
			for (var i=0; i < _inst[p].hp_max; i++){
	
				//show current hp
				var _img = 1;
				if (i+1<= _inst[p].hp_current){_img =2;};
	
				var _sep = 4*_scale;
				draw_sprite_ext(spr_player_health_bar_2,_img,(_ui_x+_sep*i)+(_player_ui_space_gap*p),_ui_y+_hb_y_buff,_scale,_scale,0,c_white,1);
			}
			shader_reset();
	}
	
	var _max_players = obj_game.numb_players_max;
	var _empty_player_slots = _max_players - _current_players;
	
	//draw enough ui boxes to show other players can join in the empty slots
	for (var h = 0; h < _empty_player_slots; h++){
		
			//draw ui to show player can join, shifted based on the number of slots available (offset by the number of current players)
			draw_sprite_stretched(spr_player_ui_bg,0,_ui_x+(_player_ui_space_gap*(h+_current_players)),_ui_y+_name_y_buff-5,280,110);
			draw_set_font(fnt_ui_large);
			draw_text_scribble(_ui_x+_name_x_buff+(_player_ui_space_gap*(h+_current_players)),_ui_y+_name_y_buff-1,"[fnt_ui_small]Press X to join");	
	}
	
	
	//if the current level is completed
	if (obj_game.level_complete == true){
		
		var _x = _cam_x + (_cam_w/2);
		var _y = _cam_y + (_cam_h/2);
	
		draw_text_scribble(_x,_y-40,"[fa_center][fnt_menu_large] Congratulations! \nYou Win!");
		
		input_delay++;
		
		if (input_delay >= SEC*2) {
			if (InputPressed(all)){
				//game_restart();
				
				create_transition_and_move(rm_title);
			}
		}
	}

	//if the game is over, fade to black then go back to title screen
	if (obj_game.game_over == true){
	
		//fade in a black background
		fade_in_cur_alpha += fade_in_speed;
		draw_set_alpha(min(fade_in_max_alpha,fade_in_cur_alpha));
		var _view_x = _cam_x - (camera_get_view_width(0)/2);
		var _view_y = _cam_y - (camera_get_view_height(0)/2);
		var c = c_black;
		draw_rectangle_color(_view_x,_view_y,_view_x+camera_get_view_width(0),_view_y+camera_get_view_height(0),c,c,c,c,false);
		draw_set_alpha(1);
	
		var _x = _cam_x + (_cam_w/2);
		var _y = _cam_y + (_cam_h/2);
	
		draw_text_scribble(_x,_y-40,"[fa_center][fnt_menu_large]GAME OVER");
	
		if (fade_in_cur_alpha >= 1) {
			if (InputPressed(all)){
				//game_restart();
				
				create_transition_and_move(rm_title);
			}
		}
	
	
	}
}

if (room == rm_title){

	var _x = room_width/2;
	var _y = room_height/2;

	draw_text_scribble(_x,_y-30,"[fa_center][fa_bottom][fnt_menu_large] Beat Em Up");
	
	//buttons are drawn in the room by editing the button create events
}

//pause ui
if (instance_exists(obj_pause)){
	
	draw_set_alpha(.8);
	var _view_x = _cam_x - (camera_get_view_width(view_camera[0])/2);
	var _view_y = _cam_y - (camera_get_view_height(view_camera[0])/2);
	var c = c_black;
	//draw_rectangle_color(_view_x,_view_y,_view_x+camera_get_view_width(view_camera[0]),_view_y+camera_get_view_height(view_camera[0]),c,c,c,c,false);	
	draw_rectangle_color(_cam_x,_cam_y,_cam_x+camera_get_view_width(view_camera[0]),_cam_y+camera_get_view_height(view_camera[0]),c,c,c,c,false);	
	
	draw_set_alpha(1);
	
	var _x = _cam_x + (_cam_w/2);
	var _y = _cam_y + (_cam_h/2);
	var _y_buffer = 100;
	
	draw_text_scribble(_x,_y-_y_buffer,"[fa_center][fa_middle][fnt_menu_large]PAUSED");
	
	//draw menu initially, but it will be rewritten below
	draw_text_scribble(_x,_y+_y_buffer,"[fa_center][fa_middle][fnt_menu_medium]RESUME");
	draw_text_scribble(_x,_y+(_y_buffer*2),"[fa_center][fa_middle][fnt_menu_medium]RESTART LEVEL");
	draw_text_scribble(_x,_y+(_y_buffer*3),"[fa_center][fa_middle][fnt_menu_medium]QUIT TO MAIN MENU");
	//draw_text_scribble(_x,_y+(_y_buffer*4),"[fa_center][fa_middle][fnt_menu_medium]QUIT GAME");
	
	//menu movement
	if (InputPressed(INPUT_VERB.UP)) and (pause_menu_index  > 0) pause_menu_index--;
	if (InputPressed(INPUT_VERB.DOWN)) and (pause_menu_index  < pause_menu_option_max) pause_menu_index++;

	//highlight current option and check for option selection
	switch(pause_menu_index){
		case 0: 
			draw_text_scribble(_x,_y+_y_buffer,"[fa_center][fa_middle][fnt_menu_medium][c_yellow]*RESUME*");
			if (InputPressed(INPUT_VERB.SELECT)) instance_destroy(obj_pause);
		break;
		
		case 1: 
			draw_text_scribble(_x,_y+(_y_buffer*2),"[fa_center][fa_middle][fnt_menu_medium][c_yellow]*RESTART LEVEL*");
			if (InputPressed(INPUT_VERB.SELECT)) room_restart();
		break;
		
		case 2: 
			draw_text_scribble(_x,_y+(_y_buffer*3),"[fa_center][fa_middle][fnt_menu_medium][c_yellow]*QUIT TO MAIN MENU*");
			if (InputPressed(INPUT_VERB.SELECT)) create_transition_and_move(rm_title);
		break;
		
		case 3: 
		//	draw_text_scribble(_x,_y+(_y_buffer*4),"[fa_center][fa_middle][fnt_menu_medium][c_yellow]*QUIT GAME*");
			if (InputPressed(INPUT_VERB.SELECT)) game_end();
		break;
	}
	
}