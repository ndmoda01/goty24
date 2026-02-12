/// @description Insert description here

var _enemy_id = other.owner;
if (instance_exists(_enemy_id)) and (_enemy_id.hp_current ==1) _enemy_id.hp_current--; //instance_destroy(_enemy_id);