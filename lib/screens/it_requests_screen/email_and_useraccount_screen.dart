import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/it_request_bloc/email_useracount_request/email_useraccount_cubit.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';
import 'package:hassanallamportalflutter/widgets/filters/multi_selection_chips_filters.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';


class EmailAndUserAccountScreen  extends StatefulWidget{
  static const routeName = "/email-user-account-screen";
  const EmailAndUserAccountScreen({Key? key}) : super(key: key);

  @override
  State<EmailAndUserAccountScreen> createState() => _EmailAndUserAccountScreen();
}

class _EmailAndUserAccountScreen extends State<EmailAndUserAccountScreen> {

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery
        .of(context)
        .size;
    final user = context.select((AppBloc bloc) => bloc.state.userData);
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text("User Account"),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,

      drawer: MainDrawer(),

      body: BlocListener<EmailUseraccountCubit, EmailUseraccountInitial>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Success"),
              ),
            );
            print("---------..--"+state.successMessage.toString());
          } else if (state.status.isSubmissionInProgress) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Loading"),
              ),
            );
          }
          else if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage.toString()),
              ),
            );
          }
        },

        child: Container(

          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              child: SingleChildScrollView(
                child: Column(

                  children: [

                    TextFormField(
                      initialValue: formattedDate,
                      key: UniqueKey(),
                      readOnly: true,
                      decoration: InputDecoration(
                        floatingLabelAlignment:
                        FloatingLabelAlignment.start,
                        labelText: 'Request Date',
                        prefixIcon: const Icon(
                            Icons.calendar_today),
                      ),
                    ),

                    Container(height: 10),
                    Text("Request Type"),

                    Container(height: 10),

                    BlocBuilder<EmailUseraccountCubit,
                        EmailUseraccountInitial>(
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            mainAxisAlignment: MainAxisAlignment
                                .center,
                            children: [
                              RadioListTile<int>(
                                value: 1,
                                title: Text("Create"),
                                groupValue: state.requestType,
                                onChanged: (permissionType) =>
                                {
                                  context.read<EmailUseraccountCubit>()
                                      .accesRightChanged(1),
                                },
                              ),
                              RadioListTile<int>(
                                value: 2,
                                // dense: true,
                                title: Text("Disable"),
                                groupValue: state.requestType,
                                // radioClickState: (mstate) => mstate.value),
                                onChanged: (permissionType) =>
                                {
                                  context.read<EmailUseraccountCubit>()
                                      .accesRightChanged(2),
                                },
                              ),
                            ],
                          );
                        }
                    ),

                    Container(height: 10),

                    TextFormField(
                      initialValue: user.user!.userHRCode,
                      key: UniqueKey(),
                      readOnly: true,
                      decoration: InputDecoration(
                        floatingLabelAlignment:
                        FloatingLabelAlignment.start,
                        prefixIcon: const Icon(
                            Icons.qr_code),
                        labelText: 'Hr Code',
                      ),
                    ),

                    Container(height: 10),

                    TextFormField(
                      initialValue: user.employeeData!.name,
                      key: UniqueKey(),
                      readOnly: true,
                      decoration: InputDecoration(
                        floatingLabelAlignment:
                        FloatingLabelAlignment.start,
                        labelText: 'Full Name',
                        prefixIcon: const Icon(
                            Icons.person),
                      ),
                    ),

                    Container(height: 10),

                    TextFormField(
                      initialValue: user.employeeData!.titleName,
                      key: UniqueKey(),
                      readOnly: true,
                      decoration: InputDecoration(
                        floatingLabelAlignment:
                        FloatingLabelAlignment.start,
                        labelText: 'Title',
                        prefixIcon: const Icon(
                            Icons.desk_outlined),
                      ),
                    ),

                    Container(height: 10),

                    TextFormField(
                      initialValue: user.employeeData!.companyName,
                      key: UniqueKey(),
                      readOnly: true,
                      decoration: InputDecoration(
                        floatingLabelAlignment:
                        FloatingLabelAlignment.start,
                        labelText: 'Location',
                        prefixIcon: const Icon(
                            Icons.business_center),
                      ),
                    ),

                    Container(height: 10),

                    BlocBuilder<EmailUseraccountCubit, EmailUseraccountInitial>(
                      builder: (context, state) {
                        return TextField(
                          onChanged: (phoneValue) =>
                              context.read<EmailUseraccountCubit>()
                                  .phoneNumberChanged(phoneValue),
                          // initialValue: state.userMobile.value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            floatingLabelAlignment:
                            FloatingLabelAlignment.start,
                            labelText: 'Mobile',
                            prefixIcon: const Icon(
                                Icons.mobile_friendly),
                            errorText: state.userMobile.invalid
                                ? 'invalid Phone Number'
                                : null,
                          ),
                        );
                      },
                    ),

                    Container(height: 10),

                    Text("Account Type"),

                    Container(height: 10),


                    BlocBuilder<EmailUseraccountCubit, EmailUseraccountInitial>(
                      builder: (context, state) {
                        return Card(
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Text(
                                'Email Account ',
                                style: TextStyle(fontSize: 17.0),
                              ), //Text
                              SizedBox(width: 10), //SizedBox
                              /** Checkbox Widget **/
                              Checkbox(
                                value: state.accountType,
                                onChanged: (bool? value) {
                                  context.read<EmailUseraccountCubit>()
                                      .getEmailValue(value!);
                                },
                              ), //Checkbox
                            ], //<Widget>[]
                          ),
                        );
                      },),


                    Container(height: 10,),

                    FloatingActionButton.extended(
                      onPressed: () {
                        context.read<EmailUseraccountCubit>()
                            .getSubmitEmailAndUserAccount(
                         user , formattedDate,);
                      },
                      label: const Text('Submit', style: TextStyle(
                          color: Colors.black
                      )),
                      icon: const Icon(
                          Icons.thumb_up_alt_outlined, color: Colors.black),
                      backgroundColor: Colors.white,),

                    Container(height: 10,),

                  ],
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }
}