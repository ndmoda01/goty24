//this object is used to lock the players into a specific area once they enter
//triggers combat camera movement and will activate enemies

is_active = false;

region_height = sprite_height;
region_width = sprite_width;


left_edge = x-region_width/2;
right_edge = x+region_width/2;
top_edge = y-region_height/2;
bottom_edge = y+region_height/2;

has_enemies = false;