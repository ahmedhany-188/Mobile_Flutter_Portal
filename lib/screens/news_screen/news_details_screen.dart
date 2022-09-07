import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';

import '../../data/helpers/convert_from_html.dart';
import '../../data/models/news_model/news_data_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({Key? key, required this.newsData}) : super(key: key);

  static const routeName = 'news-details-screen';
  final NewsDataModel newsData;

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: CustomTheme(
        child: Scaffold(
          appBar: AppBar(title: Text(newsData.newsTitle!)),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                            imageUrl:
                                'https://portal.hassanallam.com/images/imgs/${newsData.newsId}.jpg',
                            fit: BoxFit.cover,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: (newsData.newsTitle.toString().contains('<'))? convertFromHtml(dataToConvert: newsData.newsTitle.toString(), context: context) :Text(newsData.newsTitle ?? "",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    // Text(newsData.newsDescription ?? ""),
                    convertFromHtml(
                        dataToConvert: newsData.newsBody ?? '${newsData.newsDescription}', context: context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// showDialog(
// context: context,
// builder: (context) {
// return AlertDialog(
// backgroundColor:
// Theme.of(context).colorScheme.background,
// title: Text(news.newsTitle ?? ""),
// elevation: 20,
// contentPadding: const EdgeInsets.all(10.0),
// content: SingleChildScrollView(
// child: Column(
// children: [
// Text(news.newsDescription ?? ""),
// convertFromHtml(
// dataToConvert: news.newsBody ?? "",
// context: context),
// ClipRRect(
// borderRadius:
// BorderRadius.circular(20),
// child: Image.network(
// 'https://portal.hassanallam.com/images/imgs/${news.newsID}.jpg'),
// ),
// ],
// ),
// ),
// );
// },
// );
