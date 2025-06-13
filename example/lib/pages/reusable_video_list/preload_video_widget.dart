import 'package:better_player_plus/better_player_plus.dart';
import 'package:example/model/video_list_data.dart';
import 'package:flutter/material.dart';

class PreloadVideoWidget extends StatefulWidget {
  const PreloadVideoWidget({
    super.key,
    this.index = 0,
    this.total = 0,
    required this.videoData,
    // required this.videoListController,
  });

  final int index;
  final int total;
  final VideoListData videoData;
  // final ReusableVideoListController videoListController;

  @override
  State<PreloadVideoWidget> createState() => _PreloadVideoWidgetState();
}

class _PreloadVideoWidgetState extends State<PreloadVideoWidget> {
  VideoListData get videoData => widget.videoData;
  late BetterPlayerController controller;
  late BetterPlayerDataSource dataSource;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration = BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );
    dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      videoData.videoUrl,
      videoFormat: videoData.format,
      cacheConfiguration: BetterPlayerCacheConfiguration(
        useCache: true,
        preCacheSize: 10 * 1024 * 1024,
        maxCacheSize: 10 * 1024 * 1024,
        maxCacheFileSize: 10 * 1024 * 1024,
        key: "testCacheKey:${videoData.hashCode}",
      ),
    );
    controller = BetterPlayerController(betterPlayerConfiguration);
    controller.preCache(dataSource);
    controller.setupDataSource(dataSource);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BetterPlayer(controller: controller),
        Center(
          child: Text('${widget.videoData.videoTitle} - index ${widget.index} - total ${widget.total}'),
        ),
      ],
    );
  }
}
