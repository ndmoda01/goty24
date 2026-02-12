other_player_obj	= obj_player_2;
owner				= 1;
enemy				= 2;



//base_damage			= 10;
damage_strength		= 1;
pushback			= 5; //the amount of pushback on hit

//the attack will need a range to determine the depth of the attack (or looking at the scene from top down the width of the attack)
//this value will determine how close (+ or - Y pos) a hurtbox will need to be to be hit
//a hittable object will need to be within the range +/- Y of the attack_depth_range to be hit
attack_depth_range = 10;


//dmg				= 10;
continuous		= false; //does it hit every frame? or just once?

//hit_spark		= obj_hitspark;
//hit_sound		= snd_med_attack_hit;




//new code
//array that will hold the instances this hitbox should damage
//ex. [enemy] or [player, environment] or [enemy, enviornment] or [player, enemy, enviornment] 
deal_damage_to = array_create(2,-1);