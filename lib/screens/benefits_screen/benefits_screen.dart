import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import '../../bloc/benefits_screen_bloc/benefits_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class BenefitsScreen extends StatefulWidget {
  BenefitsScreen({Key? key}) : super(key: key);

  @override
  State<BenefitsScreen> createState() => _BenefitsScreenState();
}

class _BenefitsScreenState extends State<BenefitsScreen> {
  List<dynamic> benefitsData = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BenefitsCubit()..getBenefits(),
      child: BlocConsumer<BenefitsCubit, BenefitsState>(
          listener: (context, state) {
        if (state is BenefitsSuccessState) {
          benefitsData = state.benefits;
        }
      }, builder: (context, state) {
        return ListView.builder(
          itemCount: benefitsData.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              margin: const EdgeInsets.all(10),
              child: ExpansionTile(
                // initiallyExpanded: true,
                title: Text(
                  benefitsData[index]['benefitsName'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  Html(
                    shrinkWrap: true,
                    data: benefitsData[index]['benefitsDescription'].toString(),
                    onLinkTap: (String? url,
                        RenderContext context,
                        Map<String, String> attributes,
                        dom.Element? element) async {
                      // if (await canLaunch(url!)) {
                      //   await launch(url);
                      // } else {
                      //   await launch('https://www.google.com');
                      // }
                    },
                    style: {
                      '#': Style(
                          fontSize: const FontSize(18),
                          maxLines: benefitsData.length,
                          textOverflow: TextOverflow.ellipsis,
                          margin: EdgeInsets.all(10)),
                      'strong': Style(fontWeight: FontWeight.normal)
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}