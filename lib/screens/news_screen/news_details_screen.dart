import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';

import '../../data/helpers/convert_from_html.dart';
import '../../data/models/news_model/news_data_model.dart';
import '../../gen/assets.gen.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({Key? key, required this.newsData}) : super(key: key);

  static const routeName = 'news-details-screen';
  final NewsDataModel newsData;

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: CustomTheme(
        child: Scaffold(
          appBar: AppBar(title: convertTitleFromHtml(dataToConvert: newsData.newsTitle??'', context: context),),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
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
                        errorWidget: (_,__,___)=>Assets.images.loginImageLogo.image() ,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: (newsData.newsTitle.toString().contains('<'))? convertFromHtml(dataToConvert: newsData.newsTitle.toString(), context: context) :Text(newsData.newsTitle ?? "",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  // Text(newsData.newsDescription ?? ""),
                  convertFromHtml(
                      dataToConvert: newsData.newsBody ?? '${newsData.newsDescription}', context: context),
                  const Padding(padding: EdgeInsets.all(50)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
