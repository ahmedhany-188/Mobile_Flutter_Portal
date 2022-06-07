import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/admin_requests_screen_bloc/business_card_request/business_card_cubit.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';
import 'package:intl/intl.dart';

class BusinessCardScreen extends StatefulWidget{

  static const routeName = "/business-account-screen";
  const BusinessCardScreen({Key? key}) : super(key: key);

  @override
  State<BusinessCardScreen> createState() => _BusinessCardScreen();

}


class _BusinessCardScreen extends State<BusinessCardScreen> {


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
        title: Text("Business Card"),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,


      drawer: MainDrawer(),

      body: BlocListener<BusinessCardCubit, BusinessCardInitial>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Success"),
              ),
            );
            print("---------..--" + state.successMessage.toString());
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

                    BlocBuilder<BusinessCardCubit, BusinessCardInitial>(
                      builder: (context, state) {
                        return TextField(
                          onChanged: (value) =>
                              context.read<BusinessCardCubit>()
                                  .nameCard(value),
                          // initialValue: state.userMobile.value,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            floatingLabelAlignment:
                            FloatingLabelAlignment.start,
                            labelText: 'Employee Name on Card',
                            prefixIcon: const Icon(
                                Icons.person),
                            errorText: state.employeeNameCard.invalid
                                ? 'invalid Name'
                                : null,
                          ),
                        );
                      },
                    ),

                    Container(height: 10),

                    BlocBuilder<BusinessCardCubit, BusinessCardInitial>(
                      builder: (context, state) {
                        return TextField(
                          onChanged: (value) =>
                              context.read<BusinessCardCubit>()
                                  .employeeMobile(value),
                          // initialValue: state.userMobile.value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            floatingLabelAlignment:
                            FloatingLabelAlignment.start,
                            labelText: 'Mobile',
                            prefixIcon: const Icon(
                                Icons.mobile_friendly),
                            errorText: state.employeeMobile.invalid
                                ? 'invalid Phone Number'
                                : null,
                          ),
                        );
                      },
                    ),

                    Container(height: 10),

                    BlocBuilder<BusinessCardCubit, BusinessCardInitial>(
                      builder: (context, state) {
                        return TextField(
                          onChanged: (value) =>
                              context.read<BusinessCardCubit>()
                                  .employeeExt(value),
                          // initialValue: state.userMobile.value,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            floatingLabelAlignment:
                            FloatingLabelAlignment.start,
                            labelText: 'Ext #',
                            prefixIcon: const Icon(
                                Icons.phone),
                          ),
                        );
                      },
                    ),

                    Container(height: 10),

                    BlocBuilder<BusinessCardCubit, BusinessCardInitial>(
                      builder: (context, state) {
                        return TextField(
                          onChanged: (value) =>
                              context.read<BusinessCardCubit>()
                                  .employeeFaxNO(value),
                          // initialValue: state.userMobile.value,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            floatingLabelAlignment:
                            FloatingLabelAlignment.start,
                            labelText: 'FAX NO',
                            prefixIcon: const Icon(
                                Icons.fax),
                          ),
                        );
                      },
                    ),

                    Container(height: 10),

                    BlocBuilder<BusinessCardCubit, BusinessCardInitial>(
                      builder: (context, state) {
                        return TextField(
                          onChanged: (value) =>
                              context.read<BusinessCardCubit>()
                                  .EemployeeComment(value),
                          // initialValue: state.userMobile.value,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            floatingLabelAlignment:
                            FloatingLabelAlignment.start,
                            labelText: 'Comments',
                            prefixIcon: const Icon(
                                Icons.comment),
                          ),
                        );
                      },
                    ),

                    Container(height: 10),

                    FloatingActionButton.extended(
                      onPressed: () {
                        context.read<BusinessCardCubit>()
                            .getSubmitBusinessCard(
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