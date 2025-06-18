import 'dart:developer';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:example/constants.dart';
import 'package:example/model/video_list_data.dart';
import 'package:example/pages/reusable_video_list/preload_video_widget.dart';
import 'package:example/pages/reusable_video_list/reusable_video_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';

class PreloadQueuePage extends StatefulWidget {
  const PreloadQueuePage({super.key});

  @override
  State<PreloadQueuePage> createState() => _PreloadQueuePageState();
}

class _PreloadQueuePageState extends State<PreloadQueuePage> {
  final exampleVideos = [
    "https://m.cdn.miniseri.co.id/ten_dates_ep1/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep2/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep3/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep4/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep5/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep6/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep7/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep8/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep9/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep10/hls/playlist.m3u8"
        "https://m.cdn.miniseri.co.id/ten_dates_ep1/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep2/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep3/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep4/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep5/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep6/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep7/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep8/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep9/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep10/hls/playlist.m3u8"
        "https://m.cdn.miniseri.co.id/ten_dates_ep1/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep2/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep3/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep4/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep5/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep6/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep7/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep8/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep9/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep10/hls/playlist.m3u8"
        "https://m.cdn.miniseri.co.id/ten_dates_ep1/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep2/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep3/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep4/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep5/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep6/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep7/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep8/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep9/hls/playlist.m3u8",
    "https://m.cdn.miniseri.co.id/ten_dates_ep10/hls/playlist.m3u8"
  ];

  late BetterPlayerPreloadController betterPlayerPreloadController;

  @override
  void initState() {
    betterPlayerPreloadController = BetterPlayerPreloadController(
      exampleVideos.map(
        (url) {
          return BetterPlayerDataSource(BetterPlayerDataSourceType.network, url,
              videoFormat: BetterPlayerVideoFormat.hls, bufferingConfiguration: BetterPlayerBufferingConfiguration());
        },
      ).toList(),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PreloadPageView.builder(
        // controller: pageController,
        itemCount: betterPlayerPreloadController.betterPlayerControllers.length,
        preloadPagesCount: betterPlayerPreloadController.betterPlayerControllers.length,
        scrollDirection: Axis.vertical,
        onPageChanged: (int index) {
          // final controller = betterPlayerPreloadController.betterPlayerControllers[index];
          // log('controller: ${controller?.betterPlayerDataSource?.url}');
          betterPlayerPreloadController.setupDataSource(index);
          setState(() {});
        },
        itemBuilder: (context, index) {
          final controller = betterPlayerPreloadController.betterPlayerControllers[index];
          return BetterPlayer(
            controller: controller!,
          );
        },
      ),
    );
  }
}
