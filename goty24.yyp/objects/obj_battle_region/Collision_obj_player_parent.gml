//buffer needed to ensure player is fully in region, not on edge, when activating it
var _player_bbox_width = abs(obj_player_parent.bbox_left-obj_player_parent.bbox_right);
var _buffer = 20;
//buffer area to put enemies to spawn in
//allow the players to walk past this area into the 'main' battle area before activating
var _br_buffer_width = 64; 

//var _x1 = left_edge+_player_bbox_width/2+_buffer;
var _x1 = left_edge+_player_bbox_width/2+_buffer+_br_buffer_width;
var _y1 = top_edge+_buffer;
//var _x2 = right_edge-_player_bbox_width/2-_buffer;
var _x2 = right_edge-_player_bbox_width/2-_buffer-_br_buffer_width;
var _y2 = bottom_edge;//-_buffer;

//both instances p1 and p2 exsist
if (instance_exists(obj_player_1) and (instance_exists(obj_player_2))){
	if (point_in_rectangle(obj_player_1.x,obj_player_1.y,_x1,_y1,_x2,_y2)) and (point_in_rectangle(obj_player_2.x,obj_player_2.y,_x1,_y1,_x2,_y2)) and (has_enemies == true){
		is_active = true;
	}
}

//if only 1st player present
if (instance_exists(obj_player_1) and (!instance_exists(obj_player_2))){
	//and also inside the rectangle
	if (point_in_rectangle(obj_player_1.x,obj_player_1.y,_x1,_y1,_x2,_y2)){
		is_active = true;
	}
}

//if only 2nd player present
if (!instance_exists(obj_player_1) and (instance_exists(obj_player_2))){
	//and also inside the rectangle
	if (point_in_rectangle(obj_player_2.x,obj_player_2.y,_x1,_y1,_x2,_y2)){
		is_active = true;
	}
}
