function screen_shake(_shake_magnitude = 1,_shake_length=10){
	/// @desc scr_screenShake(magnitude, frames)
	/// @arg Magnitude sets strength of the shake (radius in pixels)
	/// @arg Frames sets the length of the shake in frames (60 = 1 sec at 60fps)
	
	with (obj_camera){
		if (_shake_magnitude > shake_remain){
			shake_magnitude = _shake_magnitude;
			shake_remain = shake_magnitude;
			shake_length = _shake_length;
		}
	}
}
	
function flash_white(){
	//make something flash white for as long as their flash variable is above 0
	//must be called in a Draw event
	
	if (flash > 0){
		flash--;
		shader_set(sha_white);
		draw_sprite_ext(sprite_index,image_index,x,y+z,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
		shader_reset();
	}
}
	
function hurtbox_create(_width = 16, _height = 46){
	//create the hurtbox for the entity, and then modify it so it fits it's host size
	
	
	/* unique hurtbox objects only needed for sequences based and can now be removed
	var _hurt_b = -1;
	
	//if you're an enemy
	if (object_is_ancestor(object_index,obj_enemy_parent)){
		_hurt_b = instance_create_depth(x,y,-4000,Xobj_hurtbox_enemy);
	}
	//if you're a player
	else if (object_is_ancestor(object_index,obj_player_parent)){
		_hurt_b = instance_create_depth(x,y,-4000,Xobj_hurtbox_player);
	}
	//if you're an enviornmental object
	else _hurt_b = instance_create_depth(x,y,-4000,Xobj_hurtbox_hazard);
	*/
	
	//create a general hurtbox for yourself (all objects use the same hurtbox object)
	
	var _hurt_b = instance_create_depth(x,y,-4000,obj_hurtbox_parent);
	
	_hurt_b.owner = id;
	_hurt_b.image_xscale = _width*image_xscale;
	_hurt_b.image_yscale = _height*image_yscale;
	
	return _hurt_b;
}

function hurtbox_update(_x_offset = 0, _y_offset = 0){
	
	//update the hurtbox location each frame so it is accurate
	if (instance_exists(my_body_hurtbox)){
		my_body_hurtbox.image_xscale = my_body_hurtbox.image_xscale*facing;
		my_body_hurtbox.x = (x - my_body_hurtbox.sprite_width/2) + (_x_offset*facing); //center it
		my_body_hurtbox.y = (y+z) + _y_offset; //offset the height using z, so it's accurate to its owner's on screen position
	}
	
}
	
function place_meeting_3d(_x,_y,_z,_obj){
	//works likes standard place meeting, but with a z check added

	//vars
	var _height = height;

	//xy
	var xyMeeting = instance_place(_x, _y, _obj);

	//z
	var zMeeting = false;

	if (xyMeeting != noone) and (xyMeeting){
		zMeeting = rectangle_in_rectangle(0, xyMeeting.z, 1, xyMeeting.z- xyMeeting.height, 0, _z, 1, _z - height);
	
	}

	//return
	return xyMeeting and zMeeting;
	
}
	
function animation_end(){
	
	/// @description animation_end(sprite_index,image_index, rate)
	/// @param {real} <sprite_index> The index of the sprite being animated
	/// @param {real} <image_index> The current frame value
	/// @param {real} <rate> -See Below-
	///     The rate of change in frames per step if not
	///     using built in image_index/image_speed.  
	///     Don't use if you don't think you need this.  You probably don't.
 
	//returns true if the animation will loop this step.
 
	var _sprite=sprite_index;
	var _image=image_index;
	if(argument_count > 0)   _sprite=argument[0];
	if(argument_count > 1)  _image=argument[1];
	var _type=sprite_get_speed_type(sprite_index);
	var _spd=sprite_get_speed(sprite_index)*image_speed;
	if(_type == spritespeed_framespersecond)
	    _spd = _spd/game_get_speed(gamespeed_fps);
	if(argument_count > 2) _spd=argument[2];
	return _image+_spd >= sprite_get_number(_sprite);	
	
}
	
function blink(_off_time = 500, _on_time = _off_time, _phase_shift = 0, _clock = current_time){
	//_off_time: the time that the blink is in the off or hiding state
	//_on_time: the time that the blink is in the on or showing state
	//_phase_shift: the shift applied to the time before calculating the blink
	//_clock: incrimenting time variable is default but can be changed to another incrimenting variable
	
	//function can return 1 when it is on, to simulating blinking. Use with an If statment, etc
	//need to combine with separate draw code in the object that will blink

	return (_clock+_phase_shift) mod (_off_time+_on_time) >= _off_time;
	
}
	
function screen_pause(){
	//pause
	if (instance_exists(obj_pause)){
		image_speed = 0;	

		return true;
	}
	//unpause
	else {
		image_speed = 1;
		
		return false;
	}
}
	
function create_transition_and_move(_target_room){
	
	if (!instance_exists(obj_room_transition)){
		var _next_rm = instance_create_layer(0,0,"UI",obj_room_transition);
		_next_rm.target_room = _target_room;
	}
}