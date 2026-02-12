//set default variables

owner = noone;
hit_by_attack = ds_list_create(); //keeps track of which entities have been hit by current attack
attack_depth_range = 5;
deal_damage_to = noone;

damage = 1;
stun = 0;
knockback = 0;
hit_spark_x = 0;
hit_spark_y = 0;

//track how many times the attack made contact
hits_landed = 0;

hard_knockdown = false;


////loop through all players and add them (if friendly fire is off)
//var _num_players = instance_number(obj_player_parent); 
//var _player = noone;

////loop through all players
//for (var i = 1; i < _num_players+1; i++){
	
//	//get the current instance
//	//instance_find starts from 0
//	_player = instance_find(obj_player_parent,i-1);
	
//	//add yourself and other players to the list so you and they can't be hit by your attacks
//	ds_list_add(hit_by_attack,_player);
//	//show_debug_message("I added player "+string(i)+" the the hitbox list");
	
//}