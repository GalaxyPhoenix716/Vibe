// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:vibe/feature/music/model/fav_song_model.dart';

class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.favSongs,
  });
  final String id;
  final String name;
  final String email;
  final List<FavSongModel> favSongs;

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    List<FavSongModel>? favSongs,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      favSongs: favSongs ?? this.favSongs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'favSongs': favSongs.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: json['name'].toString(),
      email: json['email'].toString(),
      favSongs: [],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, favSongs: $favSongs)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        listEquals(other.favSongs, favSongs);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ favSongs.hashCode;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      favSongs: List<FavSongModel>.from(
        (map['favSongs'] ?? []).map<FavSongModel>(
          (x) => FavSongModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
