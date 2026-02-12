//pause and unpause music
if (instance_exists(obj_pause)) audio_pause_all();
else{
	if (audio_is_paused(level_playlist[song_index])) audio_resume_all();
}

//level 1 music playlist
if (room == rm_level_1_1){
	
	//if the current track is done playing
	if (!audio_is_playing(level_playlist[song_index])){
		//increment the index to start the next track
		song_index++;
		//wrap around if you're out of songs
		if (song_index > (array_length(level_playlist)-1)) song_index = 0;
		//play the next song
		audio_play_sound(level_playlist[song_index],0,false);
	}
}