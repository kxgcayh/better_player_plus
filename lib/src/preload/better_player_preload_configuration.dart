import 'package:better_player_plus/better_player_plus.dart';

class BetterPlayerPreloadConfiguration {
  final BetterPlayerCacheConfiguration cacheConfiguration;

  ///Should videos be looped
  final bool loopVideos;

  ///Index of video that will start on playlist start. Id must be less than
  ///elements in data source list. Default is 0.
  final int initialStartIndex;

  const BetterPlayerPreloadConfiguration({
    this.cacheConfiguration = const BetterPlayerCacheConfiguration(
      useCache: true,
      preCacheSize: 10 * 1024 * 1024,
      maxCacheSize: 10 * 1024 * 1024,
      maxCacheFileSize: 10 * 1024 * 1024,
      // key: "testCacheKey:${videoData.hashCode}",
    ),
    this.loopVideos = true,
    this.initialStartIndex = 0,
  });
}
