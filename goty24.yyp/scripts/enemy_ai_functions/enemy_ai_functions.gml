//contains enemy ai scripts for various ai actions and enemy types
//
//

function enemy_ai_movement_basic(){

	// Step Event

	// Clamp position to stay inside room
	x = clamp(x, 0, room_width);
	y = clamp(y, 0, room_height);

	// Clamp speed
	speed = clamp(speed, 0, 12);

	// Animation control
	if speed > 0.1 sprite_index = sprite_walk;
	else sprite_index = sprite_idle;

	// Handle AI movement logic
	move_timer--;
	if (move_timer <= 0)
	{
	    // Reset timer with a random interval 
	    move_timer = 30 * choose(2, 3, 4, 5);

	    var _player = instance_nearest(x, y, obj_player_parent);
	    if (_player != noone)
	    {
	        var _side = _player.facing;
	        var _rx = random_range(20, -20);
	        var _ry = random_range(10, -10);
	        var _dist = 350 * _side;
	        var _px = _player.x + _dist + _rx;
	        var _py = _player.y + _ry;

	        move_target_x = _px;
	        move_target_y = _py;

	        facing = (_player.x > x) ? 1 : -1;		//turn to face player

	        direction = point_direction(x, y, move_target_x, move_target_y);
	        var _dist_to_point = point_distance(x, y, move_target_x, move_target_y);

	        if (_dist_to_point > 250)
	        {
	            speed = 9 * choose(1.0, 1.5, 2.0);
	        }
	        else
	        {
	            speed = 6.5;
	            move_timer = 45 * choose(1, 1, 2, 3); // shorter timer when closer
	        }

	        friction = 0.15;
	    }
	}


}

function enemy_ai_movement_keepaway(){

	// Step Event

	// Clamp position to stay inside the view port
	var _vb = 50; //view border (can be set to a negative value to allow enemies to go offscreen)
	var _vx = camera_get_view_x(view_camera[0]);
	var _vy = camera_get_view_y(view_camera[0]);
	var _vw = camera_get_view_width(view_camera[0]);
	var _vh = camera_get_view_height(view_camera[0]);

	x = clamp(x, _vx + _vb, _vx + _vw - _vb);
	y = clamp(y, _vy, _vy + _vh);


	// Clamp speed
	speed = clamp(speed, 0, 12);

	// Animation control
	if speed > 0.1 sprite_index = sprite_walk;
	else sprite_index = sprite_idle;

	// Handle AI movement logic
	move_timer--;
	if (move_timer <= 0)
	{
	    // Reset timer with a random interval 
	    move_timer = 25 * choose(2, 3, 4, 5);
		
	    var _player = instance_nearest(x, y, obj_player_parent);
		var _d = 475; // safe distance between player and 
	    var _spd = 5;
		if (_player != noone)
	    {
			var _nme_player_dist = distance_to_object(_player); //enemy to player distance
			facing = (_player.x > x) ? 1 : -1;
			
			if _nme_player_dist > _d
			{
				if abs(y - _player.y) >  100
				{
					if _player.y > y
					{
						direction = 270;
						speed = 8;
					}
					
					if _player.y < y 
					{
						direction = 90;
						speed = 8;
					}
				}
				else
				{
					if _player.x > x 
					{
						direction = 0;
						speed = 7;
					}
					
					if _player.x < x 
					{
						direction = 180;
						speed = 7;
					}
				}
			}
			else
			{
				move_target_x = _player.x;
				move_target_y = y;
				direction = point_direction(move_target_x, move_target_y, x,y);
				speed = 10;
			}
			
			
	        friction = 0.15;
	    }
	}


}