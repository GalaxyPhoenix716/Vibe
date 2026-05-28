import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:vibe/core/constants.dart';

class MusicRepository {
  Future<void> uploadSong(File audio, File image) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${ServerConstant.serverURL}/song/upload'),
    );

    request
      ..files.addAll([
        await http.MultipartFile.fromPath('song_audio', audio.path),
        await http.MultipartFile.fromPath('thumbnail', image.path),
      ])
      ..fields.addAll({'artist': '', 'song_name': '', 'hex_code': ''})
      ..headers.addAll({'x-auth-token': ''});

    final response = await request.send();
  }
}
