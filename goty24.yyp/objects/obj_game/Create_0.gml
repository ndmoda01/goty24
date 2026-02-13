/// @description Initial game variable setup

//debug = true;
debug = false;

//friendly_fire, if false, you can't damage friendly objects
friendly_fire = false;

//max number of players at any time
numb_players_max = 2;
//how many players are the game is currently configured to expect in game settings (DIFFICULTY, etc)
numb_players_game_setting = 1;
//how many players are alive / currently playing (players may join or be knocked out mid level, so may be different than game settings)
numb_players_active = 1;

player_starting_lives = 2;
player_1_lives = player_starting_lives ;
player_1_enemy_ko_total = 0;

player_2_lives = player_starting_lives ;
player_2_enemy_ko_total = 0;

player_3_lives = player_starting_lives ;
player_3_enemy_ko_total = 0;

player_4_lives = player_starting_lives ;
player_4_enemy_ko_total = 0;

game_over = false;
level_complete = false;

game_set_speed(60,gamespeed_fps);


//multiplayer input setup for Input library
//input sources are assigned to the next player that doesn't have an input already assigned up to the max player count
// no longer needed in Input v10? input_source_mode_set(INPUT_SOURCE_MODE.JOIN);
InputPartySetParams(gp_face3,1,numb_players_max,false,undefined);


room_goto_next();
