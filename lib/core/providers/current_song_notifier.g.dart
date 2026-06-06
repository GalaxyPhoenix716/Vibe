// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_song_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(audioPlayerInstance)
final audioPlayerInstanceProvider = AudioPlayerInstanceProvider._();

final class AudioPlayerInstanceProvider
    extends $FunctionalProvider<AudioPlayer, AudioPlayer, AudioPlayer>
    with $Provider<AudioPlayer> {
  AudioPlayerInstanceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioPlayerInstanceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioPlayerInstanceHash();

  @$internal
  @override
  $ProviderElement<AudioPlayer> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AudioPlayer create(Ref ref) {
    return audioPlayerInstance(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AudioPlayer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AudioPlayer>(value),
    );
  }
}

String _$audioPlayerInstanceHash() =>
    r'b447b285bbdaca8b4fb48ea88b42f42f4d1033e0';

@ProviderFor(currentSongColor)
final currentSongColorProvider = CurrentSongColorProvider._();

final class CurrentSongColorProvider
    extends $FunctionalProvider<AsyncValue<Color>, Color, FutureOr<Color>>
    with $FutureModifier<Color>, $FutureProvider<Color> {
  CurrentSongColorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentSongColorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentSongColorHash();

  @$internal
  @override
  $FutureProviderElement<Color> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Color> create(Ref ref) {
    return currentSongColor(ref);
  }
}

String _$currentSongColorHash() => r'03a9a0971167e3a7ac06991c6ae59ca045605119';

@ProviderFor(CurrentSongNotifier)
final currentSongProvider = CurrentSongNotifierProvider._();

final class CurrentSongNotifierProvider
    extends $NotifierProvider<CurrentSongNotifier, SongModel?> {
  CurrentSongNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentSongProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentSongNotifierHash();

  @$internal
  @override
  CurrentSongNotifier create() => CurrentSongNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SongModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SongModel?>(value),
    );
  }
}

String _$currentSongNotifierHash() =>
    r'821320270f7da15216ffcb729408c7c6851db334';

abstract class _$CurrentSongNotifier extends $Notifier<SongModel?> {
  SongModel? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SongModel?, SongModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SongModel?, SongModel?>,
              SongModel?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
