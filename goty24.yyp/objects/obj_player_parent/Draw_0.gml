//shadow
if (climbing == false) draw_sprite_ext(sprite_shadow,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
else draw_sprite_ext(sprite_shadow,0,x,y+z,image_xscale,image_yscale,image_angle,image_blend,image_alpha);



if (obj_game.debug == true){
	
	player_draw();
	
	//draw collision bounding box
	var c = c_yellow;
	draw_rectangle_color(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,c,c,c,c,true);

	//draw state name
	draw_text(x,y+30,"P"+string(player_number)+": "+string(state_name));
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

var _input_connected = InputPlayerIsConnected(player_number);
draw_text(x-50,y+20,"Connected: "+string(_input_connected));

var _input_device = InputPlayerGetDevice(player_number);
switch(_input_device){
	case -1: _input_device = "KBM"; break;
	case 0: _input_device = "gp0"; break;
	case 1: _input_device = "gp1"; break;
	case -666: _input_device = "no device"; break;
}
draw_text(x-50,y+50,"Device: "+string(_input_device));




flash_white();