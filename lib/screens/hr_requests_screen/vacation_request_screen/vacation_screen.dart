import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/hr_request_bloc/responsible_vacation_request/responsible_vacation_cubit.dart';
import 'package:hassanallamportalflutter/bloc/hr_request_bloc/vacation_request/vacation_cubit.dart';
import 'package:hassanallamportalflutter/data/models/contacts_related_models/contacts_data_from_api.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date_to.dart';
import '../../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../../constants/enums.dart';
import '../../../data/repositories/request_repository.dart';


class VacationScreen extends StatefulWidget {

  static const routeName = 'vacation-page';
  static const requestNoKey = 'request-No';
  static const requestDateAttendance = 'date-Attendance';
  static const requesterHRCode = 'requester-HRCode';

  const VacationScreen({Key? key, this.requestData}) : super(key: key);

  final  requestData;

  @override
  State<VacationScreen> createState() => _VacationScreenState();
}

class _VacationScreenState extends State<VacationScreen> {

  @override
  void dispose() {
    // TODO: implement dispose


    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final userMainData = context.select((AppBloc bloc) =>
    bloc.state.userData);

    final currentRequestData = widget.requestData;

    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<VacationCubit>(create: (vacationContext) =>
          currentRequestData[VacationScreen.requestNoKey] == "0" ?
          (VacationCubit(RequestRepository(userMainData))..getRequestData(requestStatus: RequestStatus.newRequest,date:currentRequestData[VacationScreen.requestDateAttendance]))
              :(VacationCubit(RequestRepository(userMainData))..getRequestData(requestStatus: RequestStatus.oldRequest, requestNo: currentRequestData[VacationScreen.requestNoKey],requesterHRCode: currentRequestData[VacationScreen.requesterHRCode]))),
            // ..getRequestData(currentRequestNo == null ?RequestStatus.newRequest : RequestStatus.oldRequest,currentRequestNo == null?"":currentRequestNo[VacationScreen.requestNoKey])),
          BlocProvider<ResponsibleVacationCubit>(
            lazy: false,
              create: (_) =>
              ResponsibleVacationCubit()
                ..fetchList()),
        ],
        child: BlocBuilder<VacationCubit,VacationInitial>(

            builder: (context,state) {
              print(currentRequestData);
              return Scaffold(
                appBar: AppBar(title: const Text('Vacation Request')),
                floatingActionButton: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[


                    if(state.requestStatus == RequestStatus.oldRequest &&
                        state.takeActionStatus == TakeActionStatus.takeAction )
                      FloatingActionButton.extended(
                      heroTag: null,
                      onPressed: () {
                        context.read<VacationCubit>()
                            .submitAction(true);
                      },
                      icon: const Icon(Icons.verified),
                      label: const Text('Accept'),
                    ),
                    const SizedBox(height: 12),
                    if(state.requestStatus ==
                        RequestStatus.oldRequest && state.takeActionStatus == TakeActionStatus.takeAction)FloatingActionButton.extended(
                      backgroundColor: Colors.red,
                      heroTag: null,
                      onPressed: () {

                      },
                      icon: const Icon(Icons.dangerous),

                      label: const Text('Reject'),
                    ),
                    const SizedBox(height: 12),
                    if(context
                        .read<VacationCubit>()
                        .state
                        .requestStatus == RequestStatus.newRequest)
                      FloatingActionButton.extended(
                        heroTag: null,
                        onPressed: () {
                          context.read<VacationCubit>()
                              .submitVacationRequest();
                        },
                        // formBloc.state.status.isValidated
                        //       ? () => formBloc.submitPermissionRequest()
                        //       : null,
                        // formBloc.submitPermissionRequest();

                        icon: const Icon(Icons.send),
                        label: const Text('SUBMIT'),
                      ),
                    const SizedBox(height: 12),
                  ],
                ),
                body: BlocListener<VacationCubit, VacationInitial>(
                  listener: (context, state) {
                    if (state.status.isSubmissionInProgress) {
                      LoadingDialog.show(context);
                    }
                    if (state.status.isSubmissionSuccess) {
                      LoadingDialog.hide(context);
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) =>
                              SuccessScreen(text: state.successMessage ??
                                  "Error Number",)));
                    }
                    if (state.status.isSubmissionFailure) {
                      LoadingDialog.hide(context);
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                                state.errorMessage ?? 'Request Failed'),
                          ),
                        );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                    child: Form(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            if(state.requestStatus == RequestStatus.oldRequest)Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: BlocBuilder<
                                  VacationCubit,
                                  VacationInitial>(

                                  builder: (context, state) {
                                    return Text(state.statusAction ?? "Pending",
                                      // style: TextStyle(decoration: BoxDecoration(
                                      //   // labelText: 'Request Date',
                                      //   errorText: state.requestDate.invalid
                                      //       ? 'invalid request date'
                                      //       : null,
                                      //   prefixIcon: const Icon(
                                      //       Icons.date_range),
                                      // ),),

                                    );
                                  }
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: BlocBuilder<
                                  VacationCubit,
                                  VacationInitial>(
                                  buildWhen: (previous, current) {
                                    return (previous.requestDate !=
                                        current.requestDate) ||
                                        previous.status != current.status;
                                  },
                                  builder: (context, state) {
                                    return TextFormField(
                                      key: UniqueKey(),
                                      initialValue: state.requestDate.value,
                                      enabled: false,
                                      decoration: InputDecoration(
                                        labelText: 'Request Date',
                                        errorText: state.requestDate.invalid
                                            ? 'invalid request date'
                                            : null,
                                        prefixIcon: const Icon(
                                            Icons.date_range),
                                      ),
                                    );
                                  }
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 5),
                                  labelText: 'Vacation Type',
                                  floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                                  prefixIcon: Icon(Icons.event),
                                ),
                                child: BlocBuilder<VacationCubit,
                                    VacationInitial>(
                                    buildWhen: (previous, current) {
                                      return (previous.vacationType !=
                                          current.vacationType);
                                    },
                                    builder: (context, state) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          RadioListTile<int>(
                                            value: 1,
                                            title: const Text("Annual"),
                                            groupValue: state.vacationType,
                                            onChanged: (vacationType) =>
                                                state.requestStatus == RequestStatus.newRequest ? context
                                                    .read<VacationCubit>()
                                                    .vacationTypeChanged(
                                                    vacationType ?? 1) : null,
                                          ),
                                          RadioListTile<int>(
                                            value: 2,
                                            // dense: true,
                                            title: const Text("Casual"),
                                            groupValue: state.vacationType,
                                            // radioClickState: (mstate) => mstate.value),
                                            onChanged: (vacationType) =>
                                            state.requestStatus == RequestStatus.newRequest ?  context
                                                    .read<VacationCubit>()
                                                    .vacationTypeChanged(
                                                    vacationType ?? 1) : null,
                                          ),
                                          RadioListTile<int>(
                                            value: 3,
                                            // dense: true,
                                            title: const Text(
                                                "Holiday Replacement"),
                                            groupValue: state.vacationType,
                                            // radioClickState: (mstate) => mstate.value),
                                            onChanged: (vacationType) =>
                                            state.requestStatus == RequestStatus.newRequest ? context
                                                    .read<VacationCubit>()
                                                    .vacationTypeChanged(
                                                    vacationType ?? 1) : null,
                                          ),
                                          RadioListTile<int>(
                                            value: 4,
                                            // dense: true,
                                            title: const Text("Maternity"),
                                            groupValue: state.vacationType,
                                            // radioClickState: (mstate) => mstate.value),
                                            onChanged: (vacationType) =>
                                            state.requestStatus == RequestStatus.newRequest ? context
                                                    .read<VacationCubit>()
                                                    .vacationTypeChanged(
                                                    vacationType ?? 1) : null,
                                          ),
                                          RadioListTile<int>(
                                            value: 5,
                                            // dense: true,
                                            title: const Text("Haj"),
                                            groupValue: state.vacationType,
                                            // radioClickState: (mstate) => mstate.value),
                                            onChanged: (vacationType) =>
                                            state.requestStatus == RequestStatus.newRequest ? context
                                                    .read<VacationCubit>()
                                                    .vacationTypeChanged(
                                                    vacationType ?? 1) : null,
                                          ),
                                        ],
                                      );
                                    }
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: BlocBuilder<
                                  VacationCubit,
                                  VacationInitial>(
                                // buildWhen: (previous, current) => previous.permissionDate != current.permissionDate,
                                  buildWhen: (previous, current) {
                                    return (previous.vacationFromDate !=
                                        current.vacationFromDate) ||
                                        previous.status != current.status;
                                  },
                                  builder: (context, state) {
                                    print(state.vacationFromDate.value);
                                    return TextFormField(
                                      key: UniqueKey(),
                                      initialValue: state.vacationFromDate.value,

                                      // onChanged: (vacationDate) =>
                                      //     context
                                      //         .read<VacationCubit>()
                                      //         .vacationFromDateChanged(
                                      //         context),
                                      readOnly: true,
                                      enabled: state.requestStatus == RequestStatus.newRequest ? true : false,

                                      decoration: InputDecoration(
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        labelText: 'Vacation From Date',
                                        errorText: state.vacationFromDate
                                            .invalid
                                            ? 'invalid permission date'
                                            : null,
                                        prefixIcon: const Icon(
                                            Icons.date_range_outlined),
                                      ),
                                      onTap: () {

                                        // vacationDateFromController.text =
                                        //     formattedDate;
                                        // (permissionDate) =>
                                        context
                                            .read<VacationCubit>()
                                            .vacationFromDateChanged(
                                            context);
                                      },
                                    );
                                  }
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: BlocBuilder<
                                  VacationCubit,
                                  VacationInitial>(
                                // buildWhen: (previous, current) => previous.permissionDate != current.permissionDate,
                                  buildWhen: (previous, current) {
                                    return (previous.vacationToDate !=
                                        current.vacationToDate) ||
                                        previous.status != current.status
                                        ||
                                        previous.vacationFromDate !=
                                            current.vacationFromDate;
                                  },
                                  builder: (context, state) {
                                    return TextFormField(
                                      key: UniqueKey(),
                                      initialValue: state.vacationToDate.value,
                                      readOnly: true,
                                      enabled: state.requestStatus == RequestStatus.newRequest ? true : false,
                                      decoration: InputDecoration(
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        labelText: 'Vacation To Date',
                                        errorText: state.vacationToDate.invalid ? (state.vacationToDate.error == DateToError.empty
                                            ? "Empty Date To or Date From"
                                            : (state.vacationToDate.error == DateToError.isBefore)
                                        ? "Date From must be before Date To" : null) : null,
                                        prefixIcon: const Icon(
                                            Icons.date_range_outlined),
                                      ),

                                      onTap: () {
                                        context
                                            .read<VacationCubit>()
                                            .vacationToDateChanged(
                                            context);
                                      },
                                    );
                                  }
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: BlocBuilder<
                                  VacationCubit,
                                  VacationInitial>(
                                  buildWhen: (previous, current) {
                                    // print(previous.vacationDuration);
                                    // print(current.vacationDuration);

                                    return (previous.vacationDuration !=
                                        current.vacationDuration);
                                  },
                                  builder: (context, state) {
                                    // print(
                                    //     "from Screen${state.vacationDuration}");
                                    return TextFormField(
                                      key: UniqueKey(),
                                      initialValue: state.vacationDuration,
                                      readOnly: true,
                                      enabled: state.requestStatus == RequestStatus.newRequest ? true : false,
                                      decoration: const InputDecoration(
                                        labelText: 'Vacation Duration',
                                        prefixIcon: Icon(
                                            Icons.date_range),
                                      ),
                                    );
                                  }
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: BlocBuilder<
                                  VacationCubit,
                                  VacationInitial>(
                                  buildWhen: (previous, current) {
                                    return (previous.responsiblePerson.name !=
                                        current.responsiblePerson.name);
                                  },
                                  builder: (context, state) {
                                    return TextFormField(
                                      key: UniqueKey(),
                                      initialValue: state.responsiblePerson
                                          .name,
                                      readOnly: true,
                                      enabled: state.requestStatus == RequestStatus.newRequest ? true : false,
                                      decoration: const InputDecoration(
                                        labelText: 'Responsible Person',
                                        prefixIcon: Icon(
                                            Icons.date_range),
                                      ),
                                      onTap: () {
                                        _showModal(context);
                                      },
                                    );
                                  }
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: BlocBuilder<
                                  VacationCubit,
                                  VacationInitial>(
                                  buildWhen: (previous, current) {
                                    return (previous.comment !=
                                        current.comment);
                                  },
                                  builder: (context, state) {
                                    return TextFormField(
                                      key: state.requestStatus == RequestStatus.oldRequest ? UniqueKey() : null,
                                      initialValue: state.requestStatus == RequestStatus.oldRequest ? state.comment :"",
                                      enabled: state.requestStatus == RequestStatus.newRequest ? true : false,
                                      onChanged: (commentValue) =>
                                          context
                                              .read<VacationCubit>()
                                              .commentChanged(commentValue),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              20.0),
                                        ),
                                        filled: true,
                                        hintStyle: TextStyle(
                                            color: Colors.grey[800]),
                                        labelText: "Add your comment",
                                        fillColor: Colors.white70,
                                        prefixIcon: const Icon(Icons.comment),
                                        enabled: true,
                                      ),
                                    );
                                  }
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              );
            }
        ),
      ),
    );
  }

  // final TextEditingController textController = TextEditingController();
  void _showModal(context) {
    final VacationCubit bloc = BlocProvider.of<VacationCubit>(context);
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: context,
        builder: (_) {
          return BlocProvider.value(
            value: BlocProvider.of<ResponsibleVacationCubit>(context),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return BlocBuilder<
                      ResponsibleVacationCubit,
                      ResponsibleVacationInitial>(
                    builder: (context, state) {
                      return DraggableScrollableSheet(
                          expand: false,
                          maxChildSize: 0.8,
                          snap: true,
                          builder:
                              (BuildContext context,
                              ScrollController scrollController) {
                            switch (state.status) {
                              case ResponsibleListStatus.failure:
                                return const Center(
                                    child: Text('Oops something went wrong!'));
                              case ResponsibleListStatus.success:
                                // print("Successsssssss");
                                return ItemView(items: state.items, scrollController: scrollController, bloc: bloc,);
                              case ResponsibleListStatus.successSearching:
                                print(state.tempItems.length);
                                return ItemView(items: state.tempItems, scrollController: scrollController, bloc: bloc,);
                              default:
                                return const Center(
                                    child: CircularProgressIndicator());
                            }
                          });
                    },
                  );
                }
            ),
          );
        });
  }

}

class ItemView extends StatelessWidget {
  const ItemView(
      {Key? key, required this.items, required this.scrollController, required this.bloc,})
      : super(key: key);

  final ScrollController scrollController;
  final List<ContactsDataFromApi> items;
  final VacationCubit bloc;

  @override
  Widget build(BuildContext context) {
    final ResponsibleVacationCubit responsibleVacationCubit = BlocProvider.of<
        ResponsibleVacationCubit>(context);
    return Column(children: [
      Padding(
          padding: const EdgeInsets.all(8),
          child: Row(children: [
            Expanded(
                child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8),
                      border: OutlineInputBorder(
                        borderRadius:
                        new BorderRadius.circular(15.0),
                        borderSide: new BorderSide(),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      responsibleVacationCubit.searchForContacts(value);
                    })),
            CloseButton(

              // icon: Icon(Icons.close),
              // color: Color(0xFF1F91E7),
                onPressed: () {
                  responsibleVacationCubit.clearAll();
                  Navigator.of(context).pop();
                }),
          ])),
      Expanded(
        child: ListView.separated(
            controller: scrollController,
            //5
            itemCount: (items != null &&
                items.length > 0)
                ? items.length
                : items.length,
            separatorBuilder: (context, int) {
              return const Divider();
            },
            itemBuilder: (context, index) {
              return InkWell(

                //6
                  child: (items != null &&
                      items.length > 0)
                      ? _showBottomSheetWithSearch(
                      index, items)
                      : _showBottomSheetWithSearch(
                      index, items),
                  onTap: () {
                    //7
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                          SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text((items.isNotEmpty)
                                  ? items[index].name ?? ""
                                  : items[index].name ?? "")));
                    // showSnackBar(
                    //     SnackBar(
                    //         behavior: SnackBarBehavior.floating,
                    //         content: Text((_tempListOfCities !=
                    //             null &&
                    //             _tempListOfCities.length > 0)
                    //             ? _tempListOfCities[index]
                    //             : _listOfCities[index])));

                    bloc.vacationResponsiblePersonChanged(items[index]);
                    responsibleVacationCubit.clearAll();
                    Navigator.of(context).pop();
                  });
            }),
      )
    ]);


    // return items.isEmpty
    //     ? const Center(child: Text('no content'))
    //     : ListView.builder(
    //   itemBuilder: (BuildContext context, int index) {
    //     return ItemTile(
    //       item: items[index],
    //       onDeletePressed: (id) {
    //         // context.read<ResponsibleVacationCubit>().deleteItem(id);
    //       },
    //     );
    //   },
    //   itemCount: items.length,
    // );
  }


  Widget _showBottomSheetWithSearch(int index,
      List<ContactsDataFromApi> listOfCities) {
    return Text(listOfCities[index].name ?? "",
        style: const TextStyle(color: Colors.black, fontSize: 16),
        textAlign: TextAlign.center);
  }
}


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
  const SuccessScreen({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.tag_faces, size: 100),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const VacationScreen())),
              icon: const Icon(Icons.replay),
              label: const Text('Create Another Permission Request'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
              label: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
