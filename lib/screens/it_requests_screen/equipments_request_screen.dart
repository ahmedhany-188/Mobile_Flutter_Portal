import 'package:authentication_repository/authentication_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formz/formz.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../bloc/notification_bloc/cubit/user_notification_api_cubit.dart';
import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../constants/request_service_id.dart';
import '../../data/data_providers/general_dio/general_dio.dart';
import '../../data/helpers/download_pdf.dart';
import '../../widgets/background/custom_background.dart';
import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../constants/url_links.dart';
import '../../data/repositories/request_repository.dart';
import '../../gen/assets.gen.dart';
import '../../widgets/requester_data_widget/requested_status.dart';
import '../../widgets/requester_data_widget/requester_data_widget.dart';
import '../../widgets/success/success_request_widget.dart';
import '../../bloc/contacts_screen_bloc/contacts_cubit.dart';
import '../../data/models/contacts_related_models/contacts_data_from_api.dart';
import '../../data/models/it_requests_form_models/equipments_models/departments_model.dart';
import '../../bloc/it_request_bloc/equipments_request/equipments_cubit/equipments_cubit.dart';
import '../../data/models/it_requests_form_models/equipments_models/business_unit_model.dart';
import '../../data/models/it_requests_form_models/equipments_models/equipments_items_model.dart';
import '../../data/models/it_requests_form_models/equipments_models/equipments_location_model.dart';
import '../../data/models/it_requests_form_models/equipments_models/selected_equipments_model.dart';
import '../../bloc/it_request_bloc/equipments_request/equipments_items_cubit/equipments_items_cubit.dart';
import '../myprofile_screen/profile_screen_direct_manager.dart';

class EquipmentsRequestScreen extends StatelessWidget {
  static const routeName = 'request-equipments-screen';
  static const requestNoKey = 'request-No';
  static const requesterHrCode = 'requester-HRCode';

  EquipmentsRequestScreen({Key? key, this.requestData}) : super(key: key);

  final dynamic requestData;

  final GlobalKey<DropdownSearchState<EquipmentsItemModel>> itemFormKey =
      GlobalKey();

  final TextEditingController controller = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  final GlobalKey<DropdownSearchState<ContactsDataFromApi>> ownerFormKey =
      GlobalKey();

  final GlobalKey<DropdownSearchState<String?>> requestForFormKey = GlobalKey();
  final GlobalKey<DropdownSearchState<BusinessUnitModel>> businessUnitFormKey =
      GlobalKey();
  final GlobalKey<DropdownSearchState<EquipmentsLocationModel>>
      locationFormKey = GlobalKey();
  final GlobalKey<DropdownSearchState<DepartmentsModel>> departmentFormKey =
      GlobalKey();

  @override
  Widget build(BuildContext context) {
    controller.text = '1';
    final user = context.select((AppBloc bloc) => bloc.state.userData);
    double shake(double animation) =>
        2 * (0.5 - (0.5 - Curves.ease.transform(animation)).abs());
    return WillPopScope(
      onWillPop: () async {
        await EasyLoading.dismiss(animation: true);
        return true;
      },
      child: BlocProvider<EquipmentsCubit>(
        create: (context) =>
            requestData[EquipmentsRequestScreen.requestNoKey] == "0"
                ? (EquipmentsCubit(RequestRepository(user))
                  ..getRequestData(requestStatus: RequestStatus.newRequest)
                  ..getAll())
                : (EquipmentsCubit(RequestRepository(user))
                  ..getRequestData(
                    requestStatus: RequestStatus.oldRequest,
                    requesterHRCode:
                        requestData[EquipmentsRequestScreen.requesterHrCode],
                    requestNo:
                        requestData[EquipmentsRequestScreen.requestNoKey],
                  )),
        child: CustomBackground(
          child: CustomTheme(
            child: BlocBuilder<EquipmentsCubit, EquipmentsCubitStates>(
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                        'Equipment ${(requestData[EquipmentsRequestScreen.requestNoKey] == "0") ? 'request' : "#${requestData[EquipmentsRequestScreen.requestNoKey]}"}'),
                    actions: [
                      if (EquipmentsCubit.get(context).state.requestStatus ==
                          RequestStatus.oldRequest)
                        BlocBuilder<EquipmentsCubit, EquipmentsCubitStates>(
                          builder: (context, state) {
                            return SizedBox(
                                width: 60,
                                child:
                                    myRequestStatusString(state.statusAction));
                          },
                        ),
                    ],
                  ),
                  resizeToAvoidBottomInset: false,
                  body: BlocListener<EquipmentsCubit, EquipmentsCubitStates>(
                    listener: (context, state) {
                      if (state.status.isSubmissionInProgress) {
                        EasyLoading.show(
                          status: 'Loading...',
                          maskType: EasyLoadingMaskType.black,
                          dismissOnTap: false,
                        );
                      }
                      if (state.status.isSubmissionSuccess) {
                        // LoadingDialog.hide(context);
                        EasyLoading.dismiss(animation: true);
                        if (state.requestStatus == RequestStatus.newRequest) {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (_) => SuccessScreen(
                                        text: state.successMessage ??
                                            "Error Number",
                                        routName:
                                            EquipmentsRequestScreen.routeName,
                                        requestName: 'Equipment Request',
                                      )));
                        } else if (state.requestStatus ==
                            RequestStatus.oldRequest) {
                          EasyLoading.showSuccess(state.successMessage ?? "")
                              .then((value) {
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context, rootNavigator: true).pop();
                            } else {
                              SystemNavigator.pop();
                            }
                          });
                          BlocProvider.of<UserNotificationApiCubit>(context)
                              .getNotifications(user);
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
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                        child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // if (state.requestStatus ==
                              //     RequestStatus.oldRequest)
                              //   SizedBox(
                              //     child: Text(state.statusAction ?? ''),
                              //   ),
                              BlocBuilder<EquipmentsCubit,
                                      EquipmentsCubitStates>(
                                  buildWhen: (previous, current) {
                                return (previous.requestDate !=
                                        current.requestDate) ||
                                    previous.status != current.status;
                              }, builder: (context, state) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    key: UniqueKey(),
                                    initialValue: (state.requestStatus ==
                                            RequestStatus.oldRequest)
                                        ? ((requestData['date'] != null)
                                            ? (DateFormat('EEEE dd-MM-yyyy')
                                                .format(DateTime.parse(
                                                    requestData['date'])))
                                            : '')
                                        : state.requestDate?.value,
                                    enabled: false,
                                    decoration: const InputDecoration(
                                      labelText: 'Request Date',
                                      prefixIcon: Icon(Icons.date_range),
                                    ),
                                  ),
                                );
                              }),
                              if (EquipmentsCubit.get(context)
                                      .state
                                      .requestStatus ==
                                  RequestStatus.newRequest)
                                BlocBuilder<EquipmentsCubit,
                                    EquipmentsCubitStates>(
                                  builder: (context, state) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            border: Border.all(
                                                color: Colors.white)),
                                        // padding: const EdgeInsets.all(8),
                                        child: OutlinedButton.icon(
                                          onPressed: () {
                                            showAddRequestBottomSheet(context);
                                          },
                                          style: ElevatedButton.styleFrom(),
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            'Add Item',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    );
                                    // TweenAnimationBuilder<double>(
                                    //   duration: const Duration(milliseconds: 1000),
                                    //   tween: Tween(begin: 0.5, end: 0.0),
                                    //   builder: (context, animation, child) =>
                                    //       Transform.translate(
                                    //         offset: (state.requestStatus ==
                                    //             RequestStatus.oldRequest)
                                    //             ? const Offset(0, 0)
                                    //             : Offset(-20 * shake(animation), 0),
                                    //         child: TextButton.icon(
                                    //           onPressed: () {
                                    //             showAddRequestBottomSheet(context);
                                    //           },
                                    //           icon: const Icon(
                                    //             Icons.add,
                                    //             color: Colors.white,
                                    //           ),
                                    //           label: const Text(
                                    //             'Item',
                                    //             style: TextStyle(color: Colors.white),
                                    //           ),
                                    //         ),
                                    //       ),
                                    // );
                                  },
                                ),
                              if (state.requestStatus ==
                                      RequestStatus.oldRequest &&
                                  state.takeActionStatus ==
                                      TakeActionStatus.takeAction)
                                BlocBuilder<EquipmentsCubit,
                                        EquipmentsCubitStates>(
                                    buildWhen: (previous, current) {
                                  return (previous.requesterData !=
                                      current.requesterData);
                                }, builder: (context, state) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RequesterDataWidget(
                                      requestServiceId:
                                          RequestServiceID.equipmentServiceID,
                                      requesterData: state.requesterData,
                                      actionComment: ActionCommentWidget(
                                          onChanged: (commentValue) => context
                                              .read<EquipmentsCubit>()
                                              .commentRequesterChanged(
                                                  commentValue)),
                                    ),
                                  );
                                }),
                              BlocBuilder<EquipmentsCubit,
                                  EquipmentsCubitStates>(
                                builder: (context, state) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownSearch<BusinessUnitModel>(
                                      key: businessUnitFormKey,
                                      items: state.listBusinessUnit,
                                      itemAsString: (businessUnit) =>
                                          businessUnit.departmentName!,
                                      onChanged: (item) =>
                                          EquipmentsCubit.get(context)
                                              .validateForm(
                                                  businessUnit:
                                                      (item!.toString().isEmpty)
                                                          ? FormzStatus.invalid
                                                          : FormzStatus.pure),
                                      selectedItem: (state.requestStatus ==
                                              RequestStatus.oldRequest)
                                          ? (BusinessUnitModel.fromJson({
                                              'departmentName': state
                                                  .requestedData!
                                                  .data![0]
                                                  .departmentName
                                            }))
                                          : null,
                                      enabled: (state.requestStatus ==
                                              RequestStatus.oldRequest)
                                          ? false
                                          : true,
                                      dropdownButtonProps:
                                          const DropdownButtonProps(
                                              color: Colors.white),
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          labelText: 'Business Unit',
                                          floatingLabelAlignment:
                                              FloatingLabelAlignment.start,
                                          errorText: (state
                                                  .businessUnitStatus.isInvalid)
                                              ? 'Required'
                                              : null,
                                        ),
                                      ),
                                      popupProps: PopupProps.modalBottomSheet(
                                        showSearchBox: true,
                                        constraints: BoxConstraints(
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.75),
                                        interceptCallBacks: true,
                                        searchDelay: Duration.zero,
                                        title: AppBar(
                                            title: const Text('Business Unit'),
                                            centerTitle: true,
                                            backgroundColor: Colors.transparent,
                                            elevation: 0),
                                        listViewProps: const ListViewProps(
                                            padding: EdgeInsets.zero,
                                            physics: BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            keyboardDismissBehavior:
                                                ScrollViewKeyboardDismissBehavior
                                                    .onDrag),
                                        searchFieldProps: const TextFieldProps(
                                          padding: EdgeInsets.all(20),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            filled: true,
                                            hintText: "Search by name",
                                            prefixIcon: Icon(Icons.search,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              BlocBuilder<EquipmentsCubit,
                                  EquipmentsCubitStates>(
                                builder: (context, state) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        DropdownSearch<EquipmentsLocationModel>(
                                      key: locationFormKey,
                                      items: state.listLocation,
                                      itemAsString: (loc) => loc.projectName!,
                                      onChanged: (item) =>
                                          EquipmentsCubit.get(context)
                                              .validateForm(
                                                  location:
                                                      (item!.toString().isEmpty)
                                                          ? FormzStatus.invalid
                                                          : FormzStatus.pure),
                                      selectedItem: (state.requestStatus ==
                                              RequestStatus.oldRequest)
                                          ? (EquipmentsLocationModel.fromJson({
                                              'projectName': state
                                                  .requestedData!
                                                  .data![0]
                                                  .projectName
                                            }))
                                          : null,
                                      enabled: (state.requestStatus ==
                                              RequestStatus.oldRequest)
                                          ? false
                                          : true,
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          labelText: 'Location',
                                          floatingLabelAlignment:
                                              FloatingLabelAlignment.start,
                                          errorText:
                                              (state.locationStatus.isInvalid)
                                                  ? 'Required'
                                                  : null,
                                        ),
                                      ),
                                      dropdownButtonProps:
                                          const DropdownButtonProps(
                                              color: Colors.white),
                                      popupProps: PopupProps.modalBottomSheet(
                                        showSearchBox: true,
                                        constraints: BoxConstraints(
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.75),
                                        searchDelay: Duration.zero,
                                        interceptCallBacks: true,
                                        title: AppBar(
                                            title: const Text('Location'),
                                            centerTitle: true,
                                            backgroundColor: Colors.transparent,
                                            titleSpacing: 0,
                                            elevation: 0),
                                        searchFieldProps: const TextFieldProps(
                                          padding: EdgeInsets.all(20),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            filled: true,
                                            hintText: "Search for location",
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              BlocBuilder<EquipmentsCubit,
                                  EquipmentsCubitStates>(
                                builder: (context, state) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownSearch<DepartmentsModel>(
                                      key: departmentFormKey,
                                      items: state.listDepartment,
                                      onChanged: (item) =>
                                          EquipmentsCubit.get(context)
                                              .validateForm(
                                                  department:
                                                      (item!.toString().isEmpty)
                                                          ? FormzStatus.invalid
                                                          : FormzStatus.pure),
                                      itemAsString: (dept) =>
                                          dept.departmentName!,
                                      // selectedItem: (state.requestStatus ==
                                      //     RequestStatus.oldRequest)
                                      //     ? (DepartmentsModel.fromJson({
                                      //   'department_Name': state
                                      //       .requestedData!.data![0].departmentName
                                      // }))
                                      //     : null,
                                      enabled: (state.requestStatus ==
                                              RequestStatus.oldRequest)
                                          ? false
                                          : true,
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          labelText: 'Department',
                                          floatingLabelAlignment:
                                              FloatingLabelAlignment.start,
                                          errorText:
                                              (state.departmentStatus.isInvalid)
                                                  ? 'Required'
                                                  : null,
                                        ),
                                      ),
                                      dropdownButtonProps:
                                          const DropdownButtonProps(
                                              color: Colors.white),
                                      popupProps: PopupProps.modalBottomSheet(
                                        showSearchBox: true,
                                        constraints: BoxConstraints(
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.75),
                                        searchDelay: Duration.zero,
                                        title: AppBar(
                                          title: const Text('Department'),
                                          centerTitle: true,
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                        ),
                                        searchFieldProps: const TextFieldProps(
                                          padding: EdgeInsets.all(20),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            filled: true,
                                            hintText: "Search for department",
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              BlocBuilder<EquipmentsCubit,
                                      EquipmentsCubitStates>(
                                  builder: (context, state) {
                                return SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: TextFormField(
                                            key: UniqueKey(),
                                            enabled: false,
                                            initialValue: (state
                                                        .requestStatus ==
                                                    RequestStatus.newRequest)
                                                ? state.chosenFileName
                                                : state.requestedData?.data![0]
                                                        .equipmentFile ??
                                                    'No file',
                                            // keyboardType:
                                            //     TextInputType.multiline,
                                            maxLines: 1,
                                            decoration: const InputDecoration(
                                              labelText: "Upload file",
                                              prefixIcon: Icon(
                                                Icons.upload_file,
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (state.requestStatus ==
                                            RequestStatus.newRequest)
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              EquipmentsCubit.get(context)
                                                  .setChosenFileName();
                                            },
                                            label: const Text('Upload',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            icon: const Icon(
                                                Icons.cloud_upload_sharp,
                                                color: Colors.white),
                                          )
                                        else
                                          ElevatedButton.icon(
                                            onPressed: () async{
                                              if (state.requestedData?.data![0]
                                                      .equipmentFile !=
                                                  null) {
                                                // launchUrl(
                                                //     Uri.parse(
                                                //         'https://portal.hassanallam.com/Apps/Files/Equipments/${state.requestedData?.data![0].equipmentFile}'),
                                                //     mode: LaunchMode
                                                //         .externalApplication);
                                                await DownloadPdfHelper(
                                                    fileUrl: 'https://portal.hassanallam.com/Apps/Files/Equipments/${state.requestedData?.data![0].equipmentFile}',
                                                    fileName: state.requestedData?.data![0].equipmentFile ?? "downloaded file",
                                              success: () {
                                              // EasyLoading.show(
                                              //     status: 'Success',
                                              //     maskType: EasyLoadingMaskType.black,
                                              //     dismissOnTap: true,
                                              //     indicator: const Icon(
                                              //       Icons.done,
                                              //       size: 50,
                                              //       color: Colors.white,
                                              //     ));
                                              // EasyLoading.dismiss();
                                              },
                                              failed: () {
                                              EasyLoading.show(
                                              status: 'Failed',
                                              maskType: EasyLoadingMaskType.black,
                                              dismissOnTap: true,
                                              indicator: const Icon(
                                              Icons.clear,
                                              size: 50,
                                              color: Colors.white,
                                              ));
                                              // EasyLoading.dismiss();
                                              }).download();
                                              } else {
                                                EasyLoading.showError(
                                                    'No File has been uploaded');
                                              }
                                            },
                                            label: const Text('View File',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            icon: const Icon(
                                                Icons.cloud_upload_sharp,
                                                color: Colors.white),
                                          )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                              BlocBuilder<EquipmentsCubit,
                                      EquipmentsCubitStates>(
                                  buildWhen: (pre, curr) {
                                return pre.requestedData?.data![0].comments !=
                                    curr.requestedData?.data![0].comments;
                              }, builder: (context, state) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    key: state.requestStatus ==
                                            RequestStatus.oldRequest
                                        ? UniqueKey()
                                        : null,
                                    initialValue: (state.requestStatus ==
                                            RequestStatus.oldRequest)
                                        ? state.requestedData?.data![0].comments
                                        : "",
                                    enabled: state.requestStatus ==
                                            RequestStatus.newRequest
                                        ? true
                                        : false,
                                    onChanged: (commentValue) => context
                                        .read<EquipmentsCubit>()
                                        .commentChanged(commentValue),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                      labelText: "Add your comment",
                                      prefixIcon: Icon(
                                        Icons.comment,
                                        color: Colors.white70,
                                      ),
                                      enabled: true,
                                    ),
                                  ),
                                );
                              }),
                              BlocBuilder<EquipmentsCubit,
                                  EquipmentsCubitStates>(
                                buildWhen: (prev, current) {
                                  if (current.requestStatus ==
                                      RequestStatus.newRequest) {
                                    return prev.chosenList.length !=
                                        current.chosenList.length;
                                  } else {
                                    return current
                                        .requestedData?.data?.isEmpty ?? false;
                                  }
                                },
                                builder: (context, state) {
                                  return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    clipBehavior: Clip.hardEdge,
                                    shrinkWrap: true,
                                    itemCount: (state.requestStatus ==
                                            RequestStatus.oldRequest)
                                        ? state.requestedData?.data?.length
                                        : state.chosenList.length,
                                    itemBuilder: (listViewContext, index) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                                TweenAnimationBuilder<double>(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              tween:
                                                  Tween(begin: 1.0, end: 0.0),
                                              builder:
                                                  (context, animation, child) =>
                                                      Transform.translate(
                                                offset: (state.requestStatus ==
                                                        RequestStatus
                                                            .oldRequest)
                                                    ? const Offset(0, 0)
                                                    : Offset(
                                                        -50 * shake(animation),
                                                        0),
                                                child: Dismissible(
                                                  direction: (state
                                                              .requestStatus ==
                                                          RequestStatus
                                                              .oldRequest)
                                                      ? DismissDirection.none
                                                      : DismissDirection
                                                          .endToStart,
                                                  key: UniqueKey(),
                                                  confirmDismiss:
                                                      (dismissDirection) async {
                                                    if (dismissDirection ==
                                                        DismissDirection
                                                            .startToEnd) {
                                                      return false;
                                                    } else {
                                                      return await showDialog(
                                                        context: context,
                                                        builder: (_) {
                                                          return AlertDialog(
                                                            backgroundColor:
                                                                Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .background,
                                                            title: const Text(
                                                                'Caution',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red)),
                                                            content: const Text(
                                                              'Are you sure you want to delete this item?',
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(
                                                                          false);
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'Cancel',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(
                                                                          true);
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'Delete',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }
                                                  },
                                                  onDismissed:
                                                      (dismissDirection) {
                                                    if (dismissDirection ==
                                                        DismissDirection
                                                            .endToStart) {
                                                      state.chosenList
                                                          .removeAt(index);
                                                    }
                                                  },
                                                  background: Container(
                                                    clipBehavior: Clip.none,
                                                    margin:
                                                        const EdgeInsets.only(
                                                      bottom: 8,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)),
                                                    child: const Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Icon(
                                                        Icons.delete,
                                                        size: 30,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                  // secondaryBackground:Container(
                                                  //   clipBehavior: Clip.none,
                                                  //   margin: const EdgeInsets.only(
                                                  //     bottom: 8,
                                                  //   ),
                                                  //   padding: const EdgeInsets.all(10.0),
                                                  //   width: MediaQuery.of(context).size.width,
                                                  //   decoration: BoxDecoration(
                                                  //       color: Colors.transparent,
                                                  //       borderRadius: BorderRadius.circular(25)),
                                                  //   child: const Align(
                                                  //     alignment: Alignment.centerLeft,
                                                  //     child: Icon(
                                                  //       Icons.edit,
                                                  //       size: 30,
                                                  //       color: Colors.green,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    child: ExpansionTile(
                                                      backgroundColor: Colors
                                                          .blueGrey.shade300,
                                                      collapsedBackgroundColor:
                                                          Colors.white38,
                                                      maintainState: true,
                                                      childrenPadding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      leading: Container(
                                                          width: 40,
                                                          alignment:
                                                              Alignment.center,
                                                          child: (state
                                                                      .requestStatus ==
                                                                  RequestStatus
                                                                      .oldRequest)
                                                              ? EquipmentsCubit
                                                                      .get(
                                                                          context)
                                                                  .getIconByGroupName(state
                                                                      .requestedData!
                                                                      .data![0]
                                                                      .groupName!)
                                                              : state
                                                                  .chosenList[
                                                                      index]
                                                                  .icon!),
                                                      title: Text(
                                                        (state.requestStatus ==
                                                                RequestStatus
                                                                    .oldRequest)
                                                            ? state
                                                                .requestedData!
                                                                .data![index]
                                                                .hardWareItemName!
                                                                .trim()
                                                            : state
                                                                .chosenList[
                                                                    index]
                                                                .selectedItem!
                                                                .hardWareItemName!
                                                                .trim(),
                                                        softWrap: true,
                                                        style: const TextStyle(
                                                            fontSize: 18),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      subtitle: Text(
                                                        'Quantity: ${(state.requestStatus == RequestStatus.oldRequest) ? state.requestedData?.data![index].qty : state.chosenList[index].quantity}',
                                                        softWrap: true,
                                                      ),
                                                      children: [
                                                        if (state
                                                                .requestedData
                                                                ?.data![index]
                                                                .type !=
                                                            0)
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Request for: ${(state.requestStatus == RequestStatus.oldRequest) ? EquipmentsCubit.get(context).getRequestForFromType(state.requestedData?.data![0].type)?.trim() : state.chosenList[index].requestFor!.trim()}',
                                                                softWrap: true,
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                              ),
                                                            ],
                                                          ),
                                                        Row(
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                'Owner: ${(state.requestStatus == RequestStatus.oldRequest) ? state.requestedData!.data![index].ownerName!.trim().toTitleCase() : state.chosenList[index].selectedContact!.name!.trim().toTitleCase()}',
                                                                softWrap: false,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                'Estimate Price: ${(state.requestStatus == RequestStatus.oldRequest) ? ((state.requestedData!.data![index].estimatePrice == null) ? 'NO' : state.requestedData!.data![index].estimatePrice!.trim()) : (int.parse(state.chosenList[index].selectedItem!.estimatePrice!) * state.chosenList[index].quantity!).toString().trim()} LE',
                                                                softWrap: false,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                'Group name: ${(state.requestStatus == RequestStatus.oldRequest) ? state.requestedData!.data![index].groupName!.trim() : state.chosenList[index].selectedItem!.groupId!.toString().trim()}',
                                                                softWrap: false,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              if (EquipmentsCubit.get(context)
                                      .state
                                      .requestStatus ==
                                  RequestStatus.oldRequest)
                                BlocBuilder<EquipmentsCubit,
                                        EquipmentsCubitStates>(
                                    builder: (context, state) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10),
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: state.historyWorkFlow.length,
                                      itemBuilder: (_, index) {
                                        return InkWell(
                                          onTap: () => Navigator.of(context)
                                              .pushNamed(
                                                  DirectManagerProfileScreen
                                                      .routeName,
                                                  arguments: {
                                                DirectManagerProfileScreen
                                                        .employeeHrCode:
                                                    state.historyWorkFlow[index]
                                                        .empFromHRCode
                                              }),
                                          child: SizedBox(
                                            // height: 60,
                                            // width: double.infinity,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      width: 40,
                                                      height: 60,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image: DecorationImage(
                                                              fit: BoxFit
                                                                  .contain,
                                                              image: (state
                                                                          .historyWorkFlow[
                                                                              index]
                                                                          .imgProfile !=
                                                                      null)
                                                                  ? CachedNetworkImageProvider(getUserProfilePicture(state
                                                                      .historyWorkFlow[
                                                                          index]
                                                                      .imgProfile!))
                                                                  : Assets
                                                                      .images
                                                                      .favicon
                                                                      .image(
                                                                          scale:
                                                                              7)
                                                                      .image)),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 6,
                                                    child: SizedBox(
                                                      // width: MediaQuery.of(context).size.width - 70,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            state
                                                                .historyWorkFlow[
                                                                    index]
                                                                .empFrom!
                                                                .trim(),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        15),
                                                          ),
                                                          Text(
                                                            state
                                                                .historyWorkFlow[
                                                                    index]
                                                                .titleName!
                                                                .trim(),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        13),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: myRequestStatus(state
                                                            .historyWorkFlow[
                                                                index]
                                                            .status ??
                                                        0),
                                                  ),
                                                ]),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Divider(
                                            color: Colors.white,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }),
                              Container(
                                margin: const EdgeInsets.only(bottom: 70),
                              )
                              // Padding(padding: EdgeInsets.all(40)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  floatingActionButton:
                      BlocBuilder<EquipmentsCubit, EquipmentsCubitStates>(
                    builder: (context, state) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (state.requestStatus == RequestStatus.oldRequest &&
                              state.takeActionStatus ==
                                  TakeActionStatus.takeAction)
                            FloatingActionButton.extended(
                              heroTag: null,
                              onPressed: () {
                                context.read<EquipmentsCubit>().submitAction(
                                    ActionValueStatus.accept,
                                    requestData[
                                        EquipmentsRequestScreen.requestNoKey]);
                              },
                              icon: const Icon(Icons.verified),
                              label: const Text('Accept'),
                            ),
                          const SizedBox(height: 12),
                          if (state.requestStatus == RequestStatus.oldRequest &&
                              state.takeActionStatus ==
                                  TakeActionStatus.takeAction)
                            FloatingActionButton.extended(
                              backgroundColor: Colors.white,
                              heroTag: null,
                              onPressed: () {
                                context.read<EquipmentsCubit>().submitAction(
                                    ActionValueStatus.reject,
                                    requestData[
                                        EquipmentsRequestScreen.requestNoKey]);
                              },
                              icon: const Icon(
                                Icons.dangerous,
                                color: ConstantsColors.bottomSheetBackground,
                              ),
                              label: const Text(
                                'Reject',
                                style: TextStyle(
                                  color: ConstantsColors.bottomSheetBackground,
                                ),
                              ),
                            ),
                          const SizedBox(height: 12),
                          if (state.requestStatus == RequestStatus.newRequest)
                            FloatingActionButton.extended(
                              label: const Text('Submit'),
                              icon: const Icon(Icons.save),
                              onPressed: () {
                                if (businessUnitFormKey
                                            .currentState!.getSelectedItem ==
                                        null ||
                                    locationFormKey
                                            .currentState!.getSelectedItem ==
                                        null ||
                                    departmentFormKey
                                            .currentState!.getSelectedItem ==
                                        null) {
                                  // businessUnitFormKey.currentState!
                                  //     .popupOnValidate();
                                  EquipmentsCubit.get(context).validateForm(
                                    businessUnit: (businessUnitFormKey
                                                .currentState!
                                                .getSelectedItem ==
                                            null)
                                        ? FormzStatus.invalid
                                        : FormzStatus.pure,
                                    location: (locationFormKey.currentState!
                                                .getSelectedItem ==
                                            null)
                                        ? FormzStatus.invalid
                                        : FormzStatus.pure,
                                    department: (departmentFormKey.currentState!
                                                .getSelectedItem ==
                                            null)
                                        ? FormzStatus.invalid
                                        : FormzStatus.pure,
                                  );
                                } else if (EquipmentsCubit.get(context)
                                    .state
                                    .chosenList
                                    .isEmpty) {
                                  EasyLoading.showInfo(
                                    'Add at least one item to request',
                                    dismissOnTap: true,
                                    maskType: EasyLoadingMaskType.black,
                                  );
                                } else {
                                  EquipmentsCubit.get(context)
                                      .postEquipmentsRequest(
                                    departmentObject: departmentFormKey
                                        .currentState!.getSelectedItem!,
                                    businessUnitObject: businessUnitFormKey
                                        .currentState!.getSelectedItem!,
                                    locationObject: locationFormKey
                                        .currentState!.getSelectedItem!,
                                    userHrCode: user.employeeData!.userHrCode!,
                                    selectedItem: state.chosenList,
                                    comment: state.comment,
                                  );
                                  // Navigator.of(context).pushReplacement(
                                  //   MaterialPageRoute(
                                  //     builder: (_) => const SuccessScreen(
                                  //       requestName: 'Equipment',
                                  //       routName:
                                  //           EquipmentsRequestScreen.routeName,
                                  //       text: "Success",
                                  //     ),
                                  //   ),
                                  // );
                                }
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              tooltip: 'Save Request',
                            ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  showEquipmentRequestHistory({
    required BuildContext context,
    required String serviceId,
    required int requestNumber,
  }) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: true,
        builder: (_) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: BlocProvider.value(
              value: EquipmentsCubit.get(context)
                ..getHistory(
                    serviceId: serviceId, requestNumber: requestNumber),
              child: BlocBuilder<EquipmentsCubit, EquipmentsCubitStates>(
                  builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.historyWorkFlow.length,
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () => Navigator.of(context).pushNamed(
                            DirectManagerProfileScreen.routeName,
                            arguments: {
                              DirectManagerProfileScreen.employeeHrCode:
                                  state.historyWorkFlow[index].empFromHRCode
                            }),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            // height: 60,
                            width: double.infinity,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      width: 40,
                                      height: 60,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image: (state
                                                          .historyWorkFlow[
                                                              index]
                                                          .imgProfile !=
                                                      null)
                                                  ? CachedNetworkImageProvider(
                                                      getUserProfilePicture(
                                                          state
                                                              .historyWorkFlow[
                                                                  index]
                                                              .imgProfile!))
                                                  : Assets.images.favicon
                                                      .image(scale: 7)
                                                      .image)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: SizedBox(
                                      // width: MediaQuery.of(context).size.width - 70,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            state
                                                .historyWorkFlow[index].empFrom!
                                                .trim(),
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            state.historyWorkFlow[index]
                                                .titleName!
                                                .trim(),
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: myRequestStatus(
                                        state.historyWorkFlow[index].status ??
                                            0),
                                  ),
                                ]),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Divider(
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          );
        });
  }

  Widget myRequestStatus(int? status) {
    switch (status) {
      case 1:
        {
          return const Icon(
            Icons.verified,
            color: Colors.green,
          );
        }
      case 2:
        {
          return const Icon(
            Icons.cancel,
            color: Colors.red,
          );
        }
      default:
        {
          return const Icon(
            Icons.pending_actions_outlined,
            color: Colors.yellow,
          );
        }
    }
  }

  showAddRequestBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      builder: (dialogContext) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(10),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                addRequestOptions(
                    id: '8',
                    context: context,
                    name: 'Accessories',
                    icon: const Icon(
                      Icons.keyboard_alt_outlined,
                      color: Colors.white,
                    )),
                const Divider(color: Colors.white),
                addRequestOptions(
                    id: '2',
                    context: context,
                    name: 'Laptop',
                    icon: const Icon(
                      Icons.laptop_chromebook_outlined,
                      color: Colors.white,
                    )),
                const Divider(color: Colors.white),
                addRequestOptions(
                    id: '9',
                    context: context,
                    name: 'Datashow / projector',
                    icon: const Icon(
                      Icons.live_tv,
                      color: Colors.white,
                    )),
                const Divider(color: Colors.white),
                addRequestOptions(
                    id: '1',
                    context: context,
                    name: 'Desktop',
                    icon: const Icon(
                      Icons.computer_outlined,
                      color: Colors.white,
                    )),
                const Divider(color: Colors.white),
                addRequestOptions(
                    id: '7',
                    context: context,
                    name: 'Fingerprint',
                    icon: const Icon(
                      Icons.fingerprint,
                      color: Colors.white,
                    )),
                const Divider(color: Colors.white),
                addRequestOptions(
                    id: '11',
                    context: context,
                    name: 'Internet connection',
                    icon: const Icon(
                      Icons.network_wifi_outlined,
                      color: Colors.white,
                    )),
                const Divider(color: Colors.white),
                addRequestOptions(
                    id: '10',
                    context: context,
                    name: 'Telephones',
                    icon: const Icon(
                      Icons.call,
                      color: Colors.white,
                    )),
                const Divider(color: Colors.white),
                addRequestOptions(
                    id: '4',
                    context: context,
                    name: 'Printer',
                    icon: const Icon(
                      Icons.print_outlined,
                      color: Colors.white,
                    )),
                const Divider(color: Colors.white),
                addRequestOptions(
                    id: '3',
                    context: context,
                    name: 'Server',
                    icon: const HeroIcon(
                      HeroIcons.server,
                      color: Colors.white,
                    )),
                const Divider(color: Colors.white),
                addRequestOptions(
                    id: '6',
                    context: context,
                    name: 'Network',
                    icon: const HeroIcon(
                      HeroIcons.globeAlt,
                      color: Colors.white,
                    )),
                const Divider(color: Colors.white),
                addRequestOptions(
                    id: '14',
                    context: context,
                    name: 'Toner/Ink',
                    icon: const Icon(
                      Icons.water_drop,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        );
        //   BottomSheet(
        //   // insetAnimationCurve: Curves.easeIn,
        //   // insetAnimationDuration: const Duration(milliseconds: 500),
        //   key: UniqueKey(), enableDrag: false,
        //   backgroundColor: const Color(0xFF031A27),
        //   shape: const RoundedRectangleBorder(
        //       borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        //   onClosing: () {},
        //   builder: (_) {
        //     return Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: ListView(
        //         shrinkWrap: true,
        //         physics: const BouncingScrollPhysics(),
        //         padding: const EdgeInsets.all(10),
        //         keyboardDismissBehavior:
        //             ScrollViewKeyboardDismissBehavior.onDrag,
        //         children: [
        //           addRequestOptions(
        //               id: '8',
        //               context: context,
        //               name: 'Accessories',
        //               icon: const Icon(
        //                 Icons.keyboard_alt_outlined,
        //                 color: Colors.white,
        //               )),
        //           const Divider(color: Colors.white),
        //           addRequestOptions(
        //               id: '2',
        //               context: context,
        //               name: 'Laptop',
        //               icon: const Icon(
        //                 Icons.laptop_chromebook_outlined,
        //                 color: Colors.white,
        //               )),
        //           const Divider(color: Colors.white),
        //           addRequestOptions(
        //               id: '9',
        //               context: context,
        //               name: 'Datashow / projector',
        //               icon: const Icon(
        //                 Icons.live_tv,
        //                 color: Colors.white,
        //               )),
        //           const Divider(color: Colors.white),
        //           addRequestOptions(
        //               id: '1',
        //               context: context,
        //               name: 'Desktop',
        //               icon: const Icon(
        //                 Icons.computer_outlined,
        //                 color: Colors.white,
        //               )),
        //           const Divider(color: Colors.white),
        //           addRequestOptions(
        //               id: '7',
        //               context: context,
        //               name: 'Fingerprint',
        //               icon: const Icon(
        //                 Icons.fingerprint,
        //                 color: Colors.white,
        //               )),
        //           const Divider(color: Colors.white),
        //           addRequestOptions(
        //               id: '11',
        //               context: context,
        //               name: 'Internet connection',
        //               icon: const Icon(
        //                 Icons.network_wifi_outlined,
        //                 color: Colors.white,
        //               )),
        //           const Divider(color: Colors.white),
        //           addRequestOptions(
        //               id: '10',
        //               context: context,
        //               name: 'Telephones',
        //               icon: const Icon(
        //                 Icons.call,
        //                 color: Colors.white,
        //               )),
        //           const Divider(color: Colors.white),
        //           addRequestOptions(
        //               id: '4',
        //               context: context,
        //               name: 'Printer',
        //               icon: const Icon(
        //                 Icons.print_outlined,
        //                 color: Colors.white,
        //               )),
        //           const Divider(color: Colors.white),
        //           addRequestOptions(
        //               id: '3',
        //               context: context,
        //               name: 'Server',
        //               icon: const HeroIcon(
        //                 HeroIcons.server,
        //                 color: Colors.white,
        //               )),
        //           const Divider(color: Colors.white),
        //           addRequestOptions(
        //               id: '6',
        //               context: context,
        //               name: 'Network',
        //               icon: const HeroIcon(
        //                 HeroIcons.globe,
        //                 color: Colors.white,
        //               )),
        //           const Divider(color: Colors.white),
        //           addRequestOptions(
        //               id: '14',
        //               context: context,
        //               name: 'Toner/Ink',
        //               icon: const Icon(
        //                 Icons.water_drop,
        //                 color: Colors.white,
        //               )),
        //         ],
        //       ),
        //     );
        //   },
        // );
      },
    );
  }

  addRequestOptions(
      {required BuildContext context,
      required String name,
      required Widget icon,
      required String id}) {
    return InkWell(
      onTap: () {
        showEquipmentsBottomSheet(
            context: context, name: name, id: id, icon: icon);
      },
      // borderRadius: const BorderRadius.all(Radius.circular(25)),
      child: Container(
        height: 35,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            const SizedBox(
              width: 20,
            ),
            Text(name,
                softWrap: true,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  showEquipmentsBottomSheet(
      {required BuildContext context,
      required String name,
      required String id,
      required Widget icon}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      builder: (dialogContext) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => onSubmitRequest(context, icon),
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      color: ConstantsColors.greenAttendance,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  // icon: const Icon(
                  //   Icons.done,
                  //   color: Colors.white,
                  // ),
                ),
              ],
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocProvider(
                create: (context) => EquipmentsItemsCubit(GeneralDio(
                    BlocProvider.of<AppBloc>(context).state.userData))
                  ..getEquipmentsItems(id: id),
  child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   BlocBuilder<EquipmentsItemsCubit,
                        EquipmentsItemsInitial>(
                      builder: (context, state) {
                        return buildDynamicDropDownMenu(
                          items: state.listEquipmentsItem,
                          listName: 'Select Item',
                          context: context,
                        );
                      },
                    ),

                  BlocBuilder<ContactsCubit, ContactCubitStates>(
                    builder: (context, state) {
                      return buildContactsDropDownMenu(
                          listName: 'Owner Employee',
                          items: ContactsCubit.get(context).state.listContacts,
                          context: context);
                    },
                  ),
                  buildDropDownMenu(
                    items: [
                      'New Hire',
                      'Replacement / New Item',
                      'Training',
                      'Mobilization'
                    ],
                    listName: 'Request For',
                    context: context,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: buildTextFormField(),
                  ),
                  // ElevatedButton.icon(
                  //   onPressed: () => onSubmitRequest(context, icon),
                  //   label: Text('Done',
                  //       style: TextStyle(
                  //           color: ConstantsColors.bottomSheetBackgroundDark)),
                  //   icon: Icon(
                  //     Icons.done,
                  //     color: ConstantsColors.bottomSheetBackgroundDark,
                  //   ),
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.white,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20)),
                  //   ),
                  // ),
                ],
              ),
),
            ),
          ),
        );
      },
    );
  }

  buildContactsDropDownMenu({
    required List<ContactsDataFromApi> items,
    required String listName,
    required BuildContext context,
  }) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownSearch<ContactsDataFromApi>(
          items: items,
          itemAsString: (contactKey) => contactKey.name!.trim(),
          key: ownerFormKey,
          dropdownButtonProps: const DropdownButtonProps(color: Colors.white),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: listName,
              // contentPadding: const EdgeInsets.all(10),
              prefixIcon: const Icon(
                Icons.people,
                color: Colors.white,
              ),
            ),
          ),
          popupProps: const PopupProps.menu(
            showSearchBox: true,
            menuProps: MenuProps(
                backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                clipBehavior: Clip.hardEdge),
            fit: FlexFit.tight,
            searchFieldProps: TextFieldProps(
              padding: EdgeInsets.all(20),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                filled: true,
                labelText: "Search for name",
                hintText: "Search for name",
                prefixIcon: Icon(Icons.search, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildDynamicDropDownMenu(
      {required List<EquipmentsItemModel> items,
      required String listName,
      required BuildContext context,
      bool showSearch = false}) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownSearch<EquipmentsItemModel>(
          items: items,
          key: itemFormKey,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (_) {
            if (itemFormKey.currentState?.getSelectedItem == null) {
              return 'Please chose an option';
            }
            return null;
          },
          onChanged: (value) => EquipmentsItemsCubit.get(context).setElementPrice(elementPrice: value?.estimatePrice ?? '0'),
          itemAsString: (equip) => equip.hardWareItemName!,
          dropdownButtonProps: const DropdownButtonProps(color: Colors.white),
          dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                  labelText: listName,
                  // contentPadding: const EdgeInsets.all(10),
                  prefixIcon: const Icon(
                    Icons.question_mark,
                    color: Colors.white,
                  ))),
          popupProps: PopupProps.menu(
              menuProps: const MenuProps(
                  backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  clipBehavior: Clip.hardEdge),
              showSearchBox: showSearch,
              fit: FlexFit.tight,
              searchFieldProps: const TextFieldProps(
                  padding: EdgeInsets.zero, scrollPadding: EdgeInsets.zero)),
        ),
      ),
    );
  }

  buildDropDownMenu(
      {required List<String?> items,
      required String listName,
      required BuildContext context,
      bool showSearch = false}) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownSearch<String?>(
          items: items,
          key: requestForFormKey,
          dropdownButtonProps: const DropdownButtonProps(color: Colors.white),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: listName,
              // contentPadding: const EdgeInsets.all(10),
              prefixIcon: const Icon(
                Icons.question_mark,
                color: Colors.white,
              ),
            ),
          ),
          popupProps: PopupProps.menu(
            menuProps: const MenuProps(
                backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                clipBehavior: Clip.hardEdge),
            showSearchBox: showSearch,
            fit: FlexFit.tight,
            searchFieldProps: const TextFieldProps(
              padding: EdgeInsets.zero,
              scrollPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    );
  }

  buildTextFormField() {
    return BlocBuilder<EquipmentsItemsCubit, EquipmentsItemsInitial>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: IconButton(
                icon: const Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
                onPressed: () {
                  int currentValue = int.parse(controller.text);
                  currentValue--;
                  controller.text = (currentValue > 1 ? currentValue : 1)
                      .toString(); // decrementing value
                  EquipmentsItemsCubit.get(context).setElementPrice(count: controller.text);
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: TextFormField(
                textAlign: TextAlign.center,
                enabled: false,
                controller: controller,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))
                ],
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                splashColor: Colors.transparent,
                onPressed: () {
                  int currentValue = int.parse(controller.text);
                  if (currentValue < 100) currentValue++;
                  controller.text =
                      (currentValue).toString(); // incrementing value
                  EquipmentsItemsCubit.get(context).setElementPrice(count: controller.text);
                },
              ),
            ),
            Flexible(
                child: Text(
                    'Price: ${(int.parse(controller.text) * int.parse(state.elementPrice)).toString()} LE')),
          ],
        );
      },
    );
  }

  onSubmitRequest(
    BuildContext context,
    Widget icon,
  ) {
    if ((requestForFormKey.currentState!.getSelectedItem == null) ||
        (ownerFormKey.currentState!.getSelectedItem == null) ||
        (itemFormKey.currentState!.getSelectedItem == null)) {
      EasyLoading.showInfo('Fill all the field',
          maskType: EasyLoadingMaskType.black);
    } else {
      try {
        EquipmentsCubit.get(context).setChosenList(
          chosenObject: SelectedEquipmentsModel(
            requestFor: requestForFormKey.currentState!.getSelectedItem,
            selectedContact: ownerFormKey.currentState!.getSelectedItem,
            quantity: int.parse(controller.text),
            selectedItem: itemFormKey.currentState!.getSelectedItem,
            icon: icon,
          ),
        );
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      } catch (e) {
        EasyLoading.showError('You already add this item',
            maskType: EasyLoadingMaskType.black);
      }
    }
  }
}