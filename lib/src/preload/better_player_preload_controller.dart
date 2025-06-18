import 'dart:developer';

import 'package:better_player_plus/better_player_plus.dart';

class BetterPlayerPreloadController {
  ///List of data sources set for playlist.
  final List<BetterPlayerDataSource> _betterPlayerDataSourceList;

  //General configuration of Better Player
  final BetterPlayerConfiguration betterPlayerConfiguration;

  ///Preload configuration of Better Player
  final BetterPlayerPreloadConfiguration betterPlayerPreloadConfiguration;

  BetterPlayerPreloadController(
    this._betterPlayerDataSourceList, {
    this.betterPlayerConfiguration = const BetterPlayerConfiguration(
      aspectRatio: 16 / 29,
    ),
    this.betterPlayerPreloadConfiguration = const BetterPlayerPreloadConfiguration(),
  }) : assert(_betterPlayerDataSourceList.isNotEmpty, "Better Player data source list can't be empty") {
    _setup();
  }

  ///List of data sources set for playlist.
  Map<int, BetterPlayerController> betterPlayerControllers = <int, BetterPlayerController>{};

  ///BetterPlayerController instance
  BetterPlayerController? _betterPlayerController;

  ///Currently playing data source index
  int _currentDataSourceIndex = 0;

  ///Initialize controller and listeners.
  void _setup() {
    _betterPlayerController ??= BetterPlayerController(
      betterPlayerConfiguration,
      betterPlayerPreloadConfiguration: betterPlayerPreloadConfiguration,
    );

    var initialStartIndex = betterPlayerPreloadConfiguration.initialStartIndex;
    if (initialStartIndex >= _betterPlayerDataSourceList.length) {
      initialStartIndex = 0;
    }

    _currentDataSourceIndex = initialStartIndex;

    setupDataSource(_currentDataSourceIndex);
  }

  ///Setup data source with index based on [_betterPlayerDataSourceList] provided
  ///in constructor. Index must
  void setupDataSource(int index) {
    assert(
        index >= 0 && index < _betterPlayerDataSourceList.length,
        "Index must be greater than 0 and less than size of data source "
        "list - 1");
    if (index <= _dataSourceLength) {
      _currentDataSourceIndex = index;
      log('incoming index: $index, current: $_currentDataSourceIndex');

      // Make sure betterPlayerControllers has same _betterPlayerDataSourceList length
      // in each call
      if (betterPlayerControllers.length != _betterPlayerDataSourceList.length) {
        for (final betterPlayerDataSource in _betterPlayerDataSourceList.indexed) {
          betterPlayerControllers[betterPlayerDataSource.$1] = _betterPlayerController!;
        }
      }

      // update betterPlayerControllers that will have datasource
      final dataSources = setWillActiveDataSource(currentIndex: _currentDataSourceIndex);
      for (final dataSource in dataSources.entries) {
        // log('dataSource:(${dataSource.key})::${dataSource.value.url}');
        final controller = betterPlayerControllers[dataSource.key]!;
        if (controller.isVideoInitialized() == false) {
          // controller.setupDataSource(dataSource.value); // not working
          betterPlayerControllers[dataSource.key] = BetterPlayerController(
            betterPlayerConfiguration,
            betterPlayerDataSource: dataSource.value,
          );
        }
      }

      _betterPlayerController = betterPlayerControllers[_currentDataSourceIndex];

      for (final controller in betterPlayerControllers.entries) {
        log('available controller: ${controller.value.isVideoInitialized()}');
      }
    }
  }

  Map<int, BetterPlayerDataSource> setWillActiveDataSource({
    required int currentIndex,
    int range = 5,
  }) {
    // Jika list asli lebih pendek dari range, kembalikan list asli
    if (_betterPlayerDataSourceList.length <= range) {
      return _betterPlayerDataSourceList.asMap();
    }

    // Tentukan posisi tengah yang diinginkan
    final int middlePosition = (range / 2).floor(); // Untuk range 5, hasilnya 2

    // Hitung startIndex dengan mencoba menempatkan currentIndex di tengah
    int startIndex = currentIndex - middlePosition;

    // Gunakan clamp untuk memastikan startIndex tidak keluar dari batas yang valid
    // Batas bawah adalah 0
    // Batas atas adalah posisi awal terakhir yang memungkinkan untuk mengambil 'range' item
    startIndex = startIndex.clamp(0, _betterPlayerDataSourceList.length - range);

    // Tentukan endIndex
    final int endIndex = startIndex + range;

    // Ambil sublist berdasarkan startIndex dan endIndex
    // return _betterPlayerDataSourceList.sublist(startIndex, endIndex);
    return {
      for (int i = startIndex; i < endIndex; i++) i: _betterPlayerDataSourceList[i],
    };
  }

  ///Get size of [_betterPlayerDataSourceList]
  int get _dataSourceLength => _betterPlayerDataSourceList.length;

  BetterPlayerController? get betterPlayerController => betterPlayerControllers[_currentDataSourceIndex];
}
