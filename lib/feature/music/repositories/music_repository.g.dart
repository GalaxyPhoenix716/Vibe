// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(musicRepository)
final musicRepositoryProvider = MusicRepositoryProvider._();

final class MusicRepositoryProvider
    extends
        $FunctionalProvider<MusicRepository, MusicRepository, MusicRepository>
    with $Provider<MusicRepository> {
  MusicRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'musicRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$musicRepositoryHash();

  @$internal
  @override
  $ProviderElement<MusicRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MusicRepository create(Ref ref) {
    return musicRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MusicRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MusicRepository>(value),
    );
  }
}

String _$musicRepositoryHash() => r'82f237f9968f99b1be1232845a6a43f8cd1efecf';
