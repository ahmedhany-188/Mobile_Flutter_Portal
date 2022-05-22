import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

import '../../bloc/videos_screen_bloc/videos_cubit.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({Key? key}) : super(key: key);
  static const routeName = 'videos-screen';

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  late VideoPlayerController _controller;

  Future<ClosedCaptionFile> _loadCaptions() async {
    final String fileContents = await DefaultAssetBundle.of(context).loadString(
        'https://portal.hassanallam.com/Public/Videos/Video/30JuneAxis-[HD1920x1080].mp4',
        cache: true);
    return WebVTTCaptionFile(
        fileContents); // For vtt files, use WebVTTCaptionFile
  }

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
      'https://portal.hassanallam.com/Public/Videos/Video/30JuneAxis-[HD1920x1080].mp4',
      // closedCaptionFile: _loadCaptions(),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> videos = {};
    List<dynamic> videosList = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videos'),

      ),
      body: BlocConsumer<VideosCubit, VideosState>(
        listener: (context, state) {
          if (state is VideosSuccessState) {
            videos = state.videosList;
            videosList = videos['data'];
          }
        },
        builder: (context, state) {
          final heroProperties = [
            const ImageGalleryHeroProperties(tag: 'imageId1'),
            const ImageGalleryHeroProperties(tag: 'imageId2'),
          ];

          const assets = [
            Image(image: AssetImage('assets/images/logo.png')),
            Image(image: AssetImage('assets/images/Builds.png')),
          ];
          return Sizer(
            builder: (c, or, dt) {
              return Column(
                children: [
                  // SizedBox(
                  //   height: 100,
                  //   width: 200,
                  //   child: ListView.builder(
                  //     // separatorBuilder: (c, i) => SizedBox.square(
                  //     //     dimension: 5.h,
                  //     //   ),
                  //     itemCount: 1,
                  //     itemBuilder: (ctx, index) {
                  //       return AspectRatio(
                  //         key: Key('hamadaKey$index'),
                  //         aspectRatio: _controller.value.aspectRatio,
                  //         child: Stack(
                  //           key: Key('hamadaKey$index'),
                  //           alignment: Alignment.bottomCenter,
                  //           children: <Widget>[
                  //             VideoPlayer(_controller),
                  //             ClosedCaption(text: _controller.value.caption.text),
                  //             _ControlsOverlay(controller: _controller),
                  //             VideoProgressIndicator(_controller,
                  //                 allowScrubbing: true),
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 30.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 7,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () => SwipeImageGallery(
                                context: context,
                                children: assets,
                                initialIndex: 1,
                                // heroProperties: heroProperties,
                              ).show(),
                              child: Hero(
                                tag: 'imageId$index',
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset('assets/images/S_Background.png'),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration(milliseconds: 0),
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
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
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
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
        Align(
          alignment: Alignment.topLeft,
          child: PopupMenuButton<Duration>(
            initialValue: controller.value.captionOffset,
            tooltip: 'Caption Offset',
            onSelected: (Duration delay) {
              controller.setCaptionOffset(delay);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<Duration>>[
                for (final Duration offsetDuration in _exampleCaptionOffsets)
                  PopupMenuItem<Duration>(
                    value: offsetDuration,
                    child: Text('${offsetDuration.inMilliseconds}ms'),
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
              child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
            ),
          ),
        ),
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
// ListView.builder(
// itemCount: 6,
// scrollDirection: Axis.horizontal,
// itemBuilder: (ctx, index) {
// return Container(
// height: 10.h,
// width: 150,
// margin: EdgeInsets.all(5),
// child: GestureDetector(
// // onTap: () => Navigator.push(
// //     context,
// //     MaterialPageRoute(
// //         builder: (context) => MoreStories())),
// child: ClipRRect(
// borderRadius: BorderRadius.circular(20),
// child: Image.network(
// "https://images.unsplash.com/photo-1581803118522-7b72a50f7e9f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bWFufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
// fit: BoxFit.fill,
// ),
// ),
// ),
// );
// },
// ),
