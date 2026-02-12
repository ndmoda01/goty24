/// @description Insert description here

if (room == rm_title){
	//reset any previous game over status
	obj_game.game_over = false;	
	obj_game.level_complete = false; 
}

//temp method to spawn players at the beginning of the level (change later)
if (room == rm_level_1_1){
	
	//if (numb_players_game_setting == 1){
	//	instance_create_layer(96,176,"Instances",obj_player_1);	
	//}
	
	//if (numb_players_game_setting == 2){
	//	instance_create_layer(96,176,"Instances",obj_player_1);	
	//	instance_create_layer(64,208,"Instances",obj_player_2);	
	//}

}

//room loader setup
//load in the rooms that will need to be loaded dynamically
RoomLoader.DataInit(rm_level_1_2a,rm_level_1_2b,rm_level_1_2c,rm_level_1_3,rm_level_1_3a);
//RoomLoader.data_init(rm_level_1_2b);
//RoomLoader.data_init(rm_level_1_2c);
//RoomLoader.data_init(rm_level_1_3);