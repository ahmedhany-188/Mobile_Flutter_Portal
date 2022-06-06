//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_bloc/flutter_form_bloc.dart';
// import 'package:hassanallamportalflutter/bloc/admin_requests_screen_bloc/travel_request/travel_request_cubit.dart';
// import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
// import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';
//
// class TravelRequestScreen extends StatefulWidget{
//
//
//   static const routeName = "/travel-request-screen";
//   const TravelRequestScreen({Key? key}) : super(key: key);
//
//   @override
//   State<TravelRequestScreen> createState() => _TravelRequestScreen();
//
//
// }
//
// class _TravelRequestScreen extends State<TravelRequestScreen> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     var deviceSize = MediaQuery
//         .of(context)
//         .size;
//     final user = context.select((AppBloc bloc) => bloc.state.userData);
//     var formatter = DateFormat('yyyy-MM-dd');
//     String formattedDate = formatter.format(DateTime.now());
//
//     List<String> requesterTypes = ["Myself","on behalf","Groups"];
//
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Travel Request"),
//           centerTitle: true,
//         ),
//
//         resizeToAvoidBottomInset: false,
//
//         drawer: MainDrawer(),
//
//
//         body: BlocListener<TravelRequestCubit, TravelRequestInitial>(
//             listener: (context, state) => {
//
//             if (state.status.isSubmissionSuccess) {
//             ScaffoldMessenger.of(context).hideCurrentSnackBar();
//         ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text("Success"),
//       ),
//     );
//
//     print("---------..--" + state.successMessage.toString());
//   } else if (state.status.isSubmissionInProgress) {
//     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//     ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//     content: Text("Loading"),
//     ),
//     );
//     } else if (state.status.isSubmissionFailure) {
//     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//     ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//     content: Text(state.errorMessage.toString()),
//     ),
//     );
//     }
//
//     },
//
//     child: Container(
//     child: Padding(
//     padding: const EdgeInsets.all(10),
//     child: Form(
//     child: SingleChildScrollView(
//     child: Column(
//     children: [
//
//     ],
//     ),
//
//     ),
//     ),
//
//     ),
//     ),
//
//     )
//     ,
//
//     );
//
//   }
//
// }