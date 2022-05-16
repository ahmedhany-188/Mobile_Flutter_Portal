import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/request_input_widgets.dart';
import '../../../bloc/hr_request_bloc/permission_cubit.dart';

// import '../../../bloc/hr_request_bloc/hr_permission_form_bloc.dart';

class PermissionScreen extends StatefulWidget {
  static const routeName = 'permission-page';

  const PermissionScreen({Key? key}) : super(key: key);

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  Widget build(BuildContext context) {
    // final formBloc = context.select((PermissionFormBloc bloc) => bloc.state);
    final formBloc = context.read<PermissionCubit>();

    // final _formKey = GlobalKey<FormState>();

    return Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(title: const Text('Permission Request')),
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {},
                icon: const Icon(Icons.error_outline),
                label: const Text('ADD ERRORS'),
              ),
              const SizedBox(height: 12),
              FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {},
                icon: const Icon(Icons.send),
                label: const Text('SUBMIT'),
              ),
            ],
          ),
          body: BlocConsumer<PermissionCubit, PermissionInitial>(
              listener: (context, state) {
            // if (state.status.isSubmissionFailure) {
            //   ScaffoldMessenger.of(context)
            //     ..hideCurrentSnackBar()
            //     ..showSnackBar(
            //       SnackBar(
            //         content: Text(
            //             state.errorMessage ?? 'Authentication Failure'),
            //       ),
            //     );
            // }
          }, builder: (context, state) {
            // context.read<PermissionCubit>().getRequestData();
            // var nowState = state.
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: TextFormField(
                          key: const Key('loginForm_usernameInput_textField'),
                          initialValue: state.requestDate.value,
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: 'Request Date',
                            errorText: state.requestDate.invalid
                                ? 'invalid request date'
                                : null,
                            prefixIcon:  const Icon(Icons.date_range),
                          ),
                        ),
                      ),
                      // Padding(padding: EdgeInsets.all(12)),
                      InputTextField(
                        hintText: "Permission Date",
                        icon: Icon(Icons.date_range_outlined),
                        enabled: true,
                        initialValue: "",
                      ),
                      // Padding(padding: EdgeInsets.all(12)),
                      InputTextField(
                        hintText: "Request Type",
                        icon: Icon(Icons.merge_type),
                        enabled: true,
                        initialValue: "",
                      ),

                      InputTextField(
                        hintText: "From Time",
                        icon: Icon(Icons.access_time),
                        enabled: true,
                        initialValue: "",
                      ),

                      InputTextField(
                        hintText: "Add your comment",
                        icon: Icon(Icons.comment),
                        enabled: true,
                        initialValue: "",
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        )
        // body: FormBlocListener<PermissionFormBloc, String, String>(
        //   onSubmitting: (context, state) {
        //     LoadingDialog.show(context);
        //   },
        //   onSuccess: (context, state) {
        //     LoadingDialog.hide(context);
        //
        //     Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(builder: (_) => const SuccessScreen()));
        //   },
        //   onFailure: (context, state) {
        //     LoadingDialog.hide(context);
        //     ScaffoldMessenger.of(context).showSnackBar(
        //         SnackBar(content: Text(state.failureResponse!)));
        //   },
        //   child: ScrollableFormBlocManager(
        //     formBloc: formBloc,
        //     child: SingleChildScrollView(
        //       physics: const ClampingScrollPhysics(),
        //       padding: const EdgeInsets.all(20.0),
        //       child: Column(
        //         children: <Widget>[
        //           DateTimeFieldBlocBuilder(
        //             dateTimeFieldBloc: formBloc.date1,
        //             format: DateFormat('dd-MM-yyyy'),
        //             initialDate: DateTime.now(),
        //             firstDate: DateTime(1900),
        //             lastDate: DateTime(2100),
        //             decoration: const InputDecoration(
        //               labelText: 'DateTimeFieldBlocBuilder',
        //               prefixIcon: Icon(Icons.calendar_today),
        //               helperText: 'Date',
        //             ),
        //           ),
        //           DateTimeFieldBlocBuilder(
        //             dateTimeFieldBloc: formBloc.dateAndTime1,
        //             canSelectTime: true,
        //             format: DateFormat('dd-MM-yyyy  hh:mm'),
        //             initialDate: DateTime.now(),
        //             firstDate: DateTime(1900),
        //             lastDate: DateTime(2100),
        //             decoration: const InputDecoration(
        //               labelText: 'DateTimeFieldBlocBuilder',
        //               prefixIcon: Icon(Icons.date_range),
        //               helperText: 'Date and Time',
        //             ),
        //           ),
        //           TimeFieldBlocBuilder(
        //             timeFieldBloc: formBloc.time1,
        //             format: DateFormat('hh:mm a'),
        //             initialTime: TimeOfDay.now(),
        //             decoration: const InputDecoration(
        //               labelText: 'TimeFieldBlocBuilder',
        //               prefixIcon: Icon(Icons.access_time),
        //             ),
        //           ),
        //           SwitchFieldBlocBuilder(
        //             booleanFieldBloc: formBloc.boolean2,
        //             body: const Text('SwitchFieldBlocBuilder'),
        //           ),
        //           DropdownFieldBlocBuilder<String>(
        //             selectFieldBloc: formBloc.select1,
        //             decoration: const InputDecoration(
        //               labelText: 'DropdownFieldBlocBuilder',
        //             ),
        //             itemBuilder: (context, value) =>
        //                 FieldItem(
        //                   isEnabled: value != 'Option 1',
        //                   child: Text(value),
        //                 ),
        //           ),
        //           Row(
        //             children: [
        //               IconButton(
        //                 onPressed: () =>
        //                     formBloc.addFieldBloc(
        //                         fieldBloc: formBloc.select1),
        //                 icon: const Icon(Icons.add),
        //               ),
        //               IconButton(
        //                 onPressed: () =>
        //                     formBloc.removeFieldBloc(
        //                         fieldBloc: formBloc.select1),
        //                 icon: const Icon(Icons.delete),
        //               ),
        //             ],
        //           ),
        //           CheckboxFieldBlocBuilder(
        //             booleanFieldBloc: formBloc.boolean1,
        //             body: const Text('CheckboxFieldBlocBuilder'),
        //           ),
        //           CheckboxFieldBlocBuilder(
        //             booleanFieldBloc: formBloc.boolean1,
        //             body: const Text('CheckboxFieldBlocBuilder trailing'),
        //             controlAffinity:
        //             FieldBlocBuilderControlAffinity.trailing,
        //           ),
        //           SliderFieldBlocBuilder(
        //             inputFieldBloc: formBloc.double1,
        //             divisions: 10,
        //             labelBuilder: (context, value) =>
        //                 value.toStringAsFixed(2),
        //           ),
        //           SliderFieldBlocBuilder(
        //             inputFieldBloc: formBloc.double1,
        //             divisions: 10,
        //             labelBuilder: (context, value) =>
        //                 value.toStringAsFixed(2),
        //             activeColor: Colors.red,
        //             inactiveColor: Colors.green,
        //           ),
        //           SliderFieldBlocBuilder(
        //             inputFieldBloc: formBloc.double1,
        //             divisions: 10,
        //             labelBuilder: (context, value) =>
        //                 value.toStringAsFixed(2),
        //           ),
        //           ChoiceChipFieldBlocBuilder<String>(
        //             selectFieldBloc: formBloc.select2,
        //
        //             itemBuilder: (context, value) =>
        //                 ChipFieldItem(
        //                   label: Text(value),
        //                 ),
        //           ),
        //           FilterChipFieldBlocBuilder<String>(
        //             multiSelectFieldBloc: formBloc.multiSelect1,
        //             itemBuilder: (context, value) =>
        //                 ChipFieldItem(
        //                   label: Text(value),
        //                 ),
        //           ),
        //           BlocBuilder<InputFieldBloc<File?, String>,
        //               InputFieldBlocState<File?, String>>(
        //               bloc: formBloc.file,
        //               builder: (context, state) {
        //                 return Container();
        //               })
        //         ],
        //       ),
        //     ),
        //   ),
        // ),

        );
  }
}

// BlocListener<PermissionCubit>(
//   onSubmitting: (context, state) {
//     LoadingDialog.show(context);
//   },
//   onSuccess: (context, state) {
//     LoadingDialog.hide(context);
//
//     Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (_) => const SuccessScreen()));
//   },
//   onSubmissionFailed: (context, state) {
//     LoadingDialog.hide(context);
//   },
//   onFailure: (context, state) {
//     LoadingDialog.hide(context);
//     ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(state.failureResponse!)));
//   },
//   child: ScrollableFormBlocManager(
//     formBloc: formBloc,
//     child: SingleChildScrollView(
//       physics: const ClampingScrollPhysics(),
//       padding: const EdgeInsets.all(24.0),
//       child: Column(
//         children: <Widget>[
//           TextFieldBlocBuilder(
//             textFieldBloc: formBloc.text1,
//             // suffixButton: SuffixButton.obscureText,
//             decoration: const InputDecoration(
//               labelText: 'TextFieldBlocBuilder',
//               prefixIcon: Icon(Icons.text_fields),
//             ),
//           ),
//           RadioButtonGroupFieldBlocBuilder<String>(
//             selectFieldBloc: formBloc.select2,
//             decoration: const InputDecoration(
//               labelText: 'RadioButtonGroupFieldBlocBuilder',
//             ),
//             groupStyle: const FlexGroupStyle(),
//             itemBuilder: (context, item) =>
//                 FieldItem(
//                   child: Text(item),
//                 ),
//           ),
//           CheckboxGroupFieldBlocBuilder<String>(
//             multiSelectFieldBloc: formBloc.multiSelect1,
//             decoration: const InputDecoration(
//               labelText: 'CheckboxGroupFieldBlocBuilder',
//             ),
//             groupStyle: const ListGroupStyle(
//               scrollDirection: Axis.horizontal,
//               height: 64,
//             ),
//             itemBuilder: (context, item) =>
//                 FieldItem(
//                   child: Text(item),
//                 ),
//           ),
//           DateTimeFieldBlocBuilder(
//             dateTimeFieldBloc: formBloc.date1,
//             format: DateFormat('dd-MM-yyyy'),
//             initialDate: DateTime.now(),
//             firstDate: DateTime(1900),
//             lastDate: DateTime(2100),
//             decoration: const InputDecoration(
//               labelText: 'DateTimeFieldBlocBuilder',
//               prefixIcon: Icon(Icons.calendar_today),
//               helperText: 'Date',
//             ),
//           ),
//           DateTimeFieldBlocBuilder(
//             dateTimeFieldBloc: formBloc.dateAndTime1,
//             canSelectTime: true,
//             format: DateFormat('dd-MM-yyyy  hh:mm'),
//             initialDate: DateTime.now(),
//             firstDate: DateTime(1900),
//             lastDate: DateTime(2100),
//             decoration: const InputDecoration(
//               labelText: 'DateTimeFieldBlocBuilder',
//               prefixIcon: Icon(Icons.date_range),
//               helperText: 'Date and Time',
//             ),
//           ),
//           TimeFieldBlocBuilder(
//             timeFieldBloc: formBloc.time1,
//             format: DateFormat('hh:mm a'),
//             initialTime: TimeOfDay.now(),
//             decoration: const InputDecoration(
//               labelText: 'TimeFieldBlocBuilder',
//               prefixIcon: Icon(Icons.access_time),
//             ),
//           ),
//           SwitchFieldBlocBuilder(
//             booleanFieldBloc: formBloc.boolean2,
//             body: const Text('SwitchFieldBlocBuilder'),
//           ),
//           DropdownFieldBlocBuilder<String>(
//             selectFieldBloc: formBloc.select1,
//             decoration: const InputDecoration(
//               labelText: 'DropdownFieldBlocBuilder',
//             ),
//             itemBuilder: (context, value) =>
//                 FieldItem(
//                   isEnabled: value != 'Option 1',
//                   child: Text(value),
//                 ),
//           ),
//           Row(
//             children: [
//               IconButton(
//                 onPressed: () =>
//                     formBloc.addFieldBloc(
//                         fieldBloc: formBloc.select1),
//                 icon: const Icon(Icons.add),
//               ),
//               IconButton(
//                 onPressed: () =>
//                     formBloc.removeFieldBloc(
//                         fieldBloc: formBloc.select1),
//                 icon: const Icon(Icons.delete),
//               ),
//             ],
//           ),
//           CheckboxFieldBlocBuilder(
//             booleanFieldBloc: formBloc.boolean1,
//             body: const Text('CheckboxFieldBlocBuilder'),
//           ),
//           CheckboxFieldBlocBuilder(
//             booleanFieldBloc: formBloc.boolean1,
//             body: const Text('CheckboxFieldBlocBuilder trailing'),
//             controlAffinity:
//             FieldBlocBuilderControlAffinity.trailing,
//           ),
//           SliderFieldBlocBuilder(
//             inputFieldBloc: formBloc.double1,
//             divisions: 10,
//             labelBuilder: (context, value) =>
//                 value.toStringAsFixed(2),
//           ),
//           SliderFieldBlocBuilder(
//             inputFieldBloc: formBloc.double1,
//             divisions: 10,
//             labelBuilder: (context, value) =>
//                 value.toStringAsFixed(2),
//             activeColor: Colors.red,
//             inactiveColor: Colors.green,
//           ),
//           SliderFieldBlocBuilder(
//             inputFieldBloc: formBloc.double1,
//             divisions: 10,
//             labelBuilder: (context, value) =>
//                 value.toStringAsFixed(2),
//           ),
//           ChoiceChipFieldBlocBuilder<String>(
//             selectFieldBloc: formBloc.select2,
//             itemBuilder: (context, value) =>
//                 ChipFieldItem(
//                   label: Text(value),
//                 ),
//           ),
//           FilterChipFieldBlocBuilder<String>(
//             multiSelectFieldBloc: formBloc.multiSelect1,
//             itemBuilder: (context, value) =>
//                 ChipFieldItem(
//                   label: Text(value),
//                 ),
//           ),
//           BlocBuilder<InputFieldBloc<File?, String>,
//               InputFieldBlocState<File?, String>>(
//               bloc: formBloc.file,
//               builder: (context, state) {
//                 return Container();
//               })
//         ],
//       ),
//     ),
//   ),
// ),
//   }
//
//
// }

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.tag_faces, size: 100),
            const SizedBox(height: 10),
            const Text(
              'Success',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const PermissionScreen())),
              icon: const Icon(Icons.replay),
              label: const Text('AGAIN'),
            ),
          ],
        ),
      ),
    );
  }
}
