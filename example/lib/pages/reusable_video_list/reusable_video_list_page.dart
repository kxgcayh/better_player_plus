import 'dart:math';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:example/constants.dart';
import 'package:example/model/video_list_data.dart';
import 'package:example/pages/reusable_video_list/reusable_video_list_controller.dart';
import 'package:example/pages/reusable_video_list/reusable_video_list_widget.dart';
import 'package:flutter/material.dart';

class ReusableVideoListPage extends StatefulWidget {
  @override
  _ReusableVideoListPageState createState() => _ReusableVideoListPageState();
}

class _ReusableVideoListPageState extends State<ReusableVideoListPage> {
  ReusableVideoListController videoListController = ReusableVideoListController();
  final _random = Random();
  // final List<String> _videos = [
  //   'https://m.cdn.miniseri.co.id/back_to_twenty_ep1/dash/manifest.mpd',
  //   'https://m.cdn.miniseri.co.id/back_to_twenty_ep2/dash/manifest.mpd',
  //   'https://m.cdn.miniseri.co.id/back_to_twenty_ep3/dash/manifest.mpd',
  //   'https://m.cdn.miniseri.co.id/back_to_twenty_ep4/dash/manifest.mpd',
  //   'https://m.cdn.miniseri.co.id/back_to_twenty_ep5/dash/manifest.mpd',
  //   'https://m.cdn.miniseri.co.id/back_to_twenty_ep/dash/manifest.mpd',
  // ];
  List<VideoListData> dataList = [
    VideoListData('Back to twenty ep1', DashExample.backToTwentyEp1, BetterPlayerVideoFormat.dash),
    VideoListData('Back to twenty ep2', DashExample.backToTwentyEp2, BetterPlayerVideoFormat.dash),
    VideoListData('Back to twenty ep3', DashExample.backToTwentyEp3, BetterPlayerVideoFormat.dash),
    VideoListData('Back to twenty ep4', DashExample.backToTwentyEp4, BetterPlayerVideoFormat.dash),
    VideoListData('Back to twenty ep5', DashExample.backToTwentyEp5, BetterPlayerVideoFormat.dash),
    VideoListData('Back to twenty ep6', DashExample.backToTwentyEp6, BetterPlayerVideoFormat.dash),
    VideoListData('Back to twenty ep7', DashExample.backToTwentyEp7, BetterPlayerVideoFormat.dash),
    VideoListData('Back to twenty ep8', DashExample.backToTwentyEp8, BetterPlayerVideoFormat.dash),
  ];
  var value = 0;
  final ScrollController _scrollController = ScrollController();
  int lastMilli = DateTime.now().millisecondsSinceEpoch;
  bool _canBuildVideo = true;

  @override
  void initState() {
    _setupData();
    super.initState();
  }

  void _setupData() {
    for (int index = 0; index < 20; index++) {
      // var randomVideoUrl = _videos[_random.nextInt(_videos.length)];
      // dataList.add(
      //   VideoListData("Video $index", randomVideoUrl, BetterPlayerVideoFormat.dash),
      // );
    }
  }

  @override
  void dispose() {
    videoListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reusable video list")),
      body: Container(
        color: Colors.grey,
        child: Column(children: [
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                final now = DateTime.now();
                final timeDiff = now.millisecondsSinceEpoch - lastMilli;
                if (notification is ScrollUpdateNotification) {
                  final pixelsPerMilli = notification.scrollDelta! / timeDiff;
                  if (pixelsPerMilli.abs() > 1) {
                    _canBuildVideo = false;
                  } else {
                    _canBuildVideo = true;
                  }
                  lastMilli = DateTime.now().millisecondsSinceEpoch;
                }

                if (notification is ScrollEndNotification) {
                  _canBuildVideo = true;
                  lastMilli = DateTime.now().millisecondsSinceEpoch;
                }

                return true;
              },
              child: ListView.builder(
                itemCount: dataList.length,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  VideoListData videoListData = dataList[index];
                  return ReusableVideoListWidget(
                    videoListData: videoListData,
                    videoListController: videoListController,
                    canBuildVideo: _checkCanBuildVideo,
                  );
                },
              ),
            ),
          )
        ]),
      ),
    );
  }

  bool _checkCanBuildVideo() {
    return _canBuildVideo;
  }
}
