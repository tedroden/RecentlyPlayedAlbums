tell application "iTunes"
	
	set finalPlaylistName to "Recently Played Albums"
	
	log "Getting a list of albums that were most recently played."
	set albumList to the album of every track of playlist "Most Recently Played Tracks"
	set shortAlbumList to {}
	repeat with i from 1 to count albumList
		tell my albumList's item i to if it is not in shortAlbumList and it ­ "" then set end of shortAlbumList to it
	end repeat
	
	log "Checking on the playlist"	
	if exists (some user playlist whose name is finalPlaylistName) then
		log " - The playlist exists, clearing"
		set _finalPlaylist to user playlist finalPlaylistName
		try
			delete every track of _finalPlaylist
		end try
	else
		log " - The playlist doesn't exist, creating"
		set _finalPlaylist to (make user playlist with properties {name:finalPlaylistName})
	end if
	
	
	-- got the list of albums to add
	log "Adding the tracks to the new playlist"
	repeat with i from 1 to count shortAlbumList
		set theAlbum to shortAlbumList's item i
		set theTracks to (tracks of library playlist 1 whose album is theAlbum)
		duplicate (tracks of library playlist 1 whose album is theAlbum) to _finalPlaylist
	end repeat
	log "Done."
	
	
end tell