import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/get_direction_screen_bloc/get_direction_cubit.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/models/get_location_model/location_data.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date_to.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import '../../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../../bloc/hr_request_bloc/hr_request_export.dart';
import '../../../bloc/notification_bloc/cubit/user_notification_api_cubit.dart';
import '../../../constants/enums.dart';
import '../../../data/repositories/request_repository.dart';
import '../../../widgets/requester_data_widget/requester_data_widget.dart';
import '../../../widgets/success/success_request_widget.dart';

class BusinessMissionScreen extends StatefulWidget {

  static const routeName = 'business-mission-page';
  static const requestNoKey = 'request-No';
  static const requestDateAttendance = 'date-attendance';
  static const requesterHRCode = 'requester-HRCode';

  const BusinessMissionScreen({Key? key, this.requestData}) : super(key: key);

  final dynamic requestData;

@override
  State<BusinessMissionScreen> createState() => _BusinessMissionScreenState();
}

class _BusinessMissionScreenState extends State<BusinessMissionScreen> {
  @override
  Widget build(BuildContext context) {
    final userMainData = context.select((AppBloc bloc) =>
    bloc.state.userData);

    final currentRequestData = widget.requestData;

    return WillPopScope(
        onWillPop: () async {
          await EasyLoading.dismiss(animation: true);
          return true;
        },
      child: CustomBackground(
        child: CustomTheme(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<BusinessMissionCubit>(
                create: (businessMissionContext) =>
                currentRequestData[BusinessMissionScreen.requestNoKey] == "0" ?
                (BusinessMissionCubit(RequestRepository(userMainData))
                  ..getRequestData(requestStatus: RequestStatus.newRequest,
                      date: currentRequestData[BusinessMissionScreen
                          .requestDateAttendance])) :
                (BusinessMissionCubit(RequestRepository(userMainData))
                  ..getRequestData(requestStatus: RequestStatus.oldRequest,
                      requestNo: currentRequestData[BusinessMissionScreen
                          .requestNoKey],
                      requesterHRCode: currentRequestData[BusinessMissionScreen
                          .requesterHRCode],context: context)),
              ),
              // BlocProvider<GetDirectionCubit>.value(
              //   value: BlocProvider.of(context)
              //     ..getDirection(),),
            ],
            child: BlocBuilder<BusinessMissionCubit, BusinessMissionInitial>(
                builder: (context, state) {
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(title: Text(
                        "Business Mission ${state.requestStatus ==
                            RequestStatus.oldRequest
                            ? "#${currentRequestData[BusinessMissionScreen
                            .requestNoKey]}"
                            : "Request"}"),
                      backgroundColor: Colors.transparent,
                      elevation: 0,),
                    floatingActionButton: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        if(state.requestStatus ==
                            RequestStatus.oldRequest && state.takeActionStatus ==
                            TakeActionStatus.takeAction)FloatingActionButton
                            .extended(
                          heroTag: null,
                          onPressed: () {
                            context.read<BusinessMissionCubit>()
                                .submitAction(ActionValueStatus.accept,
                                currentRequestData[BusinessMissionScreen
                                    .requestNoKey]);
                          },
                          icon: const Icon(Icons.verified),
                          label: const Text('Accept'),
                        ),
                        const SizedBox(height: 12),
                        if(state.requestStatus ==
                            RequestStatus.oldRequest && state.takeActionStatus ==
                            TakeActionStatus.takeAction)FloatingActionButton
                            .extended(
                          backgroundColor: Colors.white,
                          heroTag: null,
                          onPressed: () {
                            context.read<BusinessMissionCubit>()
                                .submitAction(ActionValueStatus.reject,
                                currentRequestData[BusinessMissionScreen
                                    .requestNoKey]);
                          },
                          icon: const Icon(Icons.dangerous,
                            color: ConstantsColors.buttonColors,),

                          label: const Text('Reject', style: TextStyle(
                              color: ConstantsColors.buttonColors),),
                        ),
                        const SizedBox(height: 12),
                        if(state.requestStatus == RequestStatus.newRequest)
                          FloatingActionButton.extended(
                            heroTag: null,
                            onPressed: () {
                              context.read<BusinessMissionCubit>()
                                  .submitBusinessMissionRequest();
                            },
                            icon: const Icon(Icons.send),
                            label: const Text('SUBMIT'),
                          ),
                        const SizedBox(height: 12),
                      ],
                    ),
                    body: BlocListener<BusinessMissionCubit,
                        BusinessMissionInitial>(
                      listener: (context, state) {
                        if (state.status.isSubmissionInProgress) {
                          EasyLoading.show(status: 'Loading...',
                            maskType: EasyLoadingMaskType.black,
                            dismissOnTap: false,);
                        }
                        if (state.status.isSubmissionSuccess) {
                          // LoadingDialog.hide(context);
                          EasyLoading.dismiss(animation: true);
                          if (state.requestStatus == RequestStatus.newRequest) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) =>
                                    SuccessScreen(text: state.successMessage ??
                                        "Error Number",
                                      routName: BusinessMissionScreen.routeName,
                                      requestName: 'Business Mission',)));
                          }
                          else
                          if (state.requestStatus == RequestStatus.oldRequest) {
                            EasyLoading.showSuccess(state.successMessage ?? "")
                                .then((value) {
                              if (Navigator.of(context).canPop()) {
                                Navigator.of(context, rootNavigator: true).pop();
                              } else {
                                SystemNavigator.pop();
                              }
                            });
                            BlocProvider.of<UserNotificationApiCubit>(context)
                                .getNotifications();
                          }
                        }
                        if (state.status.isSubmissionFailure) {
                          EasyLoading.showError(
                              state.errorMessage ?? 'Request Failed');
                          // LoadingDialog.hide(context);
                          // ScaffoldMessenger.of(context)
                          //   ..hideCurrentSnackBar()
                          //   ..showSnackBar(
                          //     SnackBar(
                          //       content: Text(
                          //           state.errorMessage ?? 'Request Failed'),
                          //     ),
                          //   );
                        }
                        if (state.status.isValid) {
                          EasyLoading.dismiss(animation: true);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                        child: Form(
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                if(state.requestStatus ==
                                    RequestStatus.oldRequest)Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: BlocBuilder<
                                      BusinessMissionCubit,
                                      BusinessMissionInitial>(
                                      builder: (context, state) {
                                        return Text(
                                          state.statusAction ?? "Pending",
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


                                if(state.requestStatus ==
                                    RequestStatus.oldRequest &&
                                    state.takeActionStatus ==
                                        TakeActionStatus.takeAction)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    child: BlocBuilder<
                                        BusinessMissionCubit,
                                        BusinessMissionInitial>(
                                        buildWhen: (previous, current) {
                                          return (previous.requesterData !=
                                              current.requesterData);
                                        },
                                        builder: (context, state) {
                                          return RequesterDataWidget(
                                            requesterData: state.requesterData,
                                            actionComment: ActionCommentWidget(
                                                onChanged: (commentValue) =>
                                                    context
                                                        .read<
                                                        BusinessMissionCubit>()
                                                        .commentRequesterChanged(
                                                        commentValue)),);
                                        }
                                    ),
                                  ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: BlocBuilder<BusinessMissionCubit,
                                      BusinessMissionInitial>(
                                      buildWhen: (previous, current) {
                                        return (previous.requestDate !=
                                            current.requestDate);
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
                                      labelText: 'Mission Type',
                                      floatingLabelAlignment:
                                      FloatingLabelAlignment.start,
                                      prefixIcon: Icon(
                                        Icons.event, color: Colors.white70,),
                                    ),
                                    child: BlocBuilder<BusinessMissionCubit,
                                        BusinessMissionInitial>(
                                        buildWhen: (previous, current) {
                                          return (previous.missionType !=
                                              current.missionType);
                                        },
                                        builder: (context, state) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              RadioListTile<int>(
                                                activeColor: Colors.white,
                                                value: 1,
                                                title: Text("Meeting"),
                                                groupValue: state.missionType,
                                                onChanged: (permissionType) =>
                                                state.requestStatus ==
                                                    RequestStatus.newRequest
                                                    ? context
                                                    .read<
                                                    BusinessMissionCubit>()
                                                    .missionTypeChanged(
                                                    permissionType??0)
                                                    : null,
                                              ),
                                              RadioListTile<int>(
                                                activeColor: Colors.white,
                                                value: 2,
                                                title: Text("Site Visit"),
                                                groupValue: state.missionType,
                                                onChanged: (missionType) =>
                                                state.requestStatus ==
                                                    RequestStatus.newRequest
                                                    ? context
                                                    .read<
                                                    BusinessMissionCubit>()
                                                    .missionTypeChanged(
                                                    missionType??0)
                                                    : null,
                                              ),
                                              RadioListTile<int>(
                                                activeColor: Colors.white,
                                                value: 3,
                                                title: Text("Training"),
                                                groupValue: state.missionType,
                                                onChanged: (missionType) =>
                                                state.requestStatus ==
                                                    RequestStatus.newRequest
                                                    ? context
                                                    .read<
                                                    BusinessMissionCubit>()
                                                    .missionTypeChanged(
                                                    missionType??0)
                                                    : null,
                                              ),
                                              RadioListTile<int>(
                                                activeColor: Colors.white,
                                                value: 4,
                                                title: const Text("Others"),
                                                groupValue: state.missionType,
                                                onChanged: (missionType) =>
                                                state.requestStatus ==
                                                    RequestStatus.newRequest
                                                    ? context
                                                    .read<
                                                    BusinessMissionCubit>()
                                                    .missionTypeChanged(
                                                    missionType??0)
                                                    : null,
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
                                  child: BlocBuilder<BusinessMissionCubit,
                                      BusinessMissionInitial>(
                                      buildWhen: (previous, current) {
                                        return (previous.missionLocation
                                            !=
                                            current.missionLocation) ||
                                            (previous.missionType !=
                                                current.missionType);
                                      },
                                      builder: (context, state) {
                                        // print(state.missionLocation);
                                        return TextFormField(
                                          key: UniqueKey(),
                                          initialValue: state.missionLocation
                                              .value
                                              .projectName?.toTitleCase(),
                                          readOnly: true,
                                          enabled: state.requestStatus ==
                                              RequestStatus.newRequest
                                              ? true
                                              : false,
                                          decoration: InputDecoration(
                                            labelText: 'Mission Location',
                                            prefixIcon: const Icon(
                                              Icons.location_on,
                                              color: Colors.white70,),
                                            errorText: state.missionLocation
                                                .invalid
                                                ? 'Need to add Location'
                                                : null,
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
                                      BusinessMissionCubit,
                                      BusinessMissionInitial>(
                                    // buildWhen: (previous, current) => previous.permissionDate != current.permissionDate,
                                      buildWhen: (previous, current) {
                                        return (previous.dateFrom !=
                                            current.dateFrom) ||
                                            previous.status != current.status;
                                      },
                                      builder: (context, state) {
                                        // print(state.dateFrom.value);
                                        return TextFormField(
                                          key: UniqueKey(),
                                          initialValue: state.dateFrom.value,
                                          onChanged: (vacationDate) =>
                                              context
                                                  .read<BusinessMissionCubit>()
                                                  .businessDateFromChanged(
                                                  context),
                                          readOnly: true,
                                          enabled: state.requestStatus ==
                                              RequestStatus.newRequest
                                              ? true
                                              : false,
                                          decoration: InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment.start,
                                            labelText: 'Mission From Date',
                                            errorText: state.dateFrom
                                                .invalid
                                                ? 'invalid date from'
                                                : null,
                                            prefixIcon: const Icon(
                                              Icons.date_range_outlined,
                                              color: Colors.white70,),
                                          ),
                                          onTap: () {
                                            context
                                                .read<BusinessMissionCubit>()
                                                .businessDateFromChanged(
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
                                      BusinessMissionCubit,
                                      BusinessMissionInitial>(
                                    // buildWhen: (previous, current) => previous.permissionDate != current.permissionDate,
                                      buildWhen: (previous, current) {
                                        return (previous.dateTo !=
                                            current.dateTo) ||
                                            previous.status != current.status ||
                                            previous.dateFrom !=
                                                current.dateFrom;
                                      },
                                      builder: (context, state) {
                                        return TextFormField(
                                          key: UniqueKey(),
                                          initialValue: state.dateTo.value,
                                          readOnly: true,
                                          enabled: state.requestStatus ==
                                              RequestStatus.newRequest
                                              ? true
                                              : false,
                                          decoration: InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment.start,
                                            labelText: 'Mission To Date',
                                            errorText: state.dateTo.invalid
                                                ? (state
                                                .dateTo.error == DateToError.empty
                                                ? "Empty Date To or Date From"
                                                : (state.dateTo.error ==
                                                DateToError.isBefore)
                                                ? "Date From must be before Date To"
                                                : null)
                                                : null,
                                            prefixIcon: const Icon(
                                              Icons.date_range_outlined,
                                              color: Colors.white70,),
                                          ),
                                          onTap: () {
                                            context
                                                .read<BusinessMissionCubit>()
                                                .businessToDateChanged(
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
                                      BusinessMissionCubit,
                                      BusinessMissionInitial>(
                                      buildWhen: (previous, current) =>
                                      previous.timeFrom !=
                                          current.timeFrom,
                                      builder: (context, state) {
                                        return TextFormField(
                                          key: UniqueKey(),
                                          initialValue: state.timeFrom.value,
                                          readOnly: true,
                                          enabled: state.requestStatus ==
                                              RequestStatus.newRequest
                                              ? true
                                              : false,
                                          decoration: InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment.start,
                                            labelText: 'Time From',
                                            errorText: state.timeFrom.invalid
                                                ? 'invalid permission time'
                                                : null,
                                            prefixIcon: const Icon(
                                              Icons.access_time,
                                              color: Colors.white70,),
                                          ),
                                          onTap: () async {
                                            // if (!widget.objectValidation) {
                                            context
                                                .read<BusinessMissionCubit>()
                                                .businessTimeFromChanged(
                                                context);
                                            // }
                                          },
                                        );
                                      }
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: BlocBuilder<
                                      BusinessMissionCubit,
                                      BusinessMissionInitial>(
                                      buildWhen: (previous, current) =>
                                      previous.timeTo !=
                                          current.timeTo,
                                      builder: (context, state) {
                                        return TextFormField(
                                          key: UniqueKey(),
                                          initialValue: state.timeTo.value,
                                          readOnly: true,
                                          enabled: state.requestStatus ==
                                              RequestStatus.newRequest
                                              ? true
                                              : false,
                                          decoration: InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment.start,
                                            labelText: 'Time To',
                                            errorText: state.timeTo.invalid
                                                ? 'invalid time'
                                                : null,
                                            prefixIcon: const Icon(
                                              Icons.access_time,
                                              color: Colors.white70,),
                                          ),
                                          onTap: () async {
                                            context
                                                .read<BusinessMissionCubit>()
                                                .businessTimeToChanged(
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
                                      BusinessMissionCubit,
                                      BusinessMissionInitial>(
                                      buildWhen: (previous, current) =>
                                      previous.comment !=
                                          current.comment,
                                      builder: (context, state) {
                                        return TextFormField(
                                          key: state.requestStatus ==
                                              RequestStatus.oldRequest
                                              ? UniqueKey()
                                              : null,
                                          initialValue: state.requestStatus ==
                                              RequestStatus.oldRequest ? state
                                              .comment.value : "",
                                          enabled: state.requestStatus ==
                                              RequestStatus.newRequest
                                              ? true
                                              : false,
                                          onChanged: (commentValue) =>
                                              context
                                                  .read<BusinessMissionCubit>()
                                                  .commentChanged(commentValue),
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          decoration: InputDecoration(
                                            errorText: state.comment.invalid
                                                ? 'Justify your request with more than 20 character'
                                                : null,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(
                                                  20.0),
                                            ),
                                            filled: true,
                                            labelText: "Add your comment",
                                            prefixIcon: const Icon(Icons.comment,
                                              color: Colors.white70,),
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
        ),
      ),
    );
  }
  void _showModal(context) {
    final BusinessMissionCubit bloc = BlocProvider.of<BusinessMissionCubit>(context);
    showModalBottomSheet(
        backgroundColor: const Color(0xff0F3C55),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: context,
        builder: (_) {
          return BlocProvider.value(
            value: BlocProvider.of<GetDirectionCubit>(context),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return BlocBuilder<
                      GetDirectionCubit,
                      GetDirectionInitial>(
                    builder: (context, state) {
                      return DraggableScrollableSheet(
                          expand: false,
                          maxChildSize: 0.8,
                          snap: true,
                          builder:
                              (BuildContext context,
                              ScrollController scrollController) {
                            switch (state.status) {
                              case GetDirectionStatus.failure:
                                return const Center(
                                    child: Text('Something went wrong!',
                                      style: TextStyle(color: Colors.white),));
                              case GetDirectionStatus.success:
                              print("Successsssssss");
                                return ItemView(items: state.items,
                                  scrollController: scrollController,
                                  bloc: bloc,);
                              case GetDirectionStatus.successSearching:
                                print("Successsssssss Searching");
                                if (kDebugMode) {
                                  print(state.tempItems.length);
                                }
                                return ItemView(items: state.tempItems,
                                  scrollController: scrollController,
                                  bloc: bloc,);
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
        }).then((value) => BlocProvider.of<GetDirectionCubit>(context).clearAll());
  }
}
class CustomInputDecoratorRequests extends StatelessWidget {
  const CustomInputDecoratorRequests({
    Key? key, this.child, required this.labelText,
  }) : super(key: key);

  final Widget? child;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 0, vertical: 5),
          labelText: labelText,
          prefixIconColor: Colors.white70,
          floatingLabelAlignment:
          FloatingLabelAlignment.start,
          prefixIcon: const Icon(Icons.event, color: Colors.white70),
        ),
        child: child
    );
  }
}

class ItemView extends StatelessWidget {
  const ItemView(
      {Key? key, required this.items, required this.scrollController, required this.bloc,})
      : super(key: key);

  final ScrollController scrollController;
  final List<LocationData> items;
  final BusinessMissionCubit bloc;

  @override
  Widget build(BuildContext context) {
    final GetDirectionCubit getDirectionCubit = BlocProvider.of<
        GetDirectionCubit>(context);
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
                        BorderRadius.circular(15.0),
                        borderSide: const BorderSide(),
                      ),
                      hintText: "Search",

                      prefixIcon: const Icon(
                        Icons.search, color: Colors.white60,),
                    ),
                    onChanged: (value) {
                      getDirectionCubit.searchForLocations(value);
                    })),
            CloseButton(
                color: Colors.white60,

                // icon: Icon(Icons.close),
                // color: Color(0xFF1F91E7),
                onPressed: () {
                  getDirectionCubit.clearAll();
                  Navigator.of(context).pop();
                }),
          ])),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView.separated(
              controller: scrollController,
              //5
              itemCount: (items.isNotEmpty)
                  ? items.length
                  : items.length,
              separatorBuilder: (context, int) {
                return const SizedBox(height: 2,);
              },
              itemBuilder: (context, index) {
                return InkWell(


                  //6
                    child: (items.isNotEmpty)
                        ? _showBottomSheetWithSearch(
                        index, items)
                        : _showBottomSheetWithSearch(
                        index, items),
                    onTap: () {
                      //7
                      // ScaffoldMessenger.of(context)
                      //   ..hideCurrentSnackBar()
                      //   ..showSnackBar(
                      //       SnackBar(
                      //           // behavior: SnackBarBehavior.floating,
                      //           content: Text((items.isNotEmpty)
                      //               ? items[index].name ?? ""
                      //               : items[index].name ?? "")));
                      // showSnackBar(
                      //     SnackBar(
                      //         behavior: SnackBarBehavior.floating,
                      //         content: Text((_tempListOfCities !=
                      //             null &&
                      //             _tempListOfCities.length > 0)
                      //             ? _tempListOfCities[index]
                      //             : _listOfCities[index])));

                      bloc.getLocationChanged(items[index]);
                      getDirectionCubit.clearAll();
                      Navigator.of(context).pop();
                    });
              }),
        ),
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
      List<LocationData> locations) {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(locations[index].projectName?.toTitleCase() ?? "",
                textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
            Text(locations[index].departmentName?.toTitleCase() ?? "",
                textAlign: TextAlign.left,style: const TextStyle(fontSize: 12),),
          ],
        ),
      ),
    );
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



