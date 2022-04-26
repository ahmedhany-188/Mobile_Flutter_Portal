import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../widgets/search/general_search.dart';
import 'package:html/dom.dart' as dom;
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/helpers/download_pdf.dart';
import '../../bloc/benefits_screen_bloc/benefits_cubit.dart';

class BenefitsScreen extends StatefulWidget {
  const BenefitsScreen({Key? key}) : super(key: key);

  @override
  State<BenefitsScreen> createState() => _BenefitsScreenState();
}

class _BenefitsScreenState extends State<BenefitsScreen> {
  List<dynamic> benefitsData = [];
  List<dynamic> searchResult = [];

  FocusNode searchTextFieldFocusNode = FocusNode();
  TextEditingController textController = TextEditingController();

  List<dynamic> setBenefitsFilters(int catId, List<dynamic> mainList) {
    return mainList.where((element) => element['catId'] == catId).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BenefitsCubit()..getBenefits(),
      child: BlocConsumer<BenefitsCubit, BenefitsState>(
        listener: (context, state) {
          if (state is BenefitsSuccessState) {
            benefitsData = state.benefits;
          }
        },
        builder: (context, state) {
          return Sizer(
            builder: (c, o, d) => SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      focusNode: searchTextFieldFocusNode,
                      controller: textController,
                      onSubmitted: (searchValue) {
                        searchTextFieldFocusNode.unfocus();
                        setState(() {});
                      },
                      onChanged: (_) {
                        setState(() {
                          searchResult = GeneralSearch().setGeneralSearch(
                            query: textController.text,
                            listKeyForCondition: 'benefitsName',
                            listFromApi: benefitsData,
                          );
                        });
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          isCollapsed: false,
                          labelText: "Search by name",
                          hintText: "Search",
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: (textController.text.isEmpty)
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      searchResult.clear();
                                      textController.clear();
                                      searchTextFieldFocusNode.unfocus();
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                                ),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ),
                  ),
                  Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(right: 5.sp, left: 5.sp),
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RawMaterialButton(
                            child: const Text('Retail shops'),
                            onPressed: () {
                              setState(() {
                                searchResult =
                                    setBenefitsFilters(2, benefitsData);
                                textController.text = 'Retail shops';
                              });
                            },
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            child: const Text('Hotels & travel'),
                            onPressed: () {
                              setState(() {
                                searchResult =
                                    setBenefitsFilters(3, benefitsData);
                                textController.text = 'Hotels & travel';
                              });
                            },
                          ),
                          const SizedBox(width: 10),
                          OutlinedButton(
                            child: const Text('Health & Fitness'),
                            onPressed: () {
                              setState(() {
                                searchResult =
                                    setBenefitsFilters(4, benefitsData);
                                textController.text = 'Health & Fitness';
                              });
                            },
                          ),
                          const SizedBox(width: 10),
                          TextButton(
                            child: const Text('Other'),
                            onPressed: () {
                              setState(() {
                                searchResult =
                                    setBenefitsFilters(5, benefitsData);
                                textController.text = 'Banks, Schools and other';
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).size.shortestSide * 1.1)
                        .sp,
                    child: (searchResult.isNotEmpty ||
                            textController.text.isNotEmpty)
                        ? benefitsListView(searchResult)
                        : benefitsListView(benefitsData),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget benefitsListView(List<dynamic> benefitsDataList) {
    showErrorSnackBar() {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something went wrong'),
      ));
    }

    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return (benefitsDataList.isEmpty)
            ? const Center(child: CircularProgressIndicator())
            : Scrollbar(
                child: ListView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: benefitsDataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: ExpansionTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).devicePixelRatio.sp *
                                      15,
                              width:
                                  MediaQuery.of(context).devicePixelRatio.sp *
                                      25,
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://portal.hassanallam.com/images/Benefits/${benefitsDataList[index]['benefitsId']}.jpg',
                                placeholder: (c, m) => const Center(
                                    child: RefreshProgressIndicator()),
                                errorWidget: (c, s, d) => Image.asset(
                                  'assets/images/logo.png',
                                  scale: 7.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Flexible(
                              child: Text(
                                benefitsDataList[index]['benefitsName'],
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        children: [
                          Html(
                            shrinkWrap: true,
                            data: benefitsDataList[index]['benefitsDescription']
                                .toString(),
                            onLinkTap: (String? url,
                                RenderContext context,
                                Map<String, String> attributes,
                                dom.Element? element) async {
                              // if (await canLaunch(url!)) {
                              //   launch(url);
                              // } else {
                              // var urlNameIndex = url!.lastIndexOf('/');
                              // var urlName =
                              //     url.substring(urlNameIndex + 1, url.length);
                              await DownloadPdfHelper(
                                  fileUrl: url!,
                                  fileName: url.substring(
                                      url.lastIndexOf('/') + 1, url.length),
                                  success: () {},
                                  failed: () {
                                    showErrorSnackBar();
                                  }).download();
                              // }
                            },
                            style: {
                              '#': Style(
                                  fontSize: const FontSize(18),
                                  maxLines: benefitsDataList[index]
                                          ['benefitsDescription']
                                      .length,
                                  // textOverflow: TextOverflow.ellipsis,
                                  margin: const EdgeInsets.all(10)),
                              'strong': Style(fontWeight: FontWeight.normal)
                            },
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (await canLaunch(
                                  'https://portal.hassanallam.com/images/Benefits/${benefitsDataList[index]['benefitsId']}.pdf')) {
                                await launch(
                                    'https://portal.hassanallam.com/images/Benefits/${benefitsDataList[index]['benefitsId']}.pdf');
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'Click Here for more details',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}
