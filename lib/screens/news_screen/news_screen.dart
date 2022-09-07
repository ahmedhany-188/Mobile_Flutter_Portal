import 'package:cached_network_image/cached_network_image.dart';
import 'package:hassanallamportalflutter/data/models/news_model/news_data_model.dart';
import 'package:hassanallamportalflutter/screens/news_screen/news_details_screen.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../bloc/news_screen_bloc/news_cubit.dart';
import '../../data/helpers/convert_from_html.dart';
import '../../gen/assets.gen.dart';

class NewsScreen extends StatelessWidget {
  static const routeName = 'news-screen';
  const NewsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        /// basicAppBar(context, 'News'),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("News"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),



        body: BlocProvider<NewsCubit>.value(
          value:NewsCubit.get(context),
          child: BlocBuilder<NewsCubit, NewsState>(
            // listener: (context, state) {
            //   if (state is NewsSuccessState) {
            //     newsAllData = state.newsList;
            //     setState(() {});
            //   }
            // },
            // buildWhen: (previous, curreny) {
            //   if (curreny is NewsSuccessState) {
            //     newsAllData = curreny.newsList;
            //     return newsAllData.isNotEmpty;
            //   } else {
            //     return false;
            //   }
            // },
            builder: (context, state) {
              return Sizer(builder: (ctx, ori, dt) {
                return ConditionalBuilder(
                  condition: state is NewsSuccessState,
                  builder: (context) {
                    // List<Data> newsList = newsAllData;
                    return Padding(
                      padding: EdgeInsets.all(5.0.sp),
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: NewsCubit.get(context).newsList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1.sp,
                          crossAxisSpacing: 9.sp,
                          mainAxisSpacing: 9.sp,
                        ),
                        itemBuilder: (ctx, index) {
                          NewsDataModel news = NewsCubit.get(context).newsList[index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(NewsDetailsScreen.routeName,arguments: news);

                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: GridTile(
                                footer: GridTileBar(
                                  title:(news.newsTitle.toString().contains('>'))?convertFromHtml(dataToConvert: news.newsTitle.toString(), context: context)  :Text(
                                    news.newsTitle ?? "Tap to see more details",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  backgroundColor: Colors.black54,
                                ),
                                child: FadeInImage(
                                  placeholderFit: BoxFit.scaleDown,
                                  placeholder:
                                      AssetImage(Assets.images.loginImageLogo.path),
                                  image: CachedNetworkImageProvider(
                                    'https://portal.hassanallam.com/images/imgs/${news.newsId}.jpg',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  fallback: (_) => const Center(child: CircularProgressIndicator()),
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
