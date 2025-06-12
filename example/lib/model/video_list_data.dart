import 'package:better_player_plus/better_player_plus.dart';

class VideoListData {
  final String videoTitle;
  final String videoUrl;
  final BetterPlayerVideoFormat format;
  Duration? lastPosition;
  bool? wasPlaying = false;

  VideoListData(this.videoTitle, this.videoUrl, this.format);
}
