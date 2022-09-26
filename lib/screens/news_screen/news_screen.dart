import 'package:cached_network_image/cached_network_image.dart';
import 'package:hassanallamportalflutter/data/models/news_model/news_data_model.dart';
import 'package:hassanallamportalflutter/screens/news_screen/news_details_screen.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("News"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: RefreshIndicator(
          onRefresh: () {
            NewsCubit.get(context).getNewsOld();
            return Future(() => null);
          },
          child: BlocProvider<NewsCubit>.value(
            value: NewsCubit.get(context),
            child: BlocBuilder<NewsCubit, NewsState>(
              builder: (context, state) {
                return ConditionalBuilder(
                  condition: state is NewsSuccessState,
                  builder: (context) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: NewsCubit.get(context).newsList.length,
                      itemBuilder: (ctx, index) {
                        NewsDataModel news =
                            NewsCubit.get(context).newsList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  NewsDetailsScreen.routeName,
                                  arguments: news);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 3,
                                child: GridTile(
                                  footer: GridTileBar(
                                    title: (news.newsTitle
                                            .toString()
                                            .contains('>'))
                                        ? convertFromHtml(
                                            dataToConvert:
                                                news.newsTitle.toString(),
                                            context: context)
                                        : Text(
                                            news.newsTitle ??
                                                "Tap to see more details",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                    backgroundColor: Colors.black54,
                                  ),
                                  child: FadeInImage(
                                    fit: BoxFit.fill,
                                    placeholderFit: BoxFit.scaleDown,
                                    placeholder: Assets.images.loginImageLogo.image().image,
                                    imageErrorBuilder: (_, __, ___) => Assets.images.loginImageLogo.image(),
                                    image: CachedNetworkImageProvider(
                                      'https://portal.hassanallam.com/images/imgs/${news.newsId}.jpg',
                                      errorListener: () => Assets.images.loginImageLogo.image(),
                                    ),

                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  fallback: (_) => const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
