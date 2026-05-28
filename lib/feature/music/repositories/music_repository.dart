import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';
import 'package:vibe/core/constants.dart';
import 'package:vibe/core/failure/failure.dart';

class MusicRepository {
  Future<Either<AppFailure, String>> uploadSong(
    File audio,
    File image,
    String artist,
    String songname,
    String hexcode,
  ) async {
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
        ..fields.addAll({
          'artist': artist,
          'song_name': songname,
          'hex_code': hexcode,
        })
        ..headers.addAll({'x-auth-token': ''});

      final response = await request.send();

      if (response.statusCode != 201) {
        return Left(AppFailure(await response.stream.bytesToString()));
      }

      return Right(await response.stream.bytesToString());
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
