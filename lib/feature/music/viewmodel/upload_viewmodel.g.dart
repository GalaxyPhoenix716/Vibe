// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getAllSongs)
final getAllSongsProvider = GetAllSongsProvider._();

final class GetAllSongsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SongModel>>,
          List<SongModel>,
          FutureOr<List<SongModel>>
        >
    with $FutureModifier<List<SongModel>>, $FutureProvider<List<SongModel>> {
  GetAllSongsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllSongsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllSongsHash();

  @$internal
  @override
  $FutureProviderElement<List<SongModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SongModel>> create(Ref ref) {
    return getAllSongs(ref);
  }
}

String _$getAllSongsHash() => r'9aa423ebaf13fdfa07303a2b08e88f84aec755b6';

@ProviderFor(UploadViewModel)
final uploadViewModelProvider = UploadViewModelProvider._();

final class UploadViewModelProvider
    extends $NotifierProvider<UploadViewModel, UploadState> {
  UploadViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uploadViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uploadViewModelHash();

  @$internal
  @override
  UploadViewModel create() => UploadViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UploadState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UploadState>(value),
    );
  }
}

String _$uploadViewModelHash() => r'41343e1a20ee7cac3218e69898c7cb8670c546ff';

abstract class _$UploadViewModel extends $Notifier<UploadState> {
  UploadState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<UploadState, UploadState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UploadState, UploadState>,
              UploadState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
