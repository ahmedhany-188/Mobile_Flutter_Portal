import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

import '../../bloc/news_screen_bloc/news_cubit.dart';
import '../benefits_screen/benefits_screen.dart';
import '../news_screen/news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> newsAllData = {};

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
                        left: 10.0.sp, bottom: 5.sp, top: 10.sp),
                    child: const Text(
                      'Latest News',
                      style: TextStyle(
                        color: Color(0xFF174873),
                      ),
                    ),
                  ),
                  (newsAllData.isNotEmpty)
                      ? SizedBox(
                          width: 100.w,
                          height: 30.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,shrinkWrap: true,
                            itemCount: newsAllData['data'].length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              Map<String, dynamic> news =
                                  newsAllData['data'][index];

                              /// adding the view that will appear when tap on the news photo
                              assets.add(GridTile(
                                header: GridTileBar(
                                  title: Text(
                                    (news['news_Title'] != null)
                                        ? news['news_Title']
                                        : 'Go to News to see more details',
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
                                    news['news_Description'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://portal.hassanallam.com/images/imgs/${news['news_ID']}.jpg',
                                  fit: BoxFit.fill,
                                ),
                              ));
                              heroProperties.add(ImageGalleryHeroProperties(
                                  tag: 'imageId$index'));

                              /// the news Slider
                              return InkWell(
                                onTap: () => SwipeImageGallery(
                                  context: context,
                                  children: assets,
                                  initialIndex: index,
                                  heroProperties: heroProperties,
                                ).show(),
                                child: Hero(
                                  tag: 'imageId$index',
                                  child: Container(
                                    width: 27.w,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: GridTile(
                                        footer: SizedBox(
                                          height: 5.h,
                                          child: GridTileBar(
                                            title: Text(
                                              (news['news_Title'] != null)
                                                  ? news['news_Title']
                                                  : 'Go to News to see more details',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                  overflow: TextOverflow.fade),
                                            ),
                                            backgroundColor: Colors.black54,
                                          ),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://portal.hassanallam.com/images/imgs/${news['news_ID']}.jpg',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Shimmer.fromColors(
                          baseColor: const Color(0xFF186597),
                          highlightColor: Colors.white,
                          child: SizedBox(
                            width: 100.w,
                            height: 30.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (ctx, index) {
                                /// the news Slider
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
                          )),
                  SizedBox(
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
                              Navigator.of(context)
                                  .pushNamed(BenefitsScreen.routeName);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFF186597),
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
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5.sp,
                                    crossAxisSpacing: 5.sp,
                                    childAspectRatio: 1.sp,
                                  ),
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
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
                                              child:
                                                  RefreshProgressIndicator()),
                                          errorWidget: (c, s, d) => Image.asset(
                                            'assets/images/logo.png',
                                            scale: 7.sp,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
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
                                              child:
                                                  RefreshProgressIndicator()),
                                          errorWidget: (c, s, d) => Image.asset(
                                            'assets/images/logo.png',
                                            scale: 7.sp,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
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
                                              child:
                                                  RefreshProgressIndicator()),
                                          errorWidget: (c, s, d) => Image.asset(
                                            'assets/images/logo.png',
                                            scale: 7.sp,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
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
                                              child:
                                                  RefreshProgressIndicator()),
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

                          /// with badge
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(BenefitsScreen.routeName);
                            },
                            child: Badge(
                              badgeContent: const Text('Benefits',
                                  style: TextStyle(color: Colors.white)),
                              position: BadgePosition.topStart(),
                              shape: BadgeShape.square,
                              borderRadius: BorderRadius.circular(20),
                              badgeColor: const Color(0xFF186597),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(23, 72, 115, 1),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Center(
                                  child: GridView(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(10.sp),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 5.sp,
                                      crossAxisSpacing: 5.sp,
                                      childAspectRatio: 1.sp,
                                    ),
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
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
                                                child:
                                                    RefreshProgressIndicator()),
                                            errorWidget: (c, s, d) =>
                                                Image.asset(
                                              'assets/images/logo.png',
                                              scale: 7.sp,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
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
                                                child:
                                                    RefreshProgressIndicator()),
                                            errorWidget: (c, s, d) =>
                                                Image.asset(
                                              'assets/images/logo.png',
                                              scale: 7.sp,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
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
                                                child:
                                                    RefreshProgressIndicator()),
                                            errorWidget: (c, s, d) =>
                                                Image.asset(
                                              'assets/images/logo.png',
                                              scale: 7.sp,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
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
                                                child:
                                                    RefreshProgressIndicator()),
                                            errorWidget: (c, s, d) =>
                                                Image.asset(
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
                              Navigator.of(context)
                                  .pushNamed(BenefitsScreen.routeName);
                            },
                            child: GridTile(
                              footer: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF186597).withOpacity(0.4),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                  ),
                                ),
                                // transform: Matrix4.rotationZ(-150)
                                //   ..translate(10.0, -20.0, 0),
                                padding: const EdgeInsets.all(10),
                                child: const Text(
                                  'Benefits',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 5.sp,
                                      crossAxisSpacing: 5.sp,
                                      childAspectRatio: 1.sp,
                                    ),
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
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
                                                child:
                                                    RefreshProgressIndicator()),
                                            errorWidget: (c, s, d) =>
                                                Image.asset(
                                              'assets/images/logo.png',
                                              scale: 7.sp,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
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
                                                child:
                                                    RefreshProgressIndicator()),
                                            errorWidget: (c, s, d) =>
                                                Image.asset(
                                              'assets/images/logo.png',
                                              scale: 7.sp,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
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
                                                child:
                                                    RefreshProgressIndicator()),
                                            errorWidget: (c, s, d) =>
                                                Image.asset(
                                              'assets/images/logo.png',
                                              scale: 7.sp,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
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
                                                child:
                                                    RefreshProgressIndicator()),
                                            errorWidget: (c, s, d) =>
                                                Image.asset(
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
                              Navigator.of(context)
                                  .pushNamed(BenefitsScreen.routeName);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFF186597),
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
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5.sp,
                                    crossAxisSpacing: 5.sp,
                                    childAspectRatio: 1.sp,
                                  ),
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: const Center(
                                          child: Text(
                                        'Benefits',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
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
                                              child:
                                                  RefreshProgressIndicator()),
                                          errorWidget: (c, s, d) => Image.asset(
                                            'assets/images/logo.png',
                                            scale: 7.sp,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
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
                                              child:
                                                  RefreshProgressIndicator()),
                                          errorWidget: (c, s, d) => Image.asset(
                                            'assets/images/logo.png',
                                            scale: 7.sp,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
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
                                              child:
                                                  RefreshProgressIndicator()),
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
                ],
              );
            },
          );
        },
      ),
    );
  }
}



/// ///see more inkWell
//                                               InkWell(onTap: (){
//                                                 Navigator.of(context).pushNamed(NewsScreen.routeName);
//                                               },child: Hero(
//                                                 tag: 'imageId_seeMore',
//                                                 child: Container(
//                                                   width: 27.w,
//                                                   margin: const EdgeInsets.symmetric(
//                                                     horizontal: 4,
//                                                   ),
//                                                   child: ClipRRect(
//                                                     borderRadius: BorderRadius.circular(20),
//                                                     child: GridTile(
//                                                       footer: SizedBox(
//                                                         height: 5.h,
//                                                         child: const GridTileBar(
//                                                           title: Text('Go to News to see more details',
//                                                             style:  TextStyle(
//                                                                 fontWeight: FontWeight.bold,
//                                                                 fontSize: 10,
//                                                                 overflow: TextOverflow.fade),
//                                                           ),
//                                                           backgroundColor: Colors.black54,
//                                                         ),
//                                                       ),
//                                                       child: Image.asset(
//                                                         'assets/images/logo.png',
//                                                         fit: BoxFit.fill,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),);


// Widget newsList(BuildContext context, List<Widget> assets, Map<String,dynamic> newsAllData, List<ImageGalleryHeroProperties> heroProperties){
//   return Row(
//     children: [
//       SizedBox(
//         width: 100.w,
//         height: 30.h,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: 10,
//           itemBuilder: (ctx, index) {
//             Map<String, dynamic> news =
//             newsAllData['data']
//             [newsAllData.length + index];
//             assets.add(Image.network(
//               'https://portal.hassanallam.com/images/imgs/${news['news_ID']}.jpg',
//               fit: BoxFit.fill,
//             ));
//             heroProperties.add(
//               ImageGalleryHeroProperties(
//                   tag: 'imageId$index'),
//             );
//             return InkWell(
//               onTap: () => SwipeImageGallery(
//                 context: context,
//                 children: assets,
//                 initialIndex: index,
//                 heroProperties: heroProperties,
//               ).show(),
//               child: Hero(
//                 tag: 'imageId$index',
//                 child: Container(
//                   width: 25.w,
//                   margin: const EdgeInsets.only(
//                       left: 5, right: 5),
//                   child: ClipRRect(
//                     borderRadius:
//                     BorderRadius.circular(20),
//                     child: Image.network(
//                       'https://portal.hassanallam.com/images/imgs/${news['news_ID']}.jpg',
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     ],
//   );
// }
