import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import '../../bloc/photos_screen_bloc/photos_cubit.dart';
import 'package:sizer/sizer.dart';

class PhotosScreen extends StatefulWidget {
  static const routeName = 'photos-page';

  const PhotosScreen({Key? key}) : super(key: key);

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  Map<String, dynamic> images = {};
  List<dynamic> photosList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos'),
      ),
      body: BlocProvider(
        create: (context) => PhotosCubit()..getPhotos(),
        child: BlocConsumer<PhotosCubit, PhotosState>(
          listener: (context, state) {
            if (state is PhotosSuccessState) {
              images = state.photosList;
              photosList = images['data'];
            }
          },
          builder: (context, state) {
            return Sizer(
              builder: (c, or, dt) {
                return ListView.builder(
                  // separatorBuilder: (c, i) => SizedBox.square(
                  //   dimension: 5.h,
                  // ),
                  itemCount: photosList.length,
                  itemBuilder: (ctx, index) => SizedBox(
                    height: 30.h,
                    child: albumSwiper(photosList[index]['id'].toString()),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

Widget albumSwiper(String albumId) {
  Map<String, dynamic> albumImages = {};
  List<dynamic> albumPhotosList = [];
  return BlocProvider(
    create: (context) => PhotosCubit()..getAlbum(albumId),
    child: BlocConsumer<PhotosCubit, PhotosState>(
      listener: (context, state) {
        if (state is AlbumSuccessState) {
          albumImages = state.albumList;
          albumPhotosList = albumImages['data'];
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(3.0.h),
          child: Swiper(
            itemHeight: 30.h,
            // itemWidth: double.infinity,
            itemBuilder: (context, index) {
              final image = albumPhotosList[index];
              return FullScreenWidget(
                disposeLevel: DisposeLevel.Low,
                child: Hero(
                  key:  Key('HeroKey$index'),
                  tag: "customTag${index * Random(1).nextInt(5000)}",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl:
                      "https://portal.hassanallam.com/images/Albums/${image['photo_name']}",
                      placeholder: (c, m) =>
                      const Center(child: CircularProgressIndicator()),
                      errorWidget: (c, s, d) => Image.asset(
                        'assets/images/logo.png',
                        scale: 7.sp,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              );
            },
            layout: SwiperLayout.DEFAULT,
            indicatorLayout: PageIndicatorLayout.COLOR,
            autoplay: false,
            itemCount: albumPhotosList.length,
            pagination: const FractionPaginationBuilder(),
            physics: const BouncingScrollPhysics(),
            control: const SwiperControl(
                color: Colors.transparent),
          ),
        );
      },
    ),
  );
}
