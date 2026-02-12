var c=c_black;

//fade in dark rectangle
if (state == 0){
	
	//darkening the screen
	if (alpha < 1){
		draw_set_alpha(alpha);
		draw_rectangle_color(0,0,w,h,c,c,c,c,false);
		alpha+=transition_speed;
		draw_set_alpha(1);
	}
	//screen fully dark, then transition
	if (alpha >=1) and (target_room != -1){
		room_goto(target_room);
		state = 1;
	}
}
//fade out dark rectangle
if (state == 1){
	
	//lightening the screen
	if (alpha > 0){
		draw_set_alpha(alpha);
		draw_rectangle_color(0,0,w,h,c,c,c,c,false);
		alpha-=transition_speed;
		draw_set_alpha(1);
	}
	//screen fully viewable
	if (alpha <=0){
		instance_destroy();
	}
}


