import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vibe/core/constants.dart';
import 'package:vibe/core/failure/failure.dart';

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
        ..fields.addAll({'artist': artist, 'song_name': songName})
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
}
