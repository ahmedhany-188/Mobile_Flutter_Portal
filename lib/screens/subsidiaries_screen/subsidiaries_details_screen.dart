import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';

import '../../constants/url_links.dart';
import '../../data/helpers/convert_from_html.dart';
import '../../data/models/subsidiares_model/subsidiares_model.dart';

class SubsidiariesDetailsScreen extends StatelessWidget {
  const SubsidiariesDetailsScreen({Key? key, required this.subsidiariesData})
      : super(key: key);

  static const routeName = 'subsidiaries-details-screen';
  final SubsidiariesData subsidiariesData;

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: CustomTheme(
        child: Scaffold(
          appBar: AppBar(title: Text(subsidiariesData.subName!)),
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
                            imageUrl: subsidiariesIconLink(
                                subsidiariesData.image1.toString()),
                            fit: BoxFit.scaleDown,
                            placeholder: (_, __) => Image.asset(
                                Assets.images.logo.path,fit: BoxFit.scaleDown,height: 60),
                            errorWidget: (_, __, ___) => CachedNetworkImage(
                                imageUrl: subsidiariesIconLink(
                                    subsidiariesData.subIcone.toString())),
                            width: 250),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(subsidiariesData.subName ?? "",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    // Text(newsData.newsDescription ?? ""),
                    convertFromHtml(
                        dataToConvert: subsidiariesData.subDesc ?? "",
                        context: context),
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
