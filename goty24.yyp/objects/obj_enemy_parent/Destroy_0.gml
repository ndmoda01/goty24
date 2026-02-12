/// @description Insert description here

//this is needed in case the instance is destroyed outside of a death script
//which leaves the hurtbox undestroyed. this ensures it will always be destroyed
if (instance_exists(my_body_hurtbox)) instance_destroy(my_body_hurtbox);

