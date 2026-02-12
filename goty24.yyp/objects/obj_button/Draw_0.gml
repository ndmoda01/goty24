/// @description Insert description here

if (obj_game.debug) draw_self();

//draw_set_font(fnt_menu_medium);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

//selected - you've selected it
if (selected == true){
	var c = c_lime;
	draw_text_color(x+16,y,my_text,c,c,c,c,1);	
}
//normal - you can select it
else if (selectable == true){
	if (place_meeting(x,y,obj_menu_cursor)){
		var c = c_white;
		draw_text_color(x+16,y,my_text,c,c,c,c,1);	
	}
	else{
		draw_text(x+16,y,my_text);
	}
}
//can't select it
else {
	var c = c_dkgray;
	draw_text_color(x+16,y,my_text,c,c,c,c,1);	
}