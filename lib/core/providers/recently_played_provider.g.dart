// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recently_played_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RecentlyPlayed)
final recentlyPlayedProvider = RecentlyPlayedProvider._();

final class RecentlyPlayedProvider
    extends $NotifierProvider<RecentlyPlayed, List<SongModel>> {
  RecentlyPlayedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentlyPlayedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentlyPlayedHash();

  @$internal
  @override
  RecentlyPlayed create() => RecentlyPlayed();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<SongModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<SongModel>>(value),
    );
  }
}

String _$recentlyPlayedHash() => r'529dbba1a99774e75664f9a60ea52e6bdcc37b09';

abstract class _$RecentlyPlayed extends $Notifier<List<SongModel>> {
  List<SongModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<SongModel>, List<SongModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<SongModel>, List<SongModel>>,
              List<SongModel>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
