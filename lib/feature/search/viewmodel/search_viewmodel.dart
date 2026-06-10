import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vibe/feature/auth/viewmodel/auth_viewmodel.dart';
import 'package:vibe/feature/home/model/song_model.dart';
import 'package:vibe/feature/music/repositories/music_repository.dart';

part 'search_viewmodel.g.dart';

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void updateQuery(String newQuery) {
    state = newQuery;
  }

  void clearQuery() {
    state = '';
  }
}

@riverpod
Future<List<SongModel>> searchSongs(Ref ref, {required String query}) async {
  if (query.trim().isEmpty) return [];

  final token = ref.read(authRepositoryProvider).token;
  if (token == null) return [];

  //debounce for avoiding rapid type searches
  await Future.delayed(const Duration(milliseconds: 350));

  final musicRepo = ref.read(musicRepositoryProvider);
  final res = await musicRepo.searchSongs(query: query, token: token);

  return res.fold((failure) => throw failure.message, (songs) => songs);
}
