// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dynamicPlaylists)
final dynamicPlaylistsProvider = DynamicPlaylistsProvider._();

final class DynamicPlaylistsProvider
    extends
        $FunctionalProvider<
          List<PlaylistModel>,
          List<PlaylistModel>,
          List<PlaylistModel>
        >
    with $Provider<List<PlaylistModel>> {
  DynamicPlaylistsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dynamicPlaylistsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dynamicPlaylistsHash();

  @$internal
  @override
  $ProviderElement<List<PlaylistModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<PlaylistModel> create(Ref ref) {
    return dynamicPlaylists(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PlaylistModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PlaylistModel>>(value),
    );
  }
}

String _$dynamicPlaylistsHash() => r'3e2a6cbeaf19961afefd905003d177d9feadd1c4';
