//UI related
function create_transition_and_move(_target_room){
	//create a transition effect, then move to the set target room
	
	if (!instance_exists(obj_room_transition)){
		var _next_rm = instance_create_layer(0,0,"UI",obj_room_transition);
		_next_rm.target_room = _target_room;
	}
}

function screen_pause(){
	//if obj_pause is present, animations will stop
	
	//pause (bein pause state)
	if (instance_exists(obj_pause)){
		image_speed = 0;	
		return true;
	}
	//unpause (exit pause state)
	else {
		image_speed = 1;
		return false;
	}
}

function screen_shake(_shake_magnitude = 1,_shake_length=10){
	// shake's magnitude, frames
	// magnitude sets strength of the shake (radius in pixels)
	// frames sets the length of the shake in frames (60 = 1 sec at 60fps)
	
	with (obj_camera){
		if (_shake_magnitude > shake_remain){
			shake_magnitude = _shake_magnitude;
			shake_remain = shake_magnitude;
			shake_length = _shake_length;
		}
	}
}


//Player / Enemy Related
function animation_end(){ 
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
	//_phase_shift: a shift or offset that can be applied to the time before calculating the blink
	//_clock: incrimenting time variable is default but can be changed to another incrimenting variable
	
	//function can return 1 when it is on, to simulating blinking. Use with an If statment, etc
	//need to combine with separate a variable or code in the draw event of the instance to make it blink based on the return from this function

	return (_clock+_phase_shift) mod (_off_time+_on_time) >= _off_time;
	
}

function flash_white(){
	//make something flash white for as long as the instance's flash variable is above 0
	//must be called in a Draw event
	
	if (flash > 0){
		flash--;
		shader_set(sha_white);
		draw_sprite_ext(sprite_index,image_index,x,y+z,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
		shader_reset();
	}
}
	
function hurtbox_create(_width = 16, _height = 46){
	//create the hurtbox for the entity, and then modify it so it fits it's host size (all objects use the same hurtbox object)
	
	var _hurt_b = instance_create_depth(x,y,-4000,obj_hurtbox_parent);
	
	_hurt_b.owner = id;
	_hurt_b.image_xscale = _width*image_xscale;
	_hurt_b.image_yscale = _height*image_yscale;
	
	//return the hurtbox id so the instance can reference it later when it needs to be updated
	return _hurt_b;
}

function hurtbox_update(_x_offset = 0, _y_offset = 0){
	//update the hurtbox location each frame so it is accurate to the instance's current apparent position
	
	if (instance_exists(my_body_hurtbox)){
		my_body_hurtbox.image_xscale = my_body_hurtbox.image_xscale*facing;
		my_body_hurtbox.x = (x - my_body_hurtbox.sprite_width/2) + (_x_offset*facing); //center it
		my_body_hurtbox.y = (y+z) + _y_offset; //offset the height using z, so it's accurate to its owner's apparent on screen position
	}
}
	
function place_meeting_3d(_x,_y,_z,_obj){
	//works likes standard place meeting, but with a z check added

	//height is defined in the object's create event (apparent number of pixels high from the origin)
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
	

	

	

	
