

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/my_requests_screen_bloc/my_requests_cubit.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_requests_model_form.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:hassanallamportalflutter/screens/my_requests_screen/my_requests_ticket_widget.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';

class MyRequestsScreen extends StatefulWidget{


  static const routeName = "/my-requests-screen";
  const MyRequestsScreen({Key? key}) : super(key: key);

  @override
  State<MyRequestsScreen> createState() => MyRequestsScreenClass();

}


class MyRequestsScreenClass extends State<MyRequestsScreen> {


  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery
        .of(context)
        .size;

    // ignore: non_constant_identifier_names

    final user = context.select((AppBloc bloc) => bloc.state.userData);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Requests'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,

      body: BlocProvider<MyRequestsCubit>(

        create: (context) =>
        MyRequestsCubit(RequestRepository(user))
          ..getRequests(user.user!.userHRCode.toString()),

        child: BlocConsumer<MyRequestsCubit, MyRequestsState>(
          listener: (context, state) {
            if (state is BlocGetMyRequestsSuccessState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Success"),
                ),
              );
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
              decoration: const BoxDecoration(
                // image: DecorationImage(
                //     image: AssetImage(
                //     "assets/images/S_Background.png"),
                //     fit: BoxFit.cover
                // )
                color: Colors.white,
              ),
              child: state is BlocGetMyRequestsSuccessState ? Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    height: deviceSize.height,
                    child: MyReqyestsTicketWidget(
                        state.getMyRequests, user.employeeData!.userHrCode!),
                  )
              ) : Container(),
            );
          },
        ),
      ),
    );
  }

}