if (obj_game.debug == true){
	
	draw_self();
	
	var c = c_lime;
	draw_rectangle_color(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,c,c,c,c,true);

	scribble(string(my_type)).draw(owner.x,owner.y);
	scribble(string(owner)).draw(owner.x,owner.y-20);
}
else{
	//don't draw anything
}