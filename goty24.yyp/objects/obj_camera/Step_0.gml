if (screen_pause()) exit;

//update new min x each frame if it is larger
if (flow_direction == ADVANCING_RIGHT){
	var _screen_0 = x-view_w_half;
	var _off_screen_buffer = 96;
	if (_screen_0-_off_screen_buffer > min_x) min_x = _screen_0-_off_screen_buffer;
	moving_wall.x = min_x;
	moving_wall.y = y-view_h_half-60;
}

//get the id of the closest battle reggoin
var _my_battle_region = instance_nearest(x,y,obj_battle_region);

switch(state){
	
	//follow the players if they aren't in a battle region
	//this system needs a re-write if more than 2 players will be possible
	case "player":
		
		//position between players if 2 exist
		var _distance_between = 0;
		
		if (instance_exists(follow_1)) and (instance_exists(follow_2)){
			x_to = (follow_1.x+follow_2.x)/2;
			y_to = (follow_1.y+follow_2.y)/2;
		}
		
		//only player 1 exists
		else if (instance_exists(follow_1)) and (!instance_exists(follow_2)){
			//update x and y from follow
			x_to = follow_1.x;
			y_to = follow_1.y;
		}
		
		//only player 2 exists
		else if (!instance_exists(follow_1)) and (instance_exists(follow_2)){
			//update x and y from follow
			x_to = follow_2.x;
			y_to = follow_2.y;
		}
		
		if (_my_battle_region.is_active == true) state = "battle_region";
	
	break;
	
	//lock camera to battle region
	case "battle_region":
		//var _br_buffer_width = 64;
		var _br_buffer_width = 0; //buffer removed for now (BR sprite is now one screen exactly)
		//var _min_x = _my_battle_region.left_edge+160;  //half camera width
		//var _min_x = _my_battle_region.left_edge+160+_br_buffer_width;  //half camera width
		var _min_x = _my_battle_region.left_edge+view_w_half+_br_buffer_width;  //half camera width
		
		//var _max_x = _my_battle_region.right_edge-160;
		//var _max_x = _my_battle_region.right_edge-160-_br_buffer_width;
		var _max_x = _my_battle_region.right_edge-view_w_half-_br_buffer_width;
		
		//var _min_y = _my_battle_region.top_edge+90;    //half camera height
		var _min_y = _my_battle_region.top_edge+view_h_half;    //half camera height
		//var _max_y = _my_battle_region.bottom_edge-40;
		//don't limit the bottom edge here as it will limit how much you can go down in the screen
		var _max_y = _my_battle_region.bottom_edge; //-view_h_half;
		
		//keep view between both players
		if (instance_exists(follow_1) and instance_exists(follow_2)){
			x_to = clamp((follow_1.x+follow_2.x)/2,_min_x,_max_x);
			y_to = clamp((follow_1.y+follow_2.y)/2,_min_y,_max_y);
		}
		
		//if only p1 alive
		else if (instance_exists(follow_1) and !instance_exists(follow_2)){
			x_to = clamp(follow_1.x,_min_x,_max_x);
			y_to = clamp(follow_1.y,_min_y,_max_y);
		}
		
		//if only p2 alive
		else if (!instance_exists(follow_1) and instance_exists(follow_2)){
			x_to = clamp(follow_2.x,_min_x,_max_x);
			y_to = clamp(follow_2.y,_min_y,_max_y);
		}
		
		if (_my_battle_region.is_active == false) or (distance_to_object(_my_battle_region) > 0){
			br_cam_in_position = false;
			state = "player";
			exit;
		}
		
		if (round(x) > _min_x-1) br_cam_in_position = true;
	break;
}
//update object position
//lower value means camera is snappier and lags behind movement less
//the division and lerp method causes a slight camera wobbling effect at times
var _scrollSpeed = 12; //15;

x += (x_to - x) / _scrollSpeed;
y += (y_to - y) / _scrollSpeed;


//make it so you can't look past the moved wall. 64 is the width of the wall sprite
//need to return the higher value so when the camera starts you can't look outside room to the left
var _x_room_edge = view_w_half + buff;
var _moving_wall_width_buffer = 64;
//x = clamp(x, max(_x_room_edge, _x_room_edge+(moving_wall.x+_moving_wall_width_buffer)), room_width -view_w_half - buff);
x = clamp(x, max(_x_room_edge, _x_room_edge+(moving_wall.x+_moving_wall_width_buffer)), 2000000);

//y = clamp(y, view_h_half + buff, room_height -view_h_half - buff);
y = clamp(y, view_h_half + buff, view_h_half*2 - buff);

//screen shake
x += random_range(-shake_remain, shake_remain);
y += random_range(-shake_remain, shake_remain);
shake_remain = max(0, shake_remain - ((1/shake_length)*shake_magnitude));

//update camera view
//var _bottom_edge_buffer = 56;
var _bottom_edge_buffer = 85;

camera_set_view_pos(cam,x -view_w_half,y -view_h_half -_bottom_edge_buffer);
//camera_set_view_pos(cam,x -view_w_half,0);


//Paralax Background movement
//closest layer to player (fastest moving, but slower than player)
//if (layer_exists("Background_1")){
//	layer_x("Background_1", lerp(0,camera_get_view_x(cam),0.5));
//}

//far distance away
//if (layer_exists("city_background")){
//	layer_x("city_background",lerp(0,camera_get_view_x(cam),0.9));
//}

////middle distance away
//if (layer_exists("trees2")){
//	layer_x("trees2",lerp(0,camera_get_view_x(cam),0.8));
//}

////far away (slowest moving)
//if (layer_exists("sky")){
//	layer_x("sky", lerp(0,camera_get_view_x(cam),0.9));
//}
