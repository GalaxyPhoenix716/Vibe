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

      if (response.statusCode >= 400) {
        return Left(AppFailure(await response.stream.bytesToString()));
      }

      final decodedBody = jsonDecode(await response.stream.bytesToString());

      return Right(decodedBody['message']);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
