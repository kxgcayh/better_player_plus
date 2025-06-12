import 'package:better_player_plus/better_player_plus.dart';
import 'package:example/constants.dart';
import 'package:example/model/video_list_data.dart';
import 'package:example/pages/reusable_video_list/reusable_video_list_controller.dart';
import 'package:example/pages/reusable_video_list/reusable_video_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';

class PreloadQueuePage extends StatefulWidget {
  const PreloadQueuePage({super.key});

  @override
  State<PreloadQueuePage> createState() => _PreloadQueuePageState();
}

class _PreloadQueuePageState extends State<PreloadQueuePage> {
  ReusableVideoListController videoListController = ReusableVideoListController();
  List<VideoListData> dataList = <VideoListData>[
    VideoListData('Back to twenty ep1', DashExample.backToTwentyEp1, BetterPlayerVideoFormat.dash),
    VideoListData('Back to twenty ep2', DashExample.backToTwentyEp2, BetterPlayerVideoFormat.dash),
    VideoListData('Back to twenty ep3', DashExample.backToTwentyEp3, BetterPlayerVideoFormat.dash),
    VideoListData('Back to twenty ep4', DashExample.backToTwentyEp4, BetterPlayerVideoFormat.dash),
    VideoListData('Back to twenty ep5', DashExample.backToTwentyEp5, BetterPlayerVideoFormat.dash),
    VideoListData('Back to twenty ep6', DashExample.backToTwentyEp6, BetterPlayerVideoFormat.dash),
    VideoListData('Back to twenty ep7', DashExample.backToTwentyEp7, BetterPlayerVideoFormat.dash),
    VideoListData('Back to twenty ep8', DashExample.backToTwentyEp8, BetterPlayerVideoFormat.dash),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    videoListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        // body: PreloadPageView.builder(
        // controller: pageController,
        itemCount: dataList.length,
        // preloadPagesCount: 3,
        scrollDirection: Axis.vertical,
        onPageChanged: (int index) {
          // log('dataList(${dataList.length})');
          // dataList.add(VideoListData('videoTitle', 'videoUrl', BetterPlayerVideoFormat.dash));
          // setState(() {});
        },
        itemBuilder: (context, index) {
          VideoListData videoListData = dataList[index];
          return ReusableVideoListWidget(
            videoListData: videoListData,
            videoListController: videoListController,
            canBuildVideo: () => true,
          );
          // return SafeArea(
          //   child: Center(child: Text('OKAY - $index - ${dataList.length}')),
          // );
        },
      ),
    );
  }

  bool _checkCanBuildVideo() {
    return true;
  }
}
