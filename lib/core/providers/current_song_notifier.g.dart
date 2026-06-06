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
    r'518b54ff11270e759395b12f01adfdb024f5fa64';

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
