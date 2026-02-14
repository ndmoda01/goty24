//shadow
if (climbing == false) draw_sprite_ext(sprite_shadow,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
else draw_sprite_ext(sprite_shadow,0,x,y+z,image_xscale,image_yscale,image_angle,image_blend,image_alpha);



if (obj_game.debug == true){
	
	player_draw();
	
	//draw collision bounding box
	var c = c_yellow;
	draw_rectangle_color(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,c,c,c,c,true);

	//draw state name
	draw_text(10,300,"P"+string(player_number)+": "+string(state_name));
}
else{
	//if you're KO'd blink
	if (blinking){
		if (blink(100,100)){
			player_draw();
		}
	}
	//if you're not dead, draw normally
	else{
		player_draw();
	}
	
	
}

//draw_text(x-6,y-10,string(x)+","+string(y));

flash_white();