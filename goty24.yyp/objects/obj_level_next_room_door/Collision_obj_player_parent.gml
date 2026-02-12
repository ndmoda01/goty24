/// @description Insert description here

if (room_loaded == false){
	
	if (target_room != -1) and (target_x != -1) and (target_y != -1){
		RoomLoader.Load(target_room,target_x,target_y);
	}
	
	room_loaded = true;
	instance_destroy();

}