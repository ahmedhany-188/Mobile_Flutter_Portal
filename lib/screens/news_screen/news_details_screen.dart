import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/data/models/response_news.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';

import '../../data/helpers/convert_from_html.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({Key? key, required this.newsData}) : super(key: key);

  static const routeName = 'news-details-screen';
  final NewsData newsData;

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
                                'https://portal.hassanallam.com/images/imgs/${newsData.newsID}.jpg',
                            fit: BoxFit.scaleDown,
                            width: 250),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(newsData.newsTitle ?? "",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    // Text(newsData.newsDescription ?? ""),
                    convertFromHtml(
                        dataToConvert: newsData.newsBody ?? "", context: context),

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
