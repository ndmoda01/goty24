/// @description Insert description here

if (obj_game.debug == true){
	
	draw_self();
	
	//draw collision bounding box
	var c = c_yellow;
	draw_rectangle_color(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,c,c,c,c,true);

}

else draw_self();