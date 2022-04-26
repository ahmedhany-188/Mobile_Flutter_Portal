import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

import 'download_pdf.dart';

convertFromHtml(
    {required String dataToConvert, required BuildContext context}) {



  showErrorSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Something went wrong'),
    ));
  }

  return SingleChildScrollView(
    child: Html(
      shrinkWrap: true,
      data: dataToConvert.toString(),
      onLinkTap: (String? url, RenderContext renderContext,
          Map<String, String> attributes, dom.Element? element) async {
        if (await canLaunch(url!)) {
          launch(url);
        } else {
          var urlNameIndex = url.lastIndexOf('/');
          var urlName = url.substring(urlNameIndex + 1, url.length);
          await DownloadPdfHelper(
              fileUrl: url,
              fileName: urlName,
              success: () {},
              failed: () {
                showErrorSnackBar();
              }).download();
        }
      },
      style: {
        '#': Style(
            fontSize: const FontSize(18),
            maxLines: dataToConvert.length,
            textOverflow: TextOverflow.ellipsis,
            margin: const EdgeInsets.all(10)),
        'strong': Style(fontWeight: FontWeight.normal)
      },
    ),
  );
}