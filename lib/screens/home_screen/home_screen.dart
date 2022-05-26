import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

import '../../bloc/news_screen_bloc/news_cubit.dart';
import '../../data/models/response_news.dart';
import '../about_value_screen/value_screen.dart';
import '../subsidiaries_screen/subsidiaries_screen.dart';
import '../benefits_screen/benefits_screen.dart';
import '../news_screen/news_screen.dart';
import '../photos_screen/photos_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<Data> newsAllData = [];

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext homeScreenContext) {
    return BlocProvider<NewsCubit>(
      create: (context) => NewsCubit()..getLatestNews(),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          if (state is LatestNewsSuccessState) {
            newsAllData = state.latestNewsList;
          }
        },
        buildWhen: (previous, current) {
          if (current is LatestNewsSuccessState) {
            newsAllData = current.latestNewsList;
            newsAllData
                .add(Data(newsID: 0, newsBody: "Test", newsTitle: "Test"));
            return current.latestNewsList.isNotEmpty;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          List<ImageGalleryHeroProperties> heroProperties = [];
          List<Widget> assets = [];

          return Sizer(
            builder: (c, or, dt) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 14.0.sp, bottom: 5.sp, top: 10.sp),
                    child: const Text(
                      'Latest News',
                      style: TextStyle(
                        color: Color(0xFF174873),
                      ),
                    ),
                  ),
                  (state is LatestNewsSuccessState)
                      ? Padding(
                          /// try remove this
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SizedBox(
                            width: 100.w,
                            height: 30.h,
                            child: NewsSliderList(
                                newsAllData: state.latestNewsList,
                                assets: assets,
                                heroProperties: heroProperties),
                          ),
                        )
                      : const ShimmerHomeNews(),
                  _buildHomeScreenContent(context),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Padding _buildHomeScreenContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: SizedBox(
        height: 60.h,
        width: 100.w,
        child: Center(
          child: GridView(
            padding: EdgeInsets.all(5.0.sp),
            addAutomaticKeepAlives: true,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.sp,
              mainAxisSpacing: 8.sp,
              childAspectRatio: 0.9.sp,
            ),
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(BenefitsScreen.routeName);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF1a4c78),
                          Color(0xFF3772a6),
                        ],
                        begin: Alignment(0, 1),
                        end: Alignment(0.5, 0),
                        tileMode: TileMode.clamp),
                    // color: Color(0xFF186597),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: GridView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(10.sp),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5.sp,
                        crossAxisSpacing: 5.sp,
                        childAspectRatio: 1.sp,
                      ),
                      children: [
                        const Center(
                            child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            'Benefits',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 3,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              // bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://portal.hassanallam.com/images/Benefits/1110.jpg',

                              /// contact car photo link
                              placeholder: (c, m) => const Center(
                                  child: RefreshProgressIndicator()),
                              errorWidget: (c, s, d) => Image.asset(
                                'assets/images/logo.png',
                                scale: 7.sp,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 3,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              // topRight: Radius.circular(20),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://portal.hassanallam.com/images/Benefits/1105.jpg',

                              /// medNet photo link
                              placeholder: (c, m) => const Center(
                                  child: RefreshProgressIndicator()),
                              errorWidget: (c, s, d) => Image.asset(
                                'assets/images/logo.png',
                                scale: 7.sp,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 3,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              // topRight: Radius.circular(20),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://portal.hassanallam.com/images/Benefits/1089.jpg',

                              /// hotel photo link
                              placeholder: (c, m) => const Center(
                                  child: RefreshProgressIndicator()),
                              errorWidget: (c, s, d) => Image.asset(
                                'assets/images/logo.png',
                                scale: 7.sp,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(PhotosScreen.routeName);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    // color: Color(23, 72, 115, 1),
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF6860c8),
                          Color(0xFF9695ed),
                        ],
                        begin: Alignment(0, 1),
                        end: Alignment(0.5, 0),
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: GridView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(10.sp),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5.sp,
                        crossAxisSpacing: 5.sp,
                        childAspectRatio: 1.sp,
                      ),
                      children: [
                        const Center(
                            child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            'Media',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 3,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              // bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://portal.hassanallam.com/images/Benefits/1110.jpg',

                              /// contact car photo link
                              placeholder: (c, m) => const Center(
                                  child: RefreshProgressIndicator()),
                              errorWidget: (c, s, d) => Image.asset(
                                'assets/images/logo.png',
                                scale: 7.sp,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 3,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              // topRight: Radius.circular(20),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://portal.hassanallam.com/images/Benefits/1105.jpg',

                              /// medNet photo link
                              placeholder: (c, m) => const Center(
                                  child: RefreshProgressIndicator()),
                              errorWidget: (c, s, d) => Image.asset(
                                'assets/images/logo.png',
                                scale: 7.sp,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 3,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              // topRight: Radius.circular(20),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://portal.hassanallam.com/images/Benefits/1089.jpg',

                              /// hotel photo link
                              placeholder: (c, m) => const Center(
                                  child: RefreshProgressIndicator()),
                              errorWidget: (c, s, d) => Image.asset(
                                'assets/images/logo.png',
                                scale: 7.sp,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(SubsidiariesScreen.routeName);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    // color: Color(0xFF174873),
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF6860c8),
                          Color(0xFF9695ed),
                        ],
                        begin: Alignment(0, 1),
                        end: Alignment(0.5, 0),
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: GridView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(10.sp),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5.sp,
                        crossAxisSpacing: 5.sp,
                        childAspectRatio: 1.sp,
                      ),
                      children: [
                        const Center(
                            child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            'Benefits',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 3,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              // bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://portal.hassanallam.com/images/Benefits/1110.jpg',

                              /// contact car photo link
                              placeholder: (c, m) => const Center(
                                  child: RefreshProgressIndicator()),
                              errorWidget: (c, s, d) => Image.asset(
                                'assets/images/logo.png',
                                scale: 7.sp,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 3,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              // topRight: Radius.circular(20),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://portal.hassanallam.com/images/Benefits/1105.jpg',

                              /// medNet photo link
                              placeholder: (c, m) => const Center(
                                  child: RefreshProgressIndicator()),
                              errorWidget: (c, s, d) => Image.asset(
                                'assets/images/logo.png',
                                scale: 7.sp,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 3,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              // topRight: Radius.circular(20),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://portal.hassanallam.com/images/Benefits/1089.jpg',

                              /// hotel photo link
                              placeholder: (c, m) => const Center(
                                  child: RefreshProgressIndicator()),
                              errorWidget: (c, s, d) => Image.asset(
                                'assets/images/logo.png',
                                scale: 7.sp,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(ValueScreen.routeName);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    // color: Color(0xFF186597),
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF1a4c78),
                          Color(0xFF3772a6),
                        ],
                        begin: Alignment(0, 1),
                        end: Alignment(0.5, 0),
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: GridView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(10.sp),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5.sp,
                        crossAxisSpacing: 5.sp,
                        childAspectRatio: 1.sp,
                      ),
                      children: [
                        const Center(
                            child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            'Benefits',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 3,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              // bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://portal.hassanallam.com/images/Benefits/1110.jpg',

                              /// contact car photo link
                              placeholder: (c, m) => const Center(
                                  child: RefreshProgressIndicator()),
                              errorWidget: (c, s, d) => Image.asset(
                                'assets/images/logo.png',
                                scale: 7.sp,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 3,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              // topRight: Radius.circular(20),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://portal.hassanallam.com/images/Benefits/1105.jpg',

                              /// medNet photo link
                              placeholder: (c, m) => const Center(
                                  child: RefreshProgressIndicator()),
                              errorWidget: (c, s, d) => Image.asset(
                                'assets/images/logo.png',
                                scale: 7.sp,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 3,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              // topRight: Radius.circular(20),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://portal.hassanallam.com/images/Benefits/1089.jpg',

                              /// hotel photo link
                              placeholder: (c, m) => const Center(
                                  child: RefreshProgressIndicator()),
                              errorWidget: (c, s, d) => Image.asset(
                                'assets/images/logo.png',
                                scale: 7.sp,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen2 extends StatelessWidget {
  HomeScreen2({Key? key}) : super(key: key);

  List<Data> newsAllData = [];

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext homeScreenContext) {
    return BlocProvider<NewsCubit>(
      create: (context) => NewsCubit()..getLatestNews(),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          if (state is LatestNewsSuccessState) {
            newsAllData = state.latestNewsList;
          }
        },
        buildWhen: (previous, current) {
          if (current is LatestNewsSuccessState) {
            newsAllData = current.latestNewsList;
            newsAllData
                .add(Data(newsID: 0, newsBody: "Test", newsTitle: "Test"));
            return current.latestNewsList.isNotEmpty;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          List<ImageGalleryHeroProperties> heroProperties = [];
          List<Widget> assets = [];

          return Sizer(
            builder: (c, or, dt) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 14.0.sp, bottom: 5.sp, top: 10.sp),
                    child: const Text(
                      'Latest News',
                      style: TextStyle(
                        color: Color(0xFF174873),
                      ),
                    ),
                  ),
                  (state is LatestNewsSuccessState)
                      ? Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: SizedBox(
                            width: 100.w,
                            height: 30.h,
                            child: NewsSliderList(
                                newsAllData: state.latestNewsList,
                                assets: assets,
                                heroProperties: heroProperties),
                          ),
                        )
                      : const ShimmerHomeNews(),
                  _buildHomeScreenContent(context),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Padding _buildHomeScreenContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: SizedBox(
        height: 60.h,
        width: 100.w,
        child: Center(
          child: GridView(
            padding: EdgeInsets.all(5.0.sp),
            addAutomaticKeepAlives: true,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.sp,
              mainAxisSpacing: 8.sp,
              childAspectRatio: 0.9.sp,
            ),
            children: [
              /// with four pics without badge
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(BenefitsScreen.routeName);
                },
                child: GridTile(
                  footer: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF186597).withOpacity(0.4),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    // transform: Matrix4.rotationZ(-150)
                    //   ..translate(10.0, -20.0, 0),
                    padding: const EdgeInsets.all(10),
                    child: const Center(
                      child: Text(
                        'Benefits',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF174873),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: GridView(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(10.sp),
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5.sp,
                          crossAxisSpacing: 5.sp,
                          childAspectRatio: 1.sp,
                        ),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://portal.hassanallam.com/images/Benefits/1110.jpg',

                                /// contact car photo link
                                placeholder: (c, m) => const Center(
                                    child: RefreshProgressIndicator()),
                                errorWidget: (c, s, d) => Image.asset(
                                  'assets/images/logo.png',
                                  scale: 7.sp,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://portal.hassanallam.com/images/Benefits/1078.jpg',

                                /// premium photo link
                                placeholder: (c, m) => const Center(
                                    child: RefreshProgressIndicator()),
                                errorWidget: (c, s, d) => Image.asset(
                                  'assets/images/logo.png',
                                  scale: 7.sp,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://portal.hassanallam.com/images/Benefits/1105.jpg',

                                /// medNet photo link
                                placeholder: (c, m) => const Center(
                                    child: RefreshProgressIndicator()),
                                errorWidget: (c, s, d) => Image.asset(
                                  'assets/images/logo.png',
                                  scale: 7.sp,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://portal.hassanallam.com/images/Benefits/1089.jpg',

                                /// hotel photo link
                                placeholder: (c, m) => const Center(
                                    child: RefreshProgressIndicator()),
                                errorWidget: (c, s, d) => Image.asset(
                                  'assets/images/logo.png',
                                  scale: 7.sp,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              /// with badge
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(PhotosScreen.routeName);
                },
                child: GridTile(
                  footer: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF186597).withOpacity(0.4),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    // transform: Matrix4.rotationZ(-150)
                    //   ..translate(10.0, -20.0, 0),
                    padding: const EdgeInsets.all(10),
                    child: const Center(
                      child: Text(
                        'Benefits',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF174873),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: GridView(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(10.sp),
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5.sp,
                          crossAxisSpacing: 5.sp,
                          childAspectRatio: 1.sp,
                        ),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://portal.hassanallam.com/images/Benefits/1110.jpg',

                                /// contact car photo link
                                placeholder: (c, m) => const Center(
                                    child: RefreshProgressIndicator()),
                                errorWidget: (c, s, d) => Image.asset(
                                  'assets/images/logo.png',
                                  scale: 7.sp,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://portal.hassanallam.com/images/Benefits/1078.jpg',

                                /// premium photo link
                                placeholder: (c, m) => const Center(
                                    child: RefreshProgressIndicator()),
                                errorWidget: (c, s, d) => Image.asset(
                                  'assets/images/logo.png',
                                  scale: 7.sp,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://portal.hassanallam.com/images/Benefits/1105.jpg',

                                /// medNet photo link
                                placeholder: (c, m) => const Center(
                                    child: RefreshProgressIndicator()),
                                errorWidget: (c, s, d) => Image.asset(
                                  'assets/images/logo.png',
                                  scale: 7.sp,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://portal.hassanallam.com/images/Benefits/1089.jpg',

                                /// hotel photo link
                                placeholder: (c, m) => const Center(
                                    child: RefreshProgressIndicator()),
                                errorWidget: (c, s, d) => Image.asset(
                                  'assets/images/logo.png',
                                  scale: 7.sp,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              /// with grid tile
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(SubsidiariesScreen.routeName);
                },
                child: GridTile(
                  footer: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF186597).withOpacity(0.4),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    // transform: Matrix4.rotationZ(-150)
                    //   ..translate(10.0, -20.0, 0),
                    padding: const EdgeInsets.all(10),
                    child: const Center(
                      child: Text(
                        'Benefits',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF174873),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: GridView(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(10.sp),
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5.sp,
                          crossAxisSpacing: 5.sp,
                          childAspectRatio: 1.sp,
                        ),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://portal.hassanallam.com/images/Benefits/1110.jpg',

                                /// contact car photo link
                                placeholder: (c, m) => const Center(
                                    child: RefreshProgressIndicator()),
                                errorWidget: (c, s, d) => Image.asset(
                                  'assets/images/logo.png',
                                  scale: 7.sp,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://portal.hassanallam.com/images/Benefits/1078.jpg',

                                /// premium photo link
                                placeholder: (c, m) => const Center(
                                    child: RefreshProgressIndicator()),
                                errorWidget: (c, s, d) => Image.asset(
                                  'assets/images/logo.png',
                                  scale: 7.sp,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://portal.hassanallam.com/images/Benefits/1105.jpg',

                                /// medNet photo link
                                placeholder: (c, m) => const Center(
                                    child: RefreshProgressIndicator()),
                                errorWidget: (c, s, d) => Image.asset(
                                  'assets/images/logo.png',
                                  scale: 7.sp,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://portal.hassanallam.com/images/Benefits/1089.jpg',

                                /// hotel photo link
                                placeholder: (c, m) => const Center(
                                    child: RefreshProgressIndicator()),
                                errorWidget: (c, s, d) => Image.asset(
                                  'assets/images/logo.png',
                                  scale: 7.sp,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              /// with 2 pics & text
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(ValueScreen.routeName);
                },
                child: GridTile(
                  footer: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF186597).withOpacity(0.4),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    // transform: Matrix4.rotationZ(-150)
                    //   ..translate(10.0, -20.0, 0),
                    padding: const EdgeInsets.all(10),
                    child: const Center(
                      child: Text(
                        'Benefits',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF174873),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: GridView(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(10.sp),
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5.sp,
                          crossAxisSpacing: 5.sp,
                          childAspectRatio: 1.sp,
                        ),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://portal.hassanallam.com/images/Benefits/1110.jpg',

                                /// contact car photo link
                                placeholder: (c, m) => const Center(
                                    child: RefreshProgressIndicator()),
                                errorWidget: (c, s, d) => Image.asset(
                                  'assets/images/logo.png',
                                  scale: 7.sp,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://portal.hassanallam.com/images/Benefits/1078.jpg',

                                /// premium photo link
                                placeholder: (c, m) => const Center(
                                    child: RefreshProgressIndicator()),
                                errorWidget: (c, s, d) => Image.asset(
                                  'assets/images/logo.png',
                                  scale: 7.sp,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://portal.hassanallam.com/images/Benefits/1105.jpg',

                                /// medNet photo link
                                placeholder: (c, m) => const Center(
                                    child: RefreshProgressIndicator()),
                                errorWidget: (c, s, d) => Image.asset(
                                  'assets/images/logo.png',
                                  scale: 7.sp,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://portal.hassanallam.com/images/Benefits/1089.jpg',

                                /// hotel photo link
                                placeholder: (c, m) => const Center(
                                    child: RefreshProgressIndicator()),
                                errorWidget: (c, s, d) => Image.asset(
                                  'assets/images/logo.png',
                                  scale: 7.sp,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen3 extends StatelessWidget {
  HomeScreen3({Key? key}) : super(key: key);

  List<Data> newsAllData = [];

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext homeScreenContext) {
    return BlocProvider<NewsCubit>(
      create: (context) => NewsCubit()..getLatestNews(),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          if (state is LatestNewsSuccessState) {
            newsAllData = state.latestNewsList;
          }
        },
        buildWhen: (previous, current) {
          if (current is LatestNewsSuccessState) {
            newsAllData = current.latestNewsList;
            newsAllData
                .add(Data(newsID: 0, newsBody: "Test", newsTitle: "Test"));
            return current.latestNewsList.isNotEmpty;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          List<ImageGalleryHeroProperties> heroProperties = [];
          List<Widget> assets = [];
          if (state is LatestNewsSuccessState) {
            print("${state.latestNewsList.length}");
          }
          print("${newsAllData.length}");
          return Sizer(
            builder: (c, or, dt) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 14.0.sp, bottom: 5.sp, top: 10.sp),
                    child: const Text(
                      'Latest News',
                      style: TextStyle(
                        color: Color(0xFF174873),
                      ),
                    ),
                  ),
                  state is LatestNewsSuccessState
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SizedBox(
                            width: 100.w,
                            height: 30.h,
                            child: NewsSliderList(
                                newsAllData: state.latestNewsList,
                                assets: assets,
                                heroProperties: heroProperties),
                          ),
                        )
                      : const ShimmerHomeNews(),
                  _buildHomeScreenContent(context),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Padding _buildHomeScreenContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: SizedBox(
        height: 60.h,
        width: 100.w,
        child: Center(
          child: GridView(
            padding: EdgeInsets.zero,
            addAutomaticKeepAlives: true,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.sp,
              mainAxisSpacing: 8.sp,
              childAspectRatio: 0.9.sp,
            ),
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(BenefitsScreen.routeName);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF1a4c78),
                          Color(0xFF3772a6),
                        ],
                        begin: Alignment(0, 1),
                        end: Alignment(0.5, 0),
                        tileMode: TileMode.clamp),
                    image: DecorationImage(
                        image: AssetImage('assets/images/Benefits.png'),
                        alignment: Alignment.centerRight,
                        opacity: 0.5,
                        scale: 1.8),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22.0, top: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          CircleAvatar(
                            radius: 20,
                            child: Icon(
                              Icons.loyalty_outlined,
                              size: 30,
                              color: Color(0xFF174873),

                              /// Color(0xFF174873)
                            ),
                            backgroundColor: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 5),
                            child: Text(
                              'Benefits',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'RobotoCondensed'),
                            ),
                          ),
                          Text(
                            'Hotels, Health, Retails...',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'RobotoCondensed'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(PhotosScreen.routeName);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF6860c8),
                          Color(0xFF9695ed),
                        ],
                        begin: Alignment(0, 1),
                        end: Alignment(0.5, 0),
                        tileMode: TileMode.clamp),
                    image: DecorationImage(
                        image: AssetImage('assets/images/Media.png'),
                        alignment: Alignment.centerRight,
                        opacity: 0.5,
                        scale: 1.8),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22.0, top: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          CircleAvatar(
                            radius: 20,
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 30,
                              color: Color(0xFF174873),

                              /// Color(0xFF174873)
                            ),
                            backgroundColor: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 5),
                            child: Text(
                              'Media',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: 'RobotoCondensed'),
                            ),
                          ),
                          Text(
                            'Photo Gallery, Videos.',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'RobotoCondensed'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(SubsidiariesScreen.routeName);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF6860c8),
                          Color(0xFF9695ed),
                        ],
                        begin: Alignment(0, 1),
                        end: Alignment(0.5, 0),
                        tileMode: TileMode.clamp),
                    image: DecorationImage(
                        image: AssetImage('assets/images/Subsidiaries.png'),
                        alignment: Alignment.centerRight,
                        opacity: 0.5,
                        scale: 1.8),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22.0, top: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          CircleAvatar(
                            radius: 20,
                            child:
                                // Text(
                                //   String.fromCharCode(0xf190),
                                //   style: TextStyle(
                                //     inherit: false,
                                //     color: Color(0xFF174873),
                                //     fontSize: 30.0,
                                //     fontWeight: FontWeight.w100,
                                //     fontFamily: "MaterialIcons",
                                //     // package: CupertinoIcons.exclamationmark_circle.fontPackage,
                                //   ),
                                // ),
                                Icon(
                              // IconData(0xe7f1, fontFamily: 'MaterialIcons-Outlined'),
                              Icons.location_city_outlined,
                              size: 30,
                              color: Color(0xFF174873),

                              /// Color(0xFF174873)
                            ),
                            backgroundColor: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 5),
                            child: Text(
                              'Subsidiaries',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'RobotoCondensed'),
                            ),
                          ),
                          Text(
                            'Know more about our subsidiaries...',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'RobotoCondensed'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(ValueScreen.routeName);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF1a4c78),
                          Color(0xFF3772a6),
                        ],
                        begin: Alignment(0, 1),
                        end: Alignment(0.5, 0),
                        tileMode: TileMode.clamp),
                    image: DecorationImage(
                        image: AssetImage('assets/images/Values.png'),
                        alignment: Alignment.centerRight,
                        opacity: 0.5,
                        scale: 1.8),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22.0, top: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          CircleAvatar(
                            radius: 20,
                            child: Icon(
                              Icons.interpreter_mode_outlined,
                              size: 30,
                              color: Color(0xFF174873),

                              /// Color(0xFF174873)
                            ),
                            backgroundColor: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 5),
                            child: Text(
                              'HAH Values',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: 'RobotoCondensed'),
                            ),
                          ),
                          Text(
                            'Know about our values',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'RobotoCondensed'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewsSliderList extends StatelessWidget {
  const NewsSliderList({
    Key? key,
    required this.newsAllData,
    required this.assets,
    required this.heroProperties,
  }) : super(key: key);

  final List<Data> newsAllData;
  final List<Widget> assets;
  final List<ImageGalleryHeroProperties> heroProperties;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: newsAllData.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (ctx, index) {
        Data news = newsAllData[index];

        /// adding the view that will appear when tap on the news photo
        if (news.newsID != 0) {
          assets.add(
            _buildAssetGridTile(news),
          );
          heroProperties.add(ImageGalleryHeroProperties(tag: 'imageId$index'));
        }

        /// the news Slider
        return InkWell(
          onTap: () {
            if (news.newsID == 0) {
              Navigator.of(context).pushNamed(NewsScreen.routeName);
            } else {
              SwipeImageGallery(
                context: context,
                children: assets,
                initialIndex: index,
                heroProperties: heroProperties,
                hideOverlayOnTap: false,
                hideStatusBar: false,
              ).show();
            }
          },
          child: Hero(
            tag: 'imageId$index',
            child: Container(
              width: 27.w,
              margin: const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: _buildHomeScreenGridTile(news),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAssetGridTile(Data news) {
    return Scaffold(
      body: GridTile(
        header: GridTileBar(
          title: Text(
            news.newsTitle ?? "Go to News to see more details",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          backgroundColor: Colors.black54,
        ),
        footer: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.black54,
          child: Text(
            news.newsDescription ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        child: CachedNetworkImage(
          imageUrl:
              'https://portal.hassanallam.com/images/imgs/${news.newsID}.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  GridTile _buildHomeScreenGridTile(Data news) {
    return GridTile(
      footer: (news.newsID != 0)
          ?
          // SizedBox(
          // height: 10.h,
          // width: 30.w,
          // child:
          Container(
              height: 10.h,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.black87,
                      Colors.black12,
                      // Color(0x12000000),
                      // Color(0x02000000),
                    ],
                    begin: Alignment(0, 1),
                    end: Alignment(0.0, 0),
                    tileMode: TileMode.clamp),
              ),
              child: GridTileBar(
                title: Text(
                  '${news.newsTitle} ${news.newsDescription}' ??
                      "Go to News to see more details",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      overflow: TextOverflow.ellipsis),
                  maxLines: 4,
                  softWrap: true,
                ),
                // subtitle: Text(
                //   news.newsDescription ?? "",
                //   maxLines: 4,
                //   softWrap: true,
                //   style: const TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 10,
                //       overflow: TextOverflow.fade),
                // ),
                // backgroundColor: Colors.black45,
              ),
            )
          // )
          : Container(
              height: 30.h,
              color: Colors.black54,
              child: const Center(
                child: Text(
                  'See More',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        useOldImageOnUrlChange: true,
        imageUrl: (news.newsID != 0)
            ? 'https://portal.hassanallam.com/images/imgs/${news.newsID}.jpg'
            : 'https://portal.hassanallam.com/images/imgs/3299.jpg',
      ),
    );
  }
}

class ShimmerHomeNews extends StatelessWidget {
  const ShimmerHomeNews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      child: SizedBox(
        width: 100.w,
        height: 30.h,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (ctx, index) {
              return Container(
                width: 27.w,
                margin: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 30.h,
                      width: 27.w,
                      color: Colors.grey,
                    )),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Padding _buildHomeScreenContent(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 5.0, right: 5.0),
//     child: SizedBox(
//       height: 60.h,
//       width: 100.w,
//       child: Center(
//         child: GridView(
//           padding: EdgeInsets.all(5.0.sp),
//           addAutomaticKeepAlives: true,
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 15.sp,
//             mainAxisSpacing: 8.sp,
//             childAspectRatio: 0.9.sp,
//           ),
//           children: [
//             /// with four pics without badge
//             InkWell(
//               onTap: () {
//                 Navigator.of(context).pushNamed(BenefitsScreen.routeName);
//               },
//               child: Container(
//                 decoration: const BoxDecoration(
//                   color: Color(0xFF186597),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Center(
//                   child: GridView(
//                     shrinkWrap: true,
//                     padding: EdgeInsets.all(10.sp),
//                     physics: const NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 5.sp,
//                       crossAxisSpacing: 5.sp,
//                       childAspectRatio: 1.sp,
//                     ),
//                     children: [
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height / 3,
//                         width: MediaQuery.of(context).size.width / 3,
//                         child: ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                             bottomLeft: Radius.circular(20),
//                             topRight: Radius.circular(20),
//                           ),
//                           child: CachedNetworkImage(
//                             imageUrl:
//                             'https://portal.hassanallam.com/images/Benefits/1110.jpg',
//
//                             /// contact car photo link
//                             placeholder: (c, m) => const Center(
//                                 child: RefreshProgressIndicator()),
//                             errorWidget: (c, s, d) => Image.asset(
//                               'assets/images/logo.png',
//                               scale: 7.sp,
//                             ),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height / 3,
//                         width: MediaQuery.of(context).size.width / 3,
//                         child: ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                             bottomLeft: Radius.circular(20),
//                             topRight: Radius.circular(20),
//                           ),
//                           child: CachedNetworkImage(
//                             imageUrl:
//                             'https://portal.hassanallam.com/images/Benefits/1078.jpg',
//
//                             /// premium photo link
//                             placeholder: (c, m) => const Center(
//                                 child: RefreshProgressIndicator()),
//                             errorWidget: (c, s, d) => Image.asset(
//                               'assets/images/logo.png',
//                               scale: 7.sp,
//                             ),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height / 3,
//                         width: MediaQuery.of(context).size.width / 3,
//                         child: ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                             bottomLeft: Radius.circular(20),
//                             topRight: Radius.circular(20),
//                           ),
//                           child: CachedNetworkImage(
//                             imageUrl:
//                             'https://portal.hassanallam.com/images/Benefits/1105.jpg',
//
//                             /// medNet photo link
//                             placeholder: (c, m) => const Center(
//                                 child: RefreshProgressIndicator()),
//                             errorWidget: (c, s, d) => Image.asset(
//                               'assets/images/logo.png',
//                               scale: 7.sp,
//                             ),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height / 3,
//                         width: MediaQuery.of(context).size.width / 3,
//                         child: ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                             bottomLeft: Radius.circular(20),
//                             topRight: Radius.circular(20),
//                           ),
//                           child: CachedNetworkImage(
//                             imageUrl:
//                             'https://portal.hassanallam.com/images/Benefits/1089.jpg',
//
//                             /// hotel photo link
//                             placeholder: (c, m) => const Center(
//                                 child: RefreshProgressIndicator()),
//                             errorWidget: (c, s, d) => Image.asset(
//                               'assets/images/logo.png',
//                               scale: 7.sp,
//                             ),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             /// with badge
//             InkWell(
//               onTap: () {
//                 Navigator.of(context).pushNamed(BenefitsScreen.routeName);
//               },
//               child: Badge(
//                 badgeContent: const Text('Benefits',
//                     style: TextStyle(color: Colors.white)),
//                 position: BadgePosition.topStart(),
//                 shape: BadgeShape.square,
//                 borderRadius: BorderRadius.circular(20),
//                 badgeColor: const Color(0xFF186597),
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: Color.fromRGBO(23, 72, 115, 1),
//                     borderRadius: BorderRadius.only(
//                       bottomRight: Radius.circular(20),
//                       topLeft: Radius.circular(20),
//                     ),
//                   ),
//                   child: Center(
//                     child: GridView(
//                       shrinkWrap: true,
//                       padding: EdgeInsets.all(10.sp),
//                       physics: const NeverScrollableScrollPhysics(),
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 5.sp,
//                         crossAxisSpacing: 5.sp,
//                         childAspectRatio: 1.sp,
//                       ),
//                       children: [
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height / 3,
//                           width: MediaQuery.of(context).size.width / 3,
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.only(
//                               bottomLeft: Radius.circular(20),
//                               topRight: Radius.circular(20),
//                             ),
//                             child: CachedNetworkImage(
//                               imageUrl:
//                               'https://portal.hassanallam.com/images/Benefits/1110.jpg',
//
//                               /// contact car photo link
//                               placeholder: (c, m) => const Center(
//                                   child: RefreshProgressIndicator()),
//                               errorWidget: (c, s, d) => Image.asset(
//                                 'assets/images/logo.png',
//                                 scale: 7.sp,
//                               ),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height / 3,
//                           width: MediaQuery.of(context).size.width / 3,
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.only(
//                               bottomLeft: Radius.circular(20),
//                               topRight: Radius.circular(20),
//                             ),
//                             child: CachedNetworkImage(
//                               imageUrl:
//                               'https://portal.hassanallam.com/images/Benefits/1078.jpg',
//
//                               /// premium photo link
//                               placeholder: (c, m) => const Center(
//                                   child: RefreshProgressIndicator()),
//                               errorWidget: (c, s, d) => Image.asset(
//                                 'assets/images/logo.png',
//                                 scale: 7.sp,
//                               ),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height / 3,
//                           width: MediaQuery.of(context).size.width / 3,
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.only(
//                               bottomLeft: Radius.circular(20),
//                               topRight: Radius.circular(20),
//                             ),
//                             child: CachedNetworkImage(
//                               imageUrl:
//                               'https://portal.hassanallam.com/images/Benefits/1105.jpg',
//
//                               /// medNet photo link
//                               placeholder: (c, m) => const Center(
//                                   child: RefreshProgressIndicator()),
//                               errorWidget: (c, s, d) => Image.asset(
//                                 'assets/images/logo.png',
//                                 scale: 7.sp,
//                               ),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height / 3,
//                           width: MediaQuery.of(context).size.width / 3,
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.only(
//                               bottomLeft: Radius.circular(20),
//                               topRight: Radius.circular(20),
//                             ),
//                             child: CachedNetworkImage(
//                               imageUrl:
//                               'https://portal.hassanallam.com/images/Benefits/1089.jpg',
//
//                               /// hotel photo link
//                               placeholder: (c, m) => const Center(
//                                   child: RefreshProgressIndicator()),
//                               errorWidget: (c, s, d) => Image.asset(
//                                 'assets/images/logo.png',
//                                 scale: 7.sp,
//                               ),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//             /// with grid tile
//             InkWell(
//               onTap: () {
//                 Navigator.of(context).pushNamed(BenefitsScreen.routeName);
//               },
//               child: GridTile(
//                 footer: Container(
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF186597).withOpacity(0.4),
//                     borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(20),
//                     ),
//                   ),
//                   // transform: Matrix4.rotationZ(-150)
//                   //   ..translate(10.0, -20.0, 0),
//                   padding: const EdgeInsets.all(10),
//                   child: const Center(
//                     child: Text(
//                       'Benefits',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: Color(0xFF174873),
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                     ),
//                   ),
//                   child: Center(
//                     child: GridView(
//                       shrinkWrap: true,
//                       padding: EdgeInsets.all(10.sp),
//                       physics: const NeverScrollableScrollPhysics(),
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 5.sp,
//                         crossAxisSpacing: 5.sp,
//                         childAspectRatio: 1.sp,
//                       ),
//                       children: [
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height / 3,
//                           width: MediaQuery.of(context).size.width / 3,
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.only(
//                               bottomLeft: Radius.circular(20),
//                               topRight: Radius.circular(20),
//                             ),
//                             child: CachedNetworkImage(
//                               imageUrl:
//                               'https://portal.hassanallam.com/images/Benefits/1110.jpg',
//
//                               /// contact car photo link
//                               placeholder: (c, m) => const Center(
//                                   child: RefreshProgressIndicator()),
//                               errorWidget: (c, s, d) => Image.asset(
//                                 'assets/images/logo.png',
//                                 scale: 7.sp,
//                               ),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height / 3,
//                           width: MediaQuery.of(context).size.width / 3,
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.only(
//                               bottomLeft: Radius.circular(20),
//                               topRight: Radius.circular(20),
//                             ),
//                             child: CachedNetworkImage(
//                               imageUrl:
//                               'https://portal.hassanallam.com/images/Benefits/1078.jpg',
//
//                               /// premium photo link
//                               placeholder: (c, m) => const Center(
//                                   child: RefreshProgressIndicator()),
//                               errorWidget: (c, s, d) => Image.asset(
//                                 'assets/images/logo.png',
//                                 scale: 7.sp,
//                               ),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height / 3,
//                           width: MediaQuery.of(context).size.width / 3,
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.only(
//                               bottomLeft: Radius.circular(20),
//                               topRight: Radius.circular(20),
//                             ),
//                             child: CachedNetworkImage(
//                               imageUrl:
//                               'https://portal.hassanallam.com/images/Benefits/1105.jpg',
//
//                               /// medNet photo link
//                               placeholder: (c, m) => const Center(
//                                   child: RefreshProgressIndicator()),
//                               errorWidget: (c, s, d) => Image.asset(
//                                 'assets/images/logo.png',
//                                 scale: 7.sp,
//                               ),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height / 3,
//                           width: MediaQuery.of(context).size.width / 3,
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.only(
//                               bottomLeft: Radius.circular(20),
//                               topRight: Radius.circular(20),
//                             ),
//                             child: CachedNetworkImage(
//                               imageUrl:
//                               'https://portal.hassanallam.com/images/Benefits/1089.jpg',
//
//                               /// hotel photo link
//                               placeholder: (c, m) => const Center(
//                                   child: RefreshProgressIndicator()),
//                               errorWidget: (c, s, d) => Image.asset(
//                                 'assets/images/logo.png',
//                                 scale: 7.sp,
//                               ),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//             /// with 2 pics & text
//             InkWell(
//               onTap: () {
//                 Navigator.of(context).pushNamed(BenefitsScreen.routeName);
//               },
//               child: Container(
//                 decoration: const BoxDecoration(
//                   color: Color(0xFF186597),
//                   borderRadius: BorderRadius.only(
//                     bottomRight: Radius.circular(20),
//                     topLeft: Radius.circular(20),
//                   ),
//                 ),
//                 child: Center(
//                   child: GridView(
//                     shrinkWrap: true,
//                     padding: EdgeInsets.all(10.sp),
//                     physics: const NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 5.sp,
//                       crossAxisSpacing: 5.sp,
//                       childAspectRatio: 1.sp,
//                     ),
//                     children: [
//                       const Center(
//                           child: FittedBox(
//                             fit: BoxFit.fitWidth,
//                             child: Text(
//                               'Benefits',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           )),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height / 3,
//                         width: MediaQuery.of(context).size.width / 3,
//                         child: ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                             bottomLeft: Radius.circular(20),
//                             topRight: Radius.circular(20),
//                           ),
//                           child: CachedNetworkImage(
//                             imageUrl:
//                             'https://portal.hassanallam.com/images/Benefits/1110.jpg',
//
//                             /// contact car photo link
//                             placeholder: (c, m) => const Center(
//                                 child: RefreshProgressIndicator()),
//                             errorWidget: (c, s, d) => Image.asset(
//                               'assets/images/logo.png',
//                               scale: 7.sp,
//                             ),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height / 3,
//                         width: MediaQuery.of(context).size.width / 3,
//                         child: ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                             bottomLeft: Radius.circular(20),
//                             topRight: Radius.circular(20),
//                           ),
//                           child: CachedNetworkImage(
//                             imageUrl:
//                             'https://portal.hassanallam.com/images/Benefits/1105.jpg',
//
//                             /// medNet photo link
//                             placeholder: (c, m) => const Center(
//                                 child: RefreshProgressIndicator()),
//                             errorWidget: (c, s, d) => Image.asset(
//                               'assets/images/logo.png',
//                               scale: 7.sp,
//                             ),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height / 3,
//                         width: MediaQuery.of(context).size.width / 3,
//                         child: ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                             bottomLeft: Radius.circular(20),
//                             topRight: Radius.circular(20),
//                           ),
//                           child: CachedNetworkImage(
//                             imageUrl:
//                             'https://portal.hassanallam.com/images/Benefits/1089.jpg',
//
//                             /// hotel photo link
//                             placeholder: (c, m) => const Center(
//                                 child: RefreshProgressIndicator()),
//                             errorWidget: (c, s, d) => Image.asset(
//                               'assets/images/logo.png',
//                               scale: 7.sp,
//                             ),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
