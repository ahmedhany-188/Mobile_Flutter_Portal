import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/videos_screen_bloc/videos_cubit.dart';
import 'video_list_widget.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({Key? key}) : super(key: key);
  static const routeName = 'videos-screen';

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {

  @override
  void initState() {

    super.initState();
  }
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
                      /* VideosCubit.get(context).videosList.length, */
                      itemBuilder: (ctx, index) {
                        return VideoListWidget(
                          videoListData: VideosCubit.get(context).videosList[index],
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
