/// @desc
//will be moved to custom timer if we decide this movement system works
//the ai character first determines which side the target player 
//is facing. Then picks a spot in front of them and walks towards it.
//A little bit of randomnes is added to give the enemy ai a more 
//natural feel. And this is repeated every half second to 2 seconds.
alarm = 30 * choose(2,3,4,5);

var _player = instance_nearest(x,y,obj_player_parent);

var _side = _player.facing;//choose(1,-1);		//I was also experimenting with having the ai choose a random side
var _rx = random_range(20,-20);
var _ry = random_range(10,-10);
var _dist = 350 * _side;
var _px = _player.x + _dist + _rx;
var _py = _player.y + _ry;


if _player.x > x facing = 1 else facing = -1		// face the player

direction = point_direction(x,y,_px,_py);
if distance_to_point(_px,_py) > 250
{speed = 9 * choose(1.0, 1.5, 2.0)}
else {speed = 6.5;alarm = 45*choose(1,1,2,3)}
friction = 0.15;
