/// @description Insert description here

if (type == PU_HEALTH){
	var _health_bonus = health_increase_amount;
	
	with(other.id) {
		//increase health without going over the player's max
		hp_current = min (hp_max, hp_current+_health_bonus);	
	}
	//audio_play_sound(snd_power_up_pickup,4,false);
	instance_destroy();
}