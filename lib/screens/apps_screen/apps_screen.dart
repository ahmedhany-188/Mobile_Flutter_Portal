import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/apps_model/apps_model.dart';
import '../../bloc/apps_screen_bloc/apps_cubit.dart';
import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../data/helpers/assist_function.dart';
import '../../widgets/icons/angular_icon.dart';

class AppsScreen extends StatefulWidget {
  const AppsScreen({Key? key}) : super(key: key);
  static const routeName = 'apps-screen';

  @override
  State<AppsScreen> createState() => _AppsScreenState();
}

class _AppsScreenState extends State<AppsScreen> {
  FocusNode searchTextFieldFocusNode = FocusNode(canRequestFocus: false);
  TextEditingController textController = TextEditingController();
  List<AppsData> searchResultsList = [];
  // @override
  // void initState() {
  //   FocusManager.instance.primaryFocus?.unfocus();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    final user =
        context.select((AppBloc bloc) => bloc.state.userData.employeeData);

    return Scaffold(
      // drawer: MainDrawer(),
      // appBar: AppBar(),

      /// basicAppBar(context, 'Subsidiaries'),
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => AppsCubit()..getApps(hrCode: user!.userHrCode),
        child: BlocConsumer<AppsCubit, AppsState>(
          listener: (context, state) {
            if (state is AppsErrorState) {
              showErrorSnackBar(context);
            }
          },
          buildWhen: (pre, cur) {
            if (cur is AppsSuccessState) {
              return cur.appsList.isNotEmpty;
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
                          focusNode: searchTextFieldFocusNode,
                          controller: textController,
                          onChanged: (_) {
                            setState(() {
                              searchResultsList = setGeneralSearch(
                                  textController.text.toString(),
                                  state.appsList);
                            });
                          },
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              isCollapsed: true,
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
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: (searchResultsList.isNotEmpty)
                              ? searchResultsList.length
                              : state.appsList.length,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.sp,
                            crossAxisSpacing: 15.sp,
                            mainAxisSpacing: 10.sp,
                          ),
                          itemBuilder: (ctx, index) {
                            return (textController.text.isEmpty)
                                ? buildApps(state.appsList, index, context)
                                : buildApps(searchResultsList, index, context);
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {

              return buildNoAppsFound(context);
            }
          },
        ),
      ),
    );
  }

  buildApps(List<AppsData> apps, int index, BuildContext appsContext) {
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
              angularIcon: apps[index].angularIcon.toString(),
              solid: false,
              context: appsContext,
              color: Colors.white,
              size: 60,
            ),
            Text(
              '${apps[index].sysName}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildNoAppsFound(BuildContext noAppscontext) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png', scale: 4.sp),
          // SizedBox(child: ),
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
}

List<AppsData> setGeneralSearch(
  String query,
  List<AppsData> listFromApi,
) {
  var splitQuery = query.toLowerCase().trim().split(' ');
  return listFromApi
      .where((element) => splitQuery.every(
            (singleSplitElement) => element.sysName
                .toString()
                .toLowerCase()
                .trim()
                .contains(singleSplitElement),
          ))
      .toList();
}
