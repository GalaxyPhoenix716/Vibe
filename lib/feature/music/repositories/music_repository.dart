import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vibe/core/constants.dart';
import 'package:vibe/core/failure/failure.dart';
import 'package:vibe/feature/home/model/song_model.dart';

part 'music_repository.g.dart';

@riverpod
MusicRepository musicRepository(Ref ref) {
  return MusicRepository();
}

class MusicRepository {
  Future<Either<AppFailure, String>> uploadSong({
    required File audio,
    required File image,
    required String artist,
    required String songName,
    required String tags,
    required String token,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${ServerConstant.serverURL}/song/upload'),
      );

      request
        ..files.addAll([
          await http.MultipartFile.fromPath('song_audio', audio.path),
          await http.MultipartFile.fromPath('thumbnail', image.path),
        ])
        ..fields.addAll({'artist': artist, 'song_name': songName, 'tags': tags})
        ..headers.addAll({'Authorization': 'Bearer $token'});

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final data = jsonDecode(responseBody);

      if (response.statusCode != 201) {
        return Left(AppFailure(data['detail'] ?? 'Upload failed'));
      }

      return Right(data['message']);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, List<SongModel>>> getAllSongs({
    required String token,
  }) async {
    try {
      final res = await http.get(
        Uri.parse('${ServerConstant.serverURL}/song/list'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var resBodyMap = jsonDecode(res.body);

      if (res.statusCode != 200) {
        resBodyMap = resBodyMap as Map<String, dynamic>;
        return Left(AppFailure(resBodyMap['detail']));
      }

      resBodyMap = resBodyMap as List;
      List<SongModel> songs = [];

      for (final map in resBodyMap) {
        songs.add(SongModel.fromMap(map));
      }

      return Right(songs);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, List<SongModel>>> getAllFavSongs({
    required String token,
  }) async {
    try {
      final res = await http.get(
        Uri.parse('${ServerConstant.serverURL}/song/list-favourites'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var resBodyMap = jsonDecode(res.body);

      if (res.statusCode != 200) {
        resBodyMap = resBodyMap as Map<String, dynamic>;
        return Left(AppFailure(resBodyMap['detail']));
      }

      resBodyMap = resBodyMap as List;
      List<SongModel> songs = [];

      for (final map in resBodyMap) {
        songs.add(SongModel.fromMap(map['song']));
      }

      return Right(songs);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, bool>> favSong({
    required String songId,
    required String token,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('${ServerConstant.serverURL}/song/favourite'),
        body: jsonEncode({'song_id': songId}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var resBodyMap = jsonDecode(res.body);

      if (res.statusCode != 200 && res.statusCode != 201) {
        resBodyMap = resBodyMap as Map<String, dynamic>;
        return Left(AppFailure(resBodyMap['detail'] ?? 'Failed to toggle favourite'));
      }

      return Right(resBodyMap['message']);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
