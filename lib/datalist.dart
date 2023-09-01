class Storage {
  late List<Playlist> playlists = [];
}

class Playlist {
  late String? playlist_ID;
  late String? playlist_name;
  late String? NumOfTracks;
  late List<Tracks> listTracks = [];
}

class Tracks {
  late String? track_name;
  late bool isLiked;
}

class User {
  late String? name;
}
