//size, variables and mode setup
w = view_get_wport(0);
h = view_get_hport(0);


// 0 fade in
// 1 fade out
state = 0;


alpha = 0;
transition_speed = .03;

//room to transition to
target_room = -1;
