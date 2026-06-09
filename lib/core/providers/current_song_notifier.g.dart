// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_song_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentQueue)
final currentQueueProvider = CurrentQueueProvider._();

final class CurrentQueueProvider
    extends $NotifierProvider<CurrentQueue, List<SongModel>> {
  CurrentQueueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentQueueProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentQueueHash();

  @$internal
  @override
  CurrentQueue create() => CurrentQueue();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<SongModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<SongModel>>(value),
    );
  }
}

String _$currentQueueHash() => r'e0a6a55169bad3ad7d95e54ceaf0b45ce9dbf734';

abstract class _$CurrentQueue extends $Notifier<List<SongModel>> {
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
    r'fb8e58853007adb8a459cf00353ed0bd15040b64';

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

@ProviderFor(isPlaying)
final isPlayingProvider = IsPlayingProvider._();

final class IsPlayingProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  IsPlayingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isPlayingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isPlayingHash();

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    return isPlaying(ref);
  }
}

String _$isPlayingHash() => r'e484ab2ffb0b4e6e942481ff3897e4e101d3144e';

@ProviderFor(currentSongDuration)
final currentSongDurationProvider = CurrentSongDurationProvider._();

final class CurrentSongDurationProvider
    extends
        $FunctionalProvider<AsyncValue<Duration?>, Duration?, Stream<Duration?>>
    with $FutureModifier<Duration?>, $StreamProvider<Duration?> {
  CurrentSongDurationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentSongDurationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentSongDurationHash();

  @$internal
  @override
  $StreamProviderElement<Duration?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Duration?> create(Ref ref) {
    return currentSongDuration(ref);
  }
}

String _$currentSongDurationHash() =>
    r'37eb5164fac01c0c627a1acd2a4631b497b04c81';

@ProviderFor(currentSongPosition)
final currentSongPositionProvider = CurrentSongPositionProvider._();

final class CurrentSongPositionProvider
    extends
        $FunctionalProvider<AsyncValue<Duration>, Duration, Stream<Duration>>
    with $FutureModifier<Duration>, $StreamProvider<Duration> {
  CurrentSongPositionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentSongPositionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentSongPositionHash();

  @$internal
  @override
  $StreamProviderElement<Duration> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Duration> create(Ref ref) {
    return currentSongPosition(ref);
  }
}

String _$currentSongPositionHash() =>
    r'9622debb37e9f8f661e6041fd9ed9038cc86a042';
