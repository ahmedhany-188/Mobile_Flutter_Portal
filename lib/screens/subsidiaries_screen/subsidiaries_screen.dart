import 'package:cached_network_image/cached_network_image.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../bloc/subsidiaries_screen_bloc/subsidiaries_cubit.dart';
import '../../constants/url_links.dart';
import '../../data/helpers/assist_function.dart';
import 'subsidiaries_details_screen.dart';

class SubsidiariesScreen extends StatefulWidget {
  static const routeName = 'subsidiaries-screen';

  const SubsidiariesScreen({Key? key}) : super(key: key);

  @override
  State<SubsidiariesScreen> createState() => _SubsidiariesScreenState();
}

class _SubsidiariesScreenState extends State<SubsidiariesScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        // drawer: MainDrawer(),
        // appBar: internalAppBar(context: context, title: 'Subsidiaries'),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Subsidiaries'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        /// basicAppBar(context, 'Subsidiaries'),
        backgroundColor: Colors.transparent,
        body: BlocProvider<SubsidiariesCubit>.value(
          value: SubsidiariesCubit.get(context)..getSubsidiaries(),
              // (context) => SubsidiariesCubit()..getSubsidiaries(),
          child: BlocConsumer<SubsidiariesCubit, SubsidiariesState>(
            listener: (context, state) {
              if (state is SubsidiariesErrorState) {
                showErrorSnackBar(context);
              }
            },
            buildWhen: (pre, cur) {
              if (cur is SubsidiariesSuccessState) {
                return cur.subsidiariesList.isNotEmpty;
              } else {
                return false;
              }
            },
            builder: (context, state) {
              return Sizer(builder: (ctx, ori, dt) {
                return (state is SubsidiariesSuccessState)
                    ? ConditionalBuilder(
                        condition: state.subsidiariesList.isNotEmpty,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.all(5.0.sp),
                            child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: 12,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.sp,
                                crossAxisSpacing: 9.sp,
                                mainAxisSpacing: 9.sp,
                              ),
                              itemBuilder: (ctx, index) {
                                var list = state.subsidiariesList[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(SubsidiariesDetailsScreen.routeName,arguments: list);

                                    // showDialog(
                                    //     context: context,
                                    //     builder: (context) {
                                    //       return AlertDialog(
                                    //           backgroundColor: Theme.of(context)
                                    //               .colorScheme
                                    //               .secondary,
                                    //           title:
                                    //               Text(list.subName.toString()),
                                    //           elevation: 20,
                                    //           contentPadding:
                                    //               const EdgeInsets.all(10.0),
                                    //           content: SingleChildScrollView(
                                    //             child: Column(
                                    //               children: [
                                    //                 convertFromHtml(
                                    //                     dataToConvert: list
                                    //                         .subDesc
                                    //                         .toString(),
                                    //                     context: context),
                                    //                 ClipRRect(
                                    //                   borderRadius:
                                    //                       BorderRadius.circular(
                                    //                           20),
                                    //                   child: Image.network(
                                    //                       'https://portal.hassanallam.com/images/subsidiaries/${list.image1}'),
                                    //                 )
                                    //               ],
                                    //             ),
                                    //           ));
                                    //     });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: CachedNetworkImage(
                                        imageUrl: subsidiariesIconLink(
                                            list.subIcone.toString())),
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
                      )
                    : const Center(child: CircularProgressIndicator(color: Colors.white,));
              });
            },
          ),
        ),
      ),
    );
  }
}
