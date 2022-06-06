

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/my_requests_screen_bloc/my_requests_cubit.dart';
import 'package:hassanallamportalflutter/screens/my_requests_screen/my_requests_ticket_widget.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';

class MyRequestsScreen extends StatefulWidget{


  static const routeName = "/my-requests-screen";
  const MyRequestsScreen({Key? key}) : super(key: key);

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreen();

}


class _MyRequestsScreen extends State<MyRequestsScreen> {


  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery
        .of(context)
        .size;
    bool loadingAttendanceData = false;

    List<dynamic> MyRequestsListData = [];
    String myRequestStringData = "";

    final user = context.select((AppBloc bloc) => bloc.state.userData);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Requests'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,

      drawer: MainDrawer(),


      body: BlocProvider<MyRequestsCubit>(

        create: (context) =>
        MyRequestsCubit()
          ..getRequests(user.user!.userHRCode.toString()),

        child: BlocConsumer<MyRequestsCubit, MyRequestsState>(
          listener: (context, state) {
            if (state is BlocGetMyRequestsSuccesState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Success"),
                ),
              );
              myRequestStringData = state.getMyrequests;
              MyRequestsListData = jsonDecode(myRequestStringData);
            }
            else if (state is BlocGetMyRequestsLoadingState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Loading"),

                ),
              );
            }
            else if (state is BlocGetMyRequestsErrorState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("error"),
                ),
              );
            }
          },
          builder: (context, state) {
            return Container(
              child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        height: deviceSize.height -
                            ((deviceSize.height * 0.24) -
                                MediaQuery
                                    .of(context)
                                    .viewPadding
                                    .top),
                        child: MyReqyestsTicketWidget(MyRequestsListData),

                      )
                    ],
                  )
              ),


              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(
                      "assets/images/S_Background.png"),
                      fit: BoxFit.cover)
              ),
            );
          },
        ),
      ),
    );
  }

}