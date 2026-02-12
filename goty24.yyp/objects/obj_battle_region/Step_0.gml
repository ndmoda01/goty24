if (instance_exists(obj_enemy_parent)) and (place_meeting(x,y,obj_enemy_parent)){
	has_enemies = true;
}
else{
	has_enemies = false;	
	is_active = false;
}