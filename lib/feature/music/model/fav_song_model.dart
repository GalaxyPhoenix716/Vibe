import 'dart:convert';

class FavSongModel {
  final String id;
  final String songId;
  final String userId;

  FavSongModel({required this.id, required this.songId, required this.userId});

  FavSongModel copyWith({String? id, String? songId, String? userId}) {
    return FavSongModel(
      id: id ?? this.id,
      songId: songId ?? this.songId,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'songId': songId, 'userId': userId};
  }

  factory FavSongModel.fromMap(Map<String, dynamic> map) {
    return FavSongModel(
      id: map['id'] as String,
      songId: (map['songId'] ?? map['song_id']) as String,
      userId: (map['userId'] ?? map['user_id']) as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavSongModel.fromJson(String source) =>
      FavSongModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FavSongModel(id: $id, songId: $songId, userId: $userId)';

  @override
  bool operator ==(covariant FavSongModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.songId == songId && other.userId == userId;
  }

  @override
  int get hashCode => id.hashCode ^ songId.hashCode ^ userId.hashCode;
}
