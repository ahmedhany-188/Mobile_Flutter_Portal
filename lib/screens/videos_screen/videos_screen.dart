import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../bloc/videos_screen_bloc/videos_cubit.dart';
import '../../constants/url_links.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({Key? key}) : super(key: key);
  static const routeName = 'videos-screen';

  @override
  Widget build(BuildContext context) {



    return CustomBackground(
      child: CustomTheme(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Videos'),
            centerTitle: true,
          ),
          body: BlocProvider<VideosCubit>.value(
            value: VideosCubit.get(context),
            child: BlocBuilder<VideosCubit, VideosState>(
              builder: (context, state) {
                return Sizer(
                  builder: (c, or, dt) {
                    return ListView.builder(
                      key: UniqueKey(),
                      itemCount: VideosCubit.get(context).videosList.length,
                      itemBuilder: (ctx, index) {
                        return Column(
                          children: [
                            Text(VideosCubit.get(context)
                                .videosList[index]
                                .videoName!),
                            _VideoContent(
                              index: index,
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _VideoContent extends StatefulWidget {
  const _VideoContent({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  State<_VideoContent> createState() => _VideoContentState();
}

class _VideoContentState extends State<_VideoContent> {
  late VideoPlayerController _controller;

  // Future<ClosedCaptionFile> _loadCaptions() async {
  //   final String fileContents = await DefaultAssetBundle.of(context)
  //       .loadString('assets/bumble_bee_captions.vtt');
  //   return WebVTTCaptionFile(
  //       fileContents); // For vtt files, use WebVTTCaptionFile
  // }

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
      videosLinks(VideosCubit.get(context).videosList[widget.index].videoName!),
      // closedCaptionFile: _loadCaptions(),
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
      ),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(false);
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 50.h,
      padding: const EdgeInsets.all(20),
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          key: UniqueKey(),
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            VideoPlayer(
              _controller,
              key: UniqueKey(),
            ),
            ClosedCaption(text: _controller.value.caption.text),
            _ControlsOverlay(controller: _controller),
            SizedBox(
                height: 3.h,
                child: VideoProgressIndicator(_controller,
                    allowScrubbing: true, key: UniqueKey())),
          ],
        ),
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  // static const List<Duration> _exampleCaptionOffsets = <Duration>[
  //   // Duration(seconds: -10),
  //   // Duration(seconds: -3),
  //   // Duration(seconds: -1, milliseconds: -500),
  //   // Duration(milliseconds: -250),
  //   Duration(milliseconds: 0),
  //   Duration(milliseconds: 250),
  //   Duration(seconds: 1, milliseconds: 500),
  //   Duration(seconds: 3),
  //   // Duration(seconds: 10),
  // ];
  static const List<double> _examplePlaybackRates = <double>[
    // 0.25,
    // 0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    // 10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  height: 50.h,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0.sp,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: PopupMenuButton<Duration>(
        //     initialValue: controller.value.captionOffset,
        //     tooltip: 'Caption Offset',
        //     onSelected: (Duration delay) {
        //       controller.setCaptionOffset(delay);
        //     },
        //     itemBuilder: (BuildContext context) {
        //       return <PopupMenuItem<Duration>>[
        //         for (final Duration offsetDuration in _exampleCaptionOffsets)
        //           PopupMenuItem<Duration>(
        //             value: offsetDuration,
        //             child: Text('${offsetDuration.inMilliseconds}ms'),
        //           )
        //       ];
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(
        //         // Using less vertical padding as the text is also longer
        //         // horizontally, so it feels like it would need more spacing
        //         // horizontally (matching the aspect ratio of the video).
        //         vertical: 12,
        //         horizontal: 16,
        //       ),
        //       child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
        //     ),
        //   ),
        // ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<double>>[
                for (final double speed in _examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}
