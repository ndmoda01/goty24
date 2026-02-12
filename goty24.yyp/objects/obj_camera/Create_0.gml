cam = view_camera[0];
follow_1 = obj_player_1;
follow_2 = obj_player_2;
view_w_half = camera_get_view_width(cam) * .5; //0.5;
view_h_half = camera_get_view_height(cam) * .5; //0.5;
//variables are updated every frame, but start at original x and y
x_to = xstart;
y_to = ystart;

state = "player";
br_cam_in_position = false;

min_x = -100;
flow_direction = ADVANCING_RIGHT;
//create wall offscreen, then move it as the camera moves to prevent backtracking
moving_wall = instance_create_layer(-32,y-view_h_half,"Walls",obj_wall);
moving_wall.image_xscale = 1;
moving_wall.image_yscale = 18;

//how long will the screen shake happen (in frames)
shake_length = 0;
//how strong will it be / how much offset to apply to the camera (radius
shake_magnitude = 0;
//shake remain is same as magnitude, but gradually decreases until it hits 0
shake_remain = 0;
//buffer boarder for screen shake to prevent shaking outside of screen
//buffer should be larger than the largest magnetude screen shake in the game
//or the camera can shake outside of the room (will slighly zoom in the camera)
buff = 0;

//update destination to P1 at the start
if (instance_exists(follow_1)){
	//update x and y from follow
	x_to = follow_1.x;
	y_to = follow_1.y;	
}
