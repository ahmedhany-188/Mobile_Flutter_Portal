import 'dart:isolate';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sizer/sizer.dart';

import '../../constants/url_links.dart';
import '../../widgets/search/general_search.dart';
import '../../data/helpers/download_pdf.dart';
import '../../bloc/benefits_screen_bloc/benefits_cubit.dart';

class BenefitsScreen extends StatefulWidget {
  const BenefitsScreen({Key? key}) : super(key: key);
  static const routeName = 'benefits-screen';

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
  void initState() {
    super.initState();

    FlutterDownloader.registerCallback(downloadCallback);
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
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
          return Scaffold(
            appBar: AppBar(title: const Text('Benefits'),),
            body: Sizer(
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
                          isCollapsed: true,
                          filled: true,
                          prefixIcon: const Icon(Icons.search),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide.none),
                          labelText: "Search by name",
                          hintText: "Search",
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
                        ),
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
                            OutlinedButton(
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
                            OutlinedButton(
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
                            OutlinedButton(
                              child: const Text('Other'),
                              onPressed: () {
                                setState(() {
                                  searchResult =
                                      setBenefitsFilters(5, benefitsData);
                                  textController.text =
                                      'Banks, Schools and other';
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80.h,
                      child: (searchResult.isNotEmpty)
                          ? benefitsListView(searchResult)
                          : (textController.text.isEmpty)
                              ? benefitsListView(benefitsData)
                              : const Center(
                                  child: Text('No data found'),
                                ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget benefitsListView(List<dynamic> benefitsDataList) {
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
                                imageUrl: benefitsLogosLink(
                                    benefitsDataList[index]['benefitsId']
                                        .toString()),
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
                          WillPopScope(
                            onWillPop: () async {
                              await EasyLoading.dismiss(animation: true);
                              return true;
                            },
                            child: Html(
                              shrinkWrap: true,
                              data: benefitsDataList[index]
                                      ['benefitsDescription']
                                  .toString(),
                              onLinkTap: (String? url, RenderContext context,
                                  Map<String, String> attributes, _) async {
                                EasyLoading.show(
                                  status: 'loading...',
                                  maskType: EasyLoadingMaskType.black,
                                  dismissOnTap: false,
                                );
                                await DownloadPdfHelper(
                                    fileUrl: url!,
                                    fileName: url.substring(
                                        url.lastIndexOf('/') + 1, url.length),
                                    success: () {
                                      // EasyLoading.show(
                                      //     status: 'Success',
                                      //     maskType: EasyLoadingMaskType.black,
                                      //     dismissOnTap: true,
                                      //     indicator: const Icon(
                                      //       Icons.done,
                                      //       size: 50,
                                      //       color: Colors.white,
                                      //     ));
                                      // EasyLoading.dismiss();
                                    },
                                    failed: () {
                                      EasyLoading.show(
                                          status: 'Failed',
                                          maskType: EasyLoadingMaskType.black,
                                          dismissOnTap: true,
                                          indicator: const Icon(
                                            Icons.clear,
                                            size: 50,
                                            color: Colors.white,
                                          ));
                                      // EasyLoading.dismiss();
                                    }).download();
                                if (EasyLoading.isShow) {
                                  EasyLoading.dismiss();
                                }
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
                          ),
                          GestureDetector(
                            onTap: () async {
                              try {
                                launchUrl(
                                  Uri.parse(benefitsExtraDataLink(
                                      benefitsDataList[index]['benefitsId']
                                          .toString())),
                                  mode: LaunchMode.externalApplication,
                                );
                              } catch (e) {
                                EasyLoading.showError('Something went wrong',
                                    dismissOnTap: true);
                              }
                              // }
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'Click Here for more details',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                ),
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
