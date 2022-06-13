import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/it_request_bloc/email_useracount_request/email_useraccount_cubit.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/email_user_form_model.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';
import 'package:intl/intl.dart';


class EmailAndUserAccountScreen  extends StatefulWidget{
  static const routeName = "/email-user-account-screen";
  const EmailAndUserAccountScreen({Key? key, required this.emailUserAccount,
    required this.objectValidation}) : super(key: key);

  final bool objectValidation;
  final EmailUserFormModel emailUserAccount;

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
     var mobileController = TextEditingController();

    if (widget.objectValidation) {
      mobileController.text = widget.emailUserAccount.userMobile.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Account"),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,

      drawer: MainDrawer(),

      body: BlocListener<EmailUserAccountCubit, EmailUserAccountInitial>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Success"),
              ),
            );
          } else if (state.status.isSubmissionInProgress) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
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
                    decoration: const InputDecoration(
                      floatingLabelAlignment:
                      FloatingLabelAlignment.start,
                      labelText: 'Request Date',
                      prefixIcon: Icon(
                          Icons.calendar_today),
                    ),
                  ),

                  Container(height: 10),
                  const Text("Request Type"),

                  Container(height: 10),

                  BlocBuilder<EmailUserAccountCubit,
                      EmailUserAccountInitial>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start,
                          mainAxisAlignment: MainAxisAlignment
                              .center,
                          children: [
                            RadioListTile<int>(
                              value: 1,
                              title: const Text("Create"),
                              groupValue: (widget.objectValidation)
                                  ? null
                                  : state.requestType,
                              onChanged: (permissionType) =>
                              {
                                context.read<EmailUserAccountCubit>()
                                    .accesRightChanged(1),
                              },
                              selected: (widget.emailUserAccount
                                  .requestType == 1) ? true : false,
                            ),
                            RadioListTile<int>(
                              value: 2,
                              title: const Text("Disable"),
                              groupValue: (widget.objectValidation)
                                  ? null
                                  : state.requestType,
                              onChanged: (permissionType) =>
                              {
                                context.read<EmailUserAccountCubit>()
                                    .accesRightChanged(2),
                              },
                              selected: (widget.emailUserAccount
                                  .requestType == 2) ? true : false,
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
                    decoration: const InputDecoration(
                      floatingLabelAlignment:
                      FloatingLabelAlignment.start,
                      prefixIcon: Icon(
                          Icons.qr_code),
                      labelText: 'Hr Code',
                    ),
                  ),

                  Container(height: 10),

                  TextFormField(
                    initialValue: user.employeeData!.name,
                    key: UniqueKey(),
                    readOnly: true,
                    decoration: const InputDecoration(
                      floatingLabelAlignment:
                      FloatingLabelAlignment.start,
                      labelText: 'Full Name',
                      prefixIcon: Icon(
                          Icons.person),
                    ),
                  ),

                  Container(height: 10),

                  TextFormField(
                    initialValue: user.employeeData!.titleName,
                    key: UniqueKey(),
                    readOnly: true,
                    decoration: const InputDecoration(
                      floatingLabelAlignment:
                      FloatingLabelAlignment.start,
                      labelText: 'Title',
                      prefixIcon: Icon(
                          Icons.desk_outlined),
                    ),
                  ),

                  Container(height: 10),

                  TextFormField(
                    initialValue: user.employeeData!.companyName,
                    key: UniqueKey(),
                    readOnly: true,
                    decoration: const InputDecoration(
                      floatingLabelAlignment:
                      FloatingLabelAlignment.start,
                      labelText: 'Location',
                      prefixIcon: Icon(
                          Icons.business_center),
                    ),
                  ),

                  Container(height: 10),

                  BlocBuilder<EmailUserAccountCubit, EmailUserAccountInitial>(
                    builder: (context, state) {

                      return TextField(

                        controller:  (widget.objectValidation)   ? mobileController : null,

                        onChanged: (phoneValue) =>
                        {
                          context.read<EmailUserAccountCubit>()
                              .phoneNumberChanged(phoneValue),
                        },

                        keyboardType: TextInputType.phone,
                        enabled: (widget.objectValidation)   ? false : true,
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

                  const Text("Account Type"),

                  Container(height: 10),


                  BlocBuilder<EmailUserAccountCubit, EmailUserAccountInitial>(
                    builder: (context, state) {
                      return Card(
                        child: Row(
                          children: <Widget>[
                            const SizedBox(width: 10),
                            const Text(
                              'Email Account ',
                              style: TextStyle(fontSize: 17.0),
                            ), //Text
                            const SizedBox(width: 10), //SizedBox
                            /** Checkbox Widget **/
                            Checkbox(
                              value: (widget.objectValidation) ? widget
                                  .emailUserAccount.accountType : state
                                  .accountType,
                              onChanged: (bool? value) {
                                if (!widget.objectValidation) {
                                  context.read<EmailUserAccountCubit>()
                                      .getEmailValue(value!);
                                }
                              },
                            ), //Checkbox
                          ], //<Widget>[]
                        ),
                      );
                    },),


                  Container(height: 10,),

                  FloatingActionButton.extended(
                    onPressed: () {
                      context.read<EmailUserAccountCubit>()
                          .getSubmitEmailAndUserAccount(
                        user, formattedDate,);
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
    );
  }
}