hurtbox_update(my_body_hurtbox_x_offset,);

//updated hitbox location for air attacks
if (instance_exists(current_hitbox)){
	current_hitbox.y = y+z;
	current_hitbox.x = x;
}