//shadow

if (fade_out == false){
	if (climbing == false) {
		if (state == enemy_state_br_spawn_wait) and (obj_game.debug == false){
			//skip drawing
		}
		else draw_sprite_ext(sprite_shadow,0,x,y,image_xscale*facing,image_yscale,image_angle,image_blend,image_alpha);
	}
	else{
		if (state == enemy_state_br_spawn_wait) and (obj_game.debug == false){
			//skip drawing
		}
		else draw_sprite_ext(sprite_shadow,0,x,y+z,image_xscale*facing,image_yscale,image_angle,image_blend,image_alpha);
	}
}

if (obj_game.debug == true){
	draw_self_and_fade_out();
	var c = c_yellow;

	draw_rectangle_color(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,c,c,c,c,true);

}
else{ 
	
	draw_self_and_fade_out();
}

flash_white();


//draw_text(x,y+100,floor(distance_to_object(obj_player_parent)))