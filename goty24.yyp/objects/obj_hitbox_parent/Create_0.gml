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




