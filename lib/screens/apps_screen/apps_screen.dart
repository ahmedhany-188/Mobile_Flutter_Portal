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

class AppsScreen extends StatelessWidget {
  const AppsScreen({Key? key}) : super(key: key);
  static const routeName = 'apps-screen';

  @override
  Widget build(BuildContext context) {


    final user =
        context.select((AppBloc bloc) => bloc.state.userData.employeeData);
    return Scaffold(
      // drawer: MainDrawer(),
      appBar: AppBar(),

      /// basicAppBar(context, 'Subsidiaries'),
      backgroundColor: Colors.blueGrey,
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
                  return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.appsList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.sp,
                      crossAxisSpacing: 9.sp,
                      mainAxisSpacing: 9.sp,
                    ),
                    itemBuilder: (ctx, index) {
                      AppsData apps = state.appsList[index];

                      return InkWell(
                        onTap: () async {
                          try {
                            await launchUrl(Uri.parse(apps.sysLink.toString()),
                                mode: LaunchMode.externalApplication);
                          } catch (err) {
                            if (kDebugMode) {
                              print(err);
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              createAngularIcon(
                                  angularIcon: apps.angularIcon.toString(),
                                  solid: false,
                                  context: context,
                                  size: 60),
                              Text(
                                '${apps.sysName}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No applications to be shown'),
              );
            }
          },
        ),
      ),
    );
  }
}
