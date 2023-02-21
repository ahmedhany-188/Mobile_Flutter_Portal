import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_grouped_listview/simple_grouped_listview.dart';
import 'package:hassanallamportalflutter/data/models/apps_model/apps_drawer_model.dart';

// import '../../data/models/apps_model/apps_model.dart';
import '../../bloc/apps_screen_bloc/apps_cubit.dart';
import '../../widgets/icons/angular_icon.dart';

class AppsScreen extends StatelessWidget {
  const AppsScreen({Key? key}) : super(key: key);
  static const routeName = 'apps-screen';

  @override
  Widget build(BuildContext context) {
    AppsCubit.get(context).getApps();
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: BlocProvider<AppsCubit>.value(
        value: AppsCubit.get(context),
        child: BlocBuilder<AppsCubit, AppsState>(
          buildWhen: (pre, curr) {
            if (pre != curr) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            if (state is AppsSuccessState) {
              return Sizer(
                builder: (ctx, ori, dt) {
                  return Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(left: 4.w, right: 4.w, top: 2.5.h),
                        height: 10.h,
                        width: 100.w,
                        child: TextField(
                          onChanged: (searchText) {
                            AppsCubit.get(context).updateApps(searchText);
                          },
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              filled: true,
                              labelText: "Search Apps",
                              hintText: "Search Apps",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                      Container(
                        height: 87.5.h,
                        width: 100.w,
                        margin: EdgeInsets.only(left: 4.w, right: 4.w),
                        child: buildSeperatedGridApps(state.appsList, context),
                      ),
                    ],
                  );
                },
              );
            } else {
              return (state is AppsErrorState)
                  ? buildNoAppsFound()
                  : const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  buildSeperatedGridApps(List<AppDrawerModel> apps, BuildContext appsContext) {
    return (apps.isNotEmpty)
        ? GroupedListView<String, AppDrawerModel>.grid(
            items: apps,
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            headerSorter: (string1, string2) {
              if (string1.contains('Staff')) {
                return 0;
              }
              if (string1.contains('DSS')) {
                return 1;
              } else {
                return 3;
              }
            },
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemGrouper: (element) {
              if (element.sysName!.contains('Staff')) {
                return element.sysName!;
              } else if (element.sysName!.length == 3) {
                return 'Three Letters systems';
              } else {
                return 'Other';
              }
            },
            headerBuilder: (context, stringTest) => Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.only(bottom: 10, top: 10),
              padding: const EdgeInsets.all(16),
              child: Text(
                stringTest,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            gridItemBuilder:
                (_, int countInGroup, int itemIndexInGroup, element) => InkWell(
              onTap: () async {
                try {
                  await launchUrl(Uri.parse(element.sysLink.toString()),
                      mode: LaunchMode.externalApplication);
                } catch (err) {
                  if (kDebugMode) {
                    print(err);
                  }
                }
              },
              child: Container(
                // margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1a4c78),
                        Color(0xFF3772a6),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      tileMode: TileMode.clamp),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    createAngularIcon(
                      angularIcon: element.sysIcon.toString(),
                      solid: false,
                      context: appsContext,
                      color: Colors.white,
                      size: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        clipBehavior: Clip.none,
                        child: Text(
                          '${element.sysName}',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : (AppsCubit.get(appsContext).appsList.isEmpty)
            ? buildNoAppsFound()
            : buildNoSearchFound();
  }
  // buildSeperatedApps(List<AppsData> apps, BuildContext appsContext) {
  //   return (apps.isNotEmpty)
  //       ? GroupedListView<AppsData, String>(
  //           keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
  //           elements: apps,
  //           groupBy: (element) {
  //             if (element.sysName!.contains('Staff')) {
  //               return element.sysName!;
  //             } else if (element.sysName!.length == 3) {
  //               return 'three Leters systems';
  //             } else {
  //               return 'other';
  //             }
  //           },
  //           groupComparator: (value1, value2) => value2.compareTo(value1),
  //           // itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']),
  //           order: GroupedListOrder.DESC,
  //           useStickyGroupSeparators: true,
  //           shrinkWrap: true,
  //           groupSeparatorBuilder: (String value) => Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(
  //               value,
  //               textAlign: TextAlign.center,
  //               style:
  //                   const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           itemBuilder: (c, element) {
  //             return GridView(
  //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                   crossAxisCount: 2, childAspectRatio: 1.sp),
  //               primary: true,
  //               shrinkWrap: true,
  //               clipBehavior: Clip.none,
  //               physics: const NeverScrollableScrollPhysics(),
  //               children: [
  //                 InkWell(
  //                   onTap: () async {
  //                     try {
  //                       await launchUrl(Uri.parse(element.sysLink.toString()),
  //                           mode: LaunchMode.externalApplication);
  //                     } catch (err) {
  //                       if (kDebugMode) {
  //                         print(err);
  //                       }
  //                     }
  //                   },
  //                   child: Container(
  //                     margin: const EdgeInsets.only(bottom: 5),
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(20),
  //                       gradient: const LinearGradient(
  //                           colors: [
  //                             Color(0xFF1a4c78),
  //                             Color(0xFF3772a6),
  //                           ],
  //                           begin: Alignment.bottomLeft,
  //                           end: Alignment.topRight,
  //                           tileMode: TileMode.clamp),
  //                     ),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         createAngularIcon(
  //                           angularIcon: element.angularIcon.toString(),
  //                           solid: false,
  //                           context: appsContext,
  //                           color: Colors.white,
  //                           size: 60,
  //                         ),
  //                         Text(
  //                           '${element.sysName}',
  //                           style: const TextStyle(
  //                             fontSize: 18,
  //                             fontWeight: FontWeight.w400,
  //                             color: Colors.white,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             );
  //           },
  //         )
  //       : (AppsCubit.get(appsContext).appsList.isEmpty)
  //           ? buildNoAppsFound()
  //           : buildNoSearchFound();
  // }

  buildApps(List<AppDrawerModel> apps, BuildContext appsContext) {
    return (apps.isNotEmpty)
        ? GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: apps.length,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.sp,
              crossAxisSpacing: 5.sp,
              mainAxisSpacing: 5.sp,
            ),
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () async {
                  try {
                    await launchUrl(Uri.parse(apps[index].sysLink.toString()),
                        mode: LaunchMode.externalApplication);
                  } catch (err) {
                    if (kDebugMode) {
                      print(err);
                    }
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                        colors: [
                          Color(0xFF1a4c78),
                          Color(0xFF3772a6),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        tileMode: TileMode.clamp),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      createAngularIcon(
                        angularIcon: apps[index].sysIcon.toString(),
                        solid: false,
                        context: appsContext,
                        color: Colors.white,
                        size: 30,
                      ),
                      Flexible(
                        child: Text(
                          '${apps[index].sysName}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })
        : (AppsCubit.get(appsContext).appsList.isEmpty)
            ? buildNoAppsFound()
            : buildNoSearchFound();
  }

  buildNoAppsFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png', scale: 4.sp),
          const Text(
            'No applications to be shown\nContact HR',
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'RobotoFlex',
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  buildNoSearchFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png', scale: 4.sp),
          const Text(
            'Unfortunately, \nyou have no Application with this name',
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'RobotoFlex',
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
