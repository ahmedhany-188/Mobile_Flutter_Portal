
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../bloc/news_screen_bloc/news_cubit.dart';
import '../../data/helpers/convert_from_html.dart';
import '../../data/models/response_news.dart';
import '../../widgets/appbar/basic_appbar.dart';
import '../../widgets/drawer/main_drawer.dart';

class NewsScreen extends StatefulWidget {
  static const routeName = 'news-screen';
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<Data> newsAllData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: MainDrawer(),
      appBar:AppBar(),/// basicAppBar(context, 'News'),
      backgroundColor: Colors.cyan,
      body: BlocProvider(
        create: (context) => NewsCubit()..getNews(),
        child: BlocConsumer<NewsCubit, NewsState>(
          listener: (context, state) {
            if (state is NewsSuccessState) {
              newsAllData = state.newsList;
              setState(() {});
            }
          },
          builder: (context, state) {
            return Sizer(builder: (ctx, ori, dt) {
              return ConditionalBuilder(
                condition: newsAllData.isNotEmpty,
                builder: (context) {
                  // List<Data> newsList = newsAllData;
                  return Padding(
                    padding: EdgeInsets.all(5.0.sp),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: newsAllData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.sp,
                        crossAxisSpacing: 9.sp,
                        mainAxisSpacing: 9.sp,
                      ),
                      itemBuilder: (ctx, index) {
                        Data news = newsAllData[index];
                        return InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.background,
                                  title: Text(news.newsTitle ?? ""),
                                  elevation: 20,
                                  contentPadding: const EdgeInsets.all(10.0),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text(news.newsDescription ?? ""),
                                        convertFromHtml(
                                            dataToConvert: news.newsBody ?? "",
                                            context: context),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                              'https://portal.hassanallam.com/images/imgs/${news.newsID}.jpg'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: GridTile(
                              child: FadeInImage(
                                placeholder: const AssetImage('assets/images/logo.png'),
                                image: NetworkImage(
                                  'https://portal.hassanallam.com/images/imgs/${news.newsID}.jpg',
                                ),
                                fit: BoxFit.fill,
                              ),
                              footer: GridTileBar(
                                title:Text( news.newsTitle ?? "Tap to see more details",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                backgroundColor: Colors.black54,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                fallback: (_) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Center(child: CircularProgressIndicator()),
                    Center(child: Text('Loading...')),
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
