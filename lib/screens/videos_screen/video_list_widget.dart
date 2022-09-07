import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';

import '../../constants/url_links.dart';
import '../../data/models/videos_model/videos_id_model.dart';

class VideoListWidget extends StatefulWidget {
  final VideosIdData? videoListData;

  const VideoListWidget({Key? key, this.videoListData}) : super(key: key);

  @override
  _VideoListWidgetState createState() => _VideoListWidgetState();
}

class _VideoListWidgetState extends State<VideoListWidget> {
  VideosIdData? get videoListData => widget.videoListData;
  BetterPlayerConfiguration? betterPlayerConfiguration;
  BetterPlayerListVideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    controller = BetterPlayerListVideoPlayerController();
    betterPlayerConfiguration = const BetterPlayerConfiguration(
        autoPlay: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(
            playerTheme: BetterPlayerTheme.cupertino));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTheme(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        color: Colors.black38,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  videoListData?.videoName ?? '',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: AspectRatio(
                aspectRatio: 15/9,
                child: BetterPlayerListVideoPlayer(
                  BetterPlayerDataSource(
                    BetterPlayerDataSourceType.network,
                    videosLinks(videoListData!.videoName!),
                    notificationConfiguration:
                        const BetterPlayerNotificationConfiguration(
                      showNotification: true,
                    ),
                    bufferingConfiguration:
                        const BetterPlayerBufferingConfiguration(
                            minBufferMs: 2000,
                            maxBufferMs: 10000,
                            bufferForPlaybackMs: 1000,
                            bufferForPlaybackAfterRebufferMs: 2000),
                  ),
                  configuration: const BetterPlayerConfiguration(
                      controlsConfiguration: BetterPlayerControlsConfiguration(
                        playerTheme: BetterPlayerTheme.cupertino,
                        enableFullscreen: false,
                      ),
                      autoPlay: false,
                      aspectRatio: 1,
                      handleLifecycle: true),
                  playFraction: 0.8,
                  betterPlayerListVideoPlayerController: controller,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
