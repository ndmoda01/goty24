/// @description Insert description here

position = array_create(20,-1);
position_index = 0;

if (room ==  rm_main_menu){
	var _x = 928;
	var _y = 704;
	
	position[0] = [_x, _y];
	position[1] = [_x, _y+64];
	position[2] = [_x, _y+256];

}

if (room ==  rm_lvl_1_intro){
	var _x = 928;
	var _y = 960;
	
	position[0] = [_x, _y];
	//position[1] = [_x, _y+64];
	//position[2] = [_x, _y+256];

}

if (room ==  rm_lvl_1_ending){
	var _x = 928;
	var _y = 960;
	
	position[0] = [_x, _y];
	//position[1] = [_x, _y+64];
	//position[2] = [_x, _y+256];
}