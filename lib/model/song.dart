class Song {
  final int id;
  final String cover;
  final String author;
  final String name;
  final String single;
  final Duration duration;
  final String asset;

  Song({
    required this.id,
    required this.cover,
    required this.author,
    required this.name,
    required this.single,
    required this.duration,
    required this.asset,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      cover: json['cover'] ?? '',
      author: json['author'] ?? '',
      name: json['name'] ?? '',
      single: json['single'] ?? '',
      duration: Duration(seconds: json['duration'] ?? 0),
      asset: json['asset'],
    );
  }

  factory Song.copyWith(Song song) {
    return Song(
      id: song.id,
      cover: song.cover,
      author: song.author,
      name: song.name,
      single: song.single,
      duration: song.duration,
      asset: song.asset,
    );
  }
}
