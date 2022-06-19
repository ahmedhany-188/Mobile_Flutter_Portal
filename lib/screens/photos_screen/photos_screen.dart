import 'dart:math';

import 'package:hassanallamportalflutter/data/helpers/assist_function.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';

import '../../bloc/photos_screen_bloc/photos_cubit.dart';
import '../../constants/url_links.dart';

class PhotosScreen extends StatefulWidget {
  static const routeName = 'photos-screen';

  const PhotosScreen({Key? key}) : super(key: key);

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
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
            if (state is PhotosErrorState) {
              showErrorSnackBar(context);
            }
          },
          buildWhen: (pre, cur) {
            if (cur is PhotosSuccessState) {
              return cur.photosList.isNotEmpty;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            return Sizer(
              builder: (c, or, dt) {
                return (state is PhotosSuccessState)
                    ? ListView.builder(
                        itemCount: state.photosList.length,
                        itemBuilder: (ctx, index) => SizedBox(
                          height: 30.h,
                          child: albumSwiper(
                              state.photosList[index].id.toString()),
                        ),
                      )
                    : Container();
              },
            );
          },
        ),
      ),
    );
  }
}

Widget albumSwiper(String albumId) {
  return BlocProvider(
    create: (context) => PhotosCubit()..getAlbum(albumId),
    child: BlocConsumer<PhotosCubit, PhotosState>(
      listener: (context, state) {
        if (state is PhotosErrorState) {
          showErrorSnackBar(context);
        }
      },
      buildWhen: (pre, cur) {
        if (cur is AlbumSuccessState) {
          return cur.albumList.isNotEmpty;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return (state is AlbumSuccessState)
            ? Padding(
                padding: EdgeInsets.all(3.0.h),
                child: Swiper(
                  itemHeight: 30.h,
                  // itemWidth: double.infinity,
                  itemBuilder: (context, index) {
                    return FullScreenWidget(
                      disposeLevel: DisposeLevel.Low,
                      child: Hero(
                        key: Key('${state.albumList[index].photoName.toString()}$index'),
                        tag: "${state.albumList[index].photoName.toString()}${index * Random(1).nextInt(5000)}",
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: photosLinks(
                                state.albumList[index].photoName.toString()),
                            placeholder: (c, m) => const Center(
                                child: CircularProgressIndicator()),
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
                  autoplay: true, duration: 3000, autoplayDelay: 10000,
                  itemCount: state.albumList.length,
                  pagination: SwiperPagination.fraction,
                  physics: const BouncingScrollPhysics(),
                  control: const SwiperControl(color: Colors.transparent),
                ),
              )
            : Container();

        ///TODO: error widget
      },
    ),
  );
}
