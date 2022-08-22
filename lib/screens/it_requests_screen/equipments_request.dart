import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../constants/enums.dart';
import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../data/repositories/request_repository.dart';
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

class EquipmentsRequest extends StatelessWidget {
  static const routeName = 'request-equipments-screen';
  static const requestNoKey = 'request-No';
  static const requesterHrCode = 'requester-HRCode';

  EquipmentsRequest({Key? key, this.requestData}) : super(key: key);

  final dynamic requestData;

  final GlobalKey<DropdownSearchState<EquipmentsItemModel>> itemFormKey =
      GlobalKey();

  final TextEditingController controller = TextEditingController();

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
    final user = context.select((AppBloc bloc) => bloc.state.userData);
    double shake(double animation) =>
        2 * (0.5 - (0.5 -  Curves.ease.transform(animation)).abs());
    return WillPopScope(
      onWillPop: () async {
        await EasyLoading.dismiss(animation: true);
        return true;
      },
      child: BlocProvider<EquipmentsCubit>(
        create: (context) => requestData[EquipmentsRequest.requestNoKey] == "0"
            ? (EquipmentsCubit(RequestRepository(user))
              ..getRequestData(requestStatus: RequestStatus.newRequest)
              ..getAll())
            : (EquipmentsCubit(RequestRepository(user))
              ..getRequestData(
                requestStatus: RequestStatus.oldRequest,
                requesterHRCode: requestData[EquipmentsRequest.requesterHrCode],
                requestNo: requestData[EquipmentsRequest.requestNoKey],
              )),
        child: CustomBackground(
          child: CustomTheme(
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Equipment request'),
              ),
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<EquipmentsCubit, EquipmentsCubitStates>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: DropdownSearch<BusinessUnitModel>(
                            key: businessUnitFormKey,
                            items: state.listBusinessUnit,
                            itemAsString: (businessUnit) =>
                                businessUnit.departmentName!,
                            selectedItem: (state.requestStatus ==
                                    RequestStatus.oldRequest)
                                ? (BusinessUnitModel.fromJson({
                                    'departmentName': state
                                        .requestedData!.data![0].departmentName
                                  }))
                                : null,
                            autoValidateMode: (state.requestStatus ==
                                    RequestStatus.oldRequest)
                                ? AutovalidateMode.disabled
                                : AutovalidateMode.always,
                            validator: (state.requestStatus ==
                                    RequestStatus.newRequest)
                                ? (item) {
                                    if (item == null) {
                                      return "Required field";
                                    } else {
                                      return null;
                                    }
                                  }
                                : null,
                            enabled: (state.requestStatus ==
                                    RequestStatus.oldRequest)
                                ? false
                                : true,
                            dropdownButtonProps:
                                const DropdownButtonProps(color: Colors.white),
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: 'Business Unit',
                                isDense: true,
                              ),
                            ),
                            popupProps: PopupProps.modalBottomSheet(
                              showSearchBox: true,
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
                                      ScrollViewKeyboardDismissBehavior.onDrag),
                              modalBottomSheetProps: ModalBottomSheetProps(
                                backgroundColor:
                                    Theme.of(context).colorScheme.background,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20))),
                              ),
                              searchFieldProps: const TextFieldProps(
                                padding: EdgeInsets.all(20),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  filled: true,
                                  hintText: "Search by name",
                                  prefixIcon:
                                      Icon(Icons.search, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<EquipmentsCubit, EquipmentsCubitStates>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: DropdownSearch<EquipmentsLocationModel>(
                            key: locationFormKey,
                            items: state.listLocation,
                            itemAsString: (loc) => loc.projectName!,
                            selectedItem: (state.requestStatus ==
                                    RequestStatus.oldRequest)
                                ? (EquipmentsLocationModel.fromJson({
                                    'projectName': state
                                        .requestedData!.data![0].projectName
                                  }))
                                : null,
                            autoValidateMode: (state.requestStatus ==
                                    RequestStatus.oldRequest)
                                ? AutovalidateMode.disabled
                                : AutovalidateMode.always,
                            validator: (state.requestStatus ==
                                    RequestStatus.newRequest)
                                ? (item) {
                                    if (item == null) {
                                      return "Required field";
                                    } else {
                                      return null;
                                    }
                                  }
                                : null,
                            enabled: (state.requestStatus ==
                                    RequestStatus.oldRequest)
                                ? false
                                : true,
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: 'Location',
                                isDense: true,
                              ),
                            ),
                            dropdownButtonProps:
                                const DropdownButtonProps(color: Colors.white),
                            popupProps: PopupProps.modalBottomSheet(
                              showSearchBox: true,
                              searchDelay: Duration.zero,
                              interceptCallBacks: true,
                              modalBottomSheetProps: ModalBottomSheetProps(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                )),
                              ),
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
                    BlocBuilder<EquipmentsCubit, EquipmentsCubitStates>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: DropdownSearch<DepartmentsModel>(
                            key: departmentFormKey,
                            items: state.listDepartment,
                            itemAsString: (dept) => dept.departmentName!,
                            // selectedItem: (state.requestStatus ==
                            //     RequestStatus.oldRequest)
                            //     ? (DepartmentsModel.fromJson({
                            //   'department_Name': state
                            //       .requestedData!.data![0].groupName
                            // }))
                            //     : null,
                            autoValidateMode: (state.requestStatus ==
                                    RequestStatus.oldRequest)
                                ? AutovalidateMode.disabled
                                : AutovalidateMode.always,
                            validator: (state.requestStatus ==
                                    RequestStatus.newRequest)
                                ? (item) {
                                    if (item == null) {
                                      return "Required field";
                                    } else {
                                      return null;
                                    }
                                  }
                                : null,
                            enabled: (state.requestStatus ==
                                    RequestStatus.oldRequest)
                                ? false
                                : true,
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                              labelText: 'Department',
                              isDense: true,
                            )),
                            dropdownButtonProps:
                                const DropdownButtonProps(color: Colors.white),
                            popupProps: PopupProps.modalBottomSheet(
                              showSearchBox: true,
                              searchDelay: Duration.zero,
                              title: AppBar(
                                title: const Text('Department'),
                                centerTitle: true,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              modalBottomSheetProps: ModalBottomSheetProps(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)))),
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
                    BlocBuilder<EquipmentsCubit, EquipmentsCubitStates>(
                      builder: (context, state) {
                        return (EquipmentsCubit.get(context)
                                    .state
                                    .requestStatus ==
                                RequestStatus.newRequest)
                            ? ElevatedButton.icon(
                                onPressed: () {
                                  showAddRequestBottomSheet(context);
                                },
                                icon: const Icon(Icons.add),
                                label: const Text('Request Item'),
                                style: ElevatedButton.styleFrom(
                                    tapTargetSize: MaterialTapTargetSize.padded,
                                    primary: Colors.blueGrey),
                              )
                            : SizedBox(
                                child: Text(state.statusAction ?? ''),
                              );
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.47,
                      child:
                          BlocBuilder<EquipmentsCubit, EquipmentsCubitStates>(
                        buildWhen: (prev, current) {
                          if (current.requestStatus ==
                              RequestStatus.newRequest) {
                            return prev.chosenList.length !=
                                current.chosenList.length;
                          } else {
                            return current.requestedData!.data!.isNotEmpty;
                          }
                        },
                        builder: (context, state) {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            clipBehavior: Clip.hardEdge,
                            shrinkWrap: true,
                            itemCount: (state.requestStatus ==
                                    RequestStatus.oldRequest)
                                ? state.requestedData!.data!.length
                                : state.chosenList.length,
                            padding: const EdgeInsets.all(5),
                            itemBuilder: (listViewContext, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TweenAnimationBuilder<double>(
                                  duration: const Duration(milliseconds: 1000),
                                  tween: Tween(begin: 1.0, end: 0.0),
                                  builder: (context,animation, child) =>
                                      Transform.translate(
                                        offset: (state.requestStatus ==
                                            RequestStatus.oldRequest)? const Offset(0, 0) :Offset(-50 * shake(animation), 0),
                                        child: Dismissible(
                                          direction: (state.requestStatus ==
                                              RequestStatus.oldRequest)
                                              ? DismissDirection.none
                                              : DismissDirection.endToStart,
                                          key: UniqueKey(),
                                          confirmDismiss: (dismissDirection) async {
                                            if (dismissDirection ==
                                                DismissDirection.startToEnd) {
                                              return false;
                                            } else {
                                              return await showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return AlertDialog(
                                                    backgroundColor: Theme.of(context)
                                                        .colorScheme
                                                        .background,
                                                    title: const Text('Caution',
                                                        style: TextStyle(
                                                            color: Colors.red)),
                                                    content: const Text(
                                                      'Are you sure you want to delete this item?',
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(false);
                                                        },
                                                        child: const Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(true);
                                                        },
                                                        child: const Text(
                                                          'Delete',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors.red),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          onDismissed: (dismissDirection) {
                                            if (dismissDirection ==
                                                DismissDirection.endToStart) {
                                              state.chosenList.removeAt(index);
                                            }
                                          },
                                          background: Container(
                                            clipBehavior: Clip.none,
                                            margin: const EdgeInsets.only(
                                              bottom: 8,
                                            ),
                                            padding: const EdgeInsets.all(10.0),
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                BorderRadius.circular(25)),
                                            child: const Align(
                                              alignment: Alignment.centerRight,
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
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(20)),
                                            child: ExpansionTile(
                                              backgroundColor: Colors.white54,
                                              collapsedBackgroundColor:
                                              Colors.white38,
                                              maintainState: true,
                                              childrenPadding:
                                              const EdgeInsets.all(10),
                                              leading: (state.requestStatus ==
                                                  RequestStatus.oldRequest)
                                                  ? EquipmentsCubit.get(context)
                                                  .getIconByGroupName(state
                                                  .requestedData!
                                                  .data![0]
                                                  .groupName!)
                                                  : state.chosenList[index].icon!,
                                              title: Text(
                                                (state.requestStatus ==
                                                    RequestStatus.oldRequest)
                                                    ? state
                                                    .requestedData!
                                                    .data![index]
                                                    .hardWareItemName!
                                                    .trim()
                                                    : state
                                                    .chosenList[index]
                                                    .selectedItem!
                                                    .hardWareItemName!
                                                    .trim(),
                                                softWrap: true,
                                                style: const TextStyle(fontSize: 18),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              subtitle: Text(
                                                'Quantity: ${(state.requestStatus == RequestStatus.oldRequest) ? state.requestedData!.data![index].qty : state.chosenList[index].quantity}',
                                                softWrap: true,
                                              ),
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text(
                                                      'Request for: ',
                                                      softWrap: true,
                                                      style:
                                                      TextStyle(fontSize: 18),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        (state.requestStatus ==
                                                            RequestStatus
                                                                .oldRequest)
                                                            ? EquipmentsCubit.get(
                                                            context)
                                                            .getRequestForFromType(
                                                            state
                                                                .requestedData!
                                                                .data![index]
                                                                .type!)!
                                                            .trim()
                                                            : state.chosenList[index]
                                                            .requestFor!
                                                            .trim(),
                                                        softWrap: true,
                                                        style: const TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Row(
                                                //   children: [
                                                //     Text(
                                                //       'Quantity: ${(state.requestStatus == RequestStatus.oldRequest) ? state.requestedData!.data![index].qty : state.chosenList[index].quantity}',
                                                //       softWrap: true,
                                                //       style: const TextStyle(fontSize: 18),
                                                //     ),
                                                //   ],
                                                // ),
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        'Owner: ${(state.requestStatus == RequestStatus.oldRequest) ? state.requestedData!.data![index].ownerName!.trim().toTitleCase() : state.chosenList[index].selectedContact!.name!.trim().toTitleCase()}',
                                                        softWrap: false,
                                                        maxLines: 2,
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 18),
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
                                                        TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 18),
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
                                                        TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Container(
                                          //   key: Key('value$index'),
                                          //   margin: const EdgeInsets.only(
                                          //     bottom: 8,
                                          //   ),
                                          //   padding: const EdgeInsets.all(10.0),
                                          //   width: MediaQuery.of(context).size.width,
                                          //   decoration: BoxDecoration(
                                          //       color: Colors.blueGrey,
                                          //       borderRadius: BorderRadius.circular(25)),
                                          //   child: Column(
                                          //     mainAxisAlignment: MainAxisAlignment.center,
                                          //     crossAxisAlignment: CrossAxisAlignment.start,
                                          //     children: [
                                          //       Center(
                                          //           child: (state.requestStatus ==
                                          //                   RequestStatus.oldRequest)
                                          //               ? EquipmentsCubit.get(context)
                                          //                   .getIconByGroupName(state
                                          //                       .requestedData!
                                          //                       .data![0]
                                          //                       .groupName!)
                                          //               : state.chosenList[index].icon!),
                                          //       Text(
                                          //         (state.requestStatus ==
                                          //                 RequestStatus.oldRequest)
                                          //             ? state.requestedData!.data![index]
                                          //                 .hardWareItemName!
                                          //                 .trim()
                                          //             : state.chosenList[index]
                                          //                 .selectedItem!.hardWareItemName!
                                          //                 .trim(),
                                          //         softWrap: true,
                                          //         style: const TextStyle(fontSize: 18),
                                          //       ),
                                          //       Text(
                                          //         (state.requestStatus ==
                                          //                 RequestStatus.oldRequest)
                                          //             ? EquipmentsCubit.get(context)
                                          //                 .getRequestForFromType(state
                                          //                     .requestedData!
                                          //                     .data![index]
                                          //                     .type!)!
                                          //                 .trim()
                                          //             : state.chosenList[index].requestFor!
                                          //                 .trim(),
                                          //         softWrap: true,
                                          //         style: const TextStyle(fontSize: 18),
                                          //       ),
                                          //       Text(
                                          //         'Qty: ${(state.requestStatus == RequestStatus.oldRequest) ? state.requestedData!.data![index].qty : state.chosenList[index].quantity}',
                                          //         softWrap: true,
                                          //         style: const TextStyle(fontSize: 18),
                                          //       ),
                                          //       Text(
                                          //         'Owner: ${(state.requestStatus == RequestStatus.oldRequest) ? state.requestedData!.data![index].ownerName!.trim() : state.chosenList[index].selectedContact!.name!.trim().toLowerCase()}',
                                          //         softWrap: false,
                                          //         maxLines: 2,
                                          //         overflow: TextOverflow.ellipsis,
                                          //         style: const TextStyle(fontSize: 18),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                  // child: Dismissible(
                                  //                                           direction: (state.requestStatus ==
                                  //                                               RequestStatus.oldRequest)
                                  //                                               ? DismissDirection.none
                                  //                                               : DismissDirection.endToStart,
                                  //                                           key: UniqueKey(),
                                  //                                           confirmDismiss: (dismissDirection) async {
                                  //                                             if (dismissDirection ==
                                  //                                                 DismissDirection.startToEnd) {
                                  //                                               return false;
                                  //                                             } else {
                                  //                                               return await showDialog(
                                  //                                                 context: context,
                                  //                                                 builder: (_) {
                                  //                                                   return AlertDialog(
                                  //                                                     backgroundColor: Theme.of(context)
                                  //                                                         .colorScheme
                                  //                                                         .background,
                                  //                                                     title: const Text('Caution',
                                  //                                                         style: TextStyle(
                                  //                                                             color: Colors.red)),
                                  //                                                     content: const Text(
                                  //                                                       'Are you sure you want to delete this item?',
                                  //                                                     ),
                                  //                                                     actions: [
                                  //                                                       TextButton(
                                  //                                                         onPressed: () {
                                  //                                                           Navigator.of(context)
                                  //                                                               .pop(false);
                                  //                                                         },
                                  //                                                         child: const Text(
                                  //                                                           'Cancel',
                                  //                                                           style: TextStyle(
                                  //                                                             fontSize: 16,
                                  //                                                           ),
                                  //                                                         ),
                                  //                                                       ),
                                  //                                                       TextButton(
                                  //                                                         onPressed: () {
                                  //                                                           Navigator.of(context)
                                  //                                                               .pop(true);
                                  //                                                         },
                                  //                                                         child: const Text(
                                  //                                                           'Delete',
                                  //                                                           style: TextStyle(
                                  //                                                               fontSize: 16,
                                  //                                                               color: Colors.red),
                                  //                                                         ),
                                  //                                                       ),
                                  //                                                     ],
                                  //                                                   );
                                  //                                                 },
                                  //                                               );
                                  //                                             }
                                  //                                           },
                                  //                                           onDismissed: (dismissDirection) {
                                  //                                             if (dismissDirection ==
                                  //                                                 DismissDirection.endToStart) {
                                  //                                               state.chosenList.removeAt(index);
                                  //                                             }
                                  //                                           },
                                  //                                           background: Container(
                                  //                                             clipBehavior: Clip.none,
                                  //                                             margin: const EdgeInsets.only(
                                  //                                               bottom: 8,
                                  //                                             ),
                                  //                                             padding: const EdgeInsets.all(10.0),
                                  //                                             width: MediaQuery.of(context).size.width,
                                  //                                             decoration: BoxDecoration(
                                  //                                                 color: Colors.transparent,
                                  //                                                 borderRadius:
                                  //                                                 BorderRadius.circular(25)),
                                  //                                             child: const Align(
                                  //                                               alignment: Alignment.centerRight,
                                  //                                               child: Icon(
                                  //                                                 Icons.delete,
                                  //                                                 size: 30,
                                  //                                                 color: Colors.red,
                                  //                                               ),
                                  //                                             ),
                                  //                                           ),
                                  //                                           // secondaryBackground:Container(
                                  //                                           //   clipBehavior: Clip.none,
                                  //                                           //   margin: const EdgeInsets.only(
                                  //                                           //     bottom: 8,
                                  //                                           //   ),
                                  //                                           //   padding: const EdgeInsets.all(10.0),
                                  //                                           //   width: MediaQuery.of(context).size.width,
                                  //                                           //   decoration: BoxDecoration(
                                  //                                           //       color: Colors.transparent,
                                  //                                           //       borderRadius: BorderRadius.circular(25)),
                                  //                                           //   child: const Align(
                                  //                                           //     alignment: Alignment.centerLeft,
                                  //                                           //     child: Icon(
                                  //                                           //       Icons.edit,
                                  //                                           //       size: 30,
                                  //                                           //       color: Colors.green,
                                  //                                           //     ),
                                  //                                           //   ),
                                  //                                           // ),
                                  //                                           child: ClipRRect(
                                  //                                             borderRadius: const BorderRadius.all(
                                  //                                                 Radius.circular(20)),
                                  //                                             child: ExpansionTile(
                                  //                                               backgroundColor: Colors.white54,
                                  //                                               collapsedBackgroundColor:
                                  //                                               Colors.white38,
                                  //                                               childrenPadding:
                                  //                                               const EdgeInsets.all(10),
                                  //                                               leading: (state.requestStatus ==
                                  //                                                   RequestStatus.oldRequest)
                                  //                                                   ? EquipmentsCubit.get(context)
                                  //                                                   .getIconByGroupName(state
                                  //                                                   .requestedData!
                                  //                                                   .data![0]
                                  //                                                   .groupName!)
                                  //                                                   : state.chosenList[index].icon!,
                                  //                                               title: Text(
                                  //                                                 (state.requestStatus ==
                                  //                                                     RequestStatus.oldRequest)
                                  //                                                     ? state
                                  //                                                     .requestedData!
                                  //                                                     .data![index]
                                  //                                                     .hardWareItemName!
                                  //                                                     .trim()
                                  //                                                     : state
                                  //                                                     .chosenList[index]
                                  //                                                     .selectedItem!
                                  //                                                     .hardWareItemName!
                                  //                                                     .trim(),
                                  //                                                 softWrap: true,
                                  //                                                 style: const TextStyle(fontSize: 18),
                                  //                                                 overflow: TextOverflow.ellipsis,
                                  //                                               ),
                                  //                                               subtitle: Text(
                                  //                                                 'Quantity: ${(state.requestStatus == RequestStatus.oldRequest) ? state.requestedData!.data![index].qty : state.chosenList[index].quantity}',
                                  //                                                 softWrap: true,
                                  //                                               ),
                                  //                                               children: [
                                  //                                                 Row(
                                  //                                                   children: [
                                  //                                                     const Text(
                                  //                                                       'Request for: ',
                                  //                                                       softWrap: true,
                                  //                                                       style:
                                  //                                                       TextStyle(fontSize: 18),
                                  //                                                     ),
                                  //                                                     Flexible(
                                  //                                                       child: Text(
                                  //                                                         (state.requestStatus ==
                                  //                                                             RequestStatus
                                  //                                                                 .oldRequest)
                                  //                                                             ? EquipmentsCubit.get(
                                  //                                                             context)
                                  //                                                             .getRequestForFromType(
                                  //                                                             state
                                  //                                                                 .requestedData!
                                  //                                                                 .data![index]
                                  //                                                                 .type!)!
                                  //                                                             .trim()
                                  //                                                             : state.chosenList[index]
                                  //                                                             .requestFor!
                                  //                                                             .trim(),
                                  //                                                         softWrap: true,
                                  //                                                         style: const TextStyle(
                                  //                                                             fontSize: 18),
                                  //                                                       ),
                                  //                                                     ),
                                  //                                                   ],
                                  //                                                 ),
                                  //                                                 // Row(
                                  //                                                 //   children: [
                                  //                                                 //     Text(
                                  //                                                 //       'Quantity: ${(state.requestStatus == RequestStatus.oldRequest) ? state.requestedData!.data![index].qty : state.chosenList[index].quantity}',
                                  //                                                 //       softWrap: true,
                                  //                                                 //       style: const TextStyle(fontSize: 18),
                                  //                                                 //     ),
                                  //                                                 //   ],
                                  //                                                 // ),
                                  //                                                 Row(
                                  //                                                   children: [
                                  //                                                     Flexible(
                                  //                                                       child: Text(
                                  //                                                         'Owner: ${(state.requestStatus == RequestStatus.oldRequest) ? state.requestedData!.data![index].ownerName!.trim().toTitleCase() : state.chosenList[index].selectedContact!.name!.trim().toTitleCase()}',
                                  //                                                         softWrap: false,
                                  //                                                         maxLines: 2,
                                  //                                                         overflow:
                                  //                                                         TextOverflow.ellipsis,
                                  //                                                         style: const TextStyle(
                                  //                                                             fontSize: 18),
                                  //                                                       ),
                                  //                                                     ),
                                  //                                                   ],
                                  //                                                 ),
                                  //                                                 Row(
                                  //                                                   children: [
                                  //                                                     Flexible(
                                  //                                                       child: Text(
                                  //                                                         'Estimate Price: ${(state.requestStatus == RequestStatus.oldRequest) ? ((state.requestedData!.data![index].estimatePrice == null) ? 'NO' : state.requestedData!.data![index].estimatePrice!.trim()) : (int.parse(state.chosenList[index].selectedItem!.estimatePrice!) * state.chosenList[index].quantity!).toString().trim()} LE',
                                  //                                                         softWrap: false,
                                  //                                                         maxLines: 2,
                                  //                                                         overflow:
                                  //                                                         TextOverflow.ellipsis,
                                  //                                                         style: const TextStyle(
                                  //                                                             fontSize: 18),
                                  //                                                       ),
                                  //                                                     ),
                                  //                                                   ],
                                  //                                                 ),
                                  //                                                 Row(
                                  //                                                   children: [
                                  //                                                     Flexible(
                                  //                                                       child: Text(
                                  //                                                         'Group name: ${(state.requestStatus == RequestStatus.oldRequest) ? state.requestedData!.data![index].groupName!.trim() : state.chosenList[index].selectedItem!.groupId!.toString().trim()}',
                                  //                                                         softWrap: false,
                                  //                                                         maxLines: 2,
                                  //                                                         overflow:
                                  //                                                         TextOverflow.ellipsis,
                                  //                                                         style: const TextStyle(
                                  //                                                             fontSize: 18),
                                  //                                                       ),
                                  //                                                     ),
                                  //                                                   ],
                                  //                                                 ),
                                  //                                               ],
                                  //                                             ),
                                  //                                           ),
                                  //                                           // Container(
                                  //                                           //   key: Key('value$index'),
                                  //                                           //   margin: const EdgeInsets.only(
                                  //                                           //     bottom: 8,
                                  //                                           //   ),
                                  //                                           //   padding: const EdgeInsets.all(10.0),
                                  //                                           //   width: MediaQuery.of(context).size.width,
                                  //                                           //   decoration: BoxDecoration(
                                  //                                           //       color: Colors.blueGrey,
                                  //                                           //       borderRadius: BorderRadius.circular(25)),
                                  //                                           //   child: Column(
                                  //                                           //     mainAxisAlignment: MainAxisAlignment.center,
                                  //                                           //     crossAxisAlignment: CrossAxisAlignment.start,
                                  //                                           //     children: [
                                  //                                           //       Center(
                                  //                                           //           child: (state.requestStatus ==
                                  //                                           //                   RequestStatus.oldRequest)
                                  //                                           //               ? EquipmentsCubit.get(context)
                                  //                                           //                   .getIconByGroupName(state
                                  //                                           //                       .requestedData!
                                  //                                           //                       .data![0]
                                  //                                           //                       .groupName!)
                                  //                                           //               : state.chosenList[index].icon!),
                                  //                                           //       Text(
                                  //                                           //         (state.requestStatus ==
                                  //                                           //                 RequestStatus.oldRequest)
                                  //                                           //             ? state.requestedData!.data![index]
                                  //                                           //                 .hardWareItemName!
                                  //                                           //                 .trim()
                                  //                                           //             : state.chosenList[index]
                                  //                                           //                 .selectedItem!.hardWareItemName!
                                  //                                           //                 .trim(),
                                  //                                           //         softWrap: true,
                                  //                                           //         style: const TextStyle(fontSize: 18),
                                  //                                           //       ),
                                  //                                           //       Text(
                                  //                                           //         (state.requestStatus ==
                                  //                                           //                 RequestStatus.oldRequest)
                                  //                                           //             ? EquipmentsCubit.get(context)
                                  //                                           //                 .getRequestForFromType(state
                                  //                                           //                     .requestedData!
                                  //                                           //                     .data![index]
                                  //                                           //                     .type!)!
                                  //                                           //                 .trim()
                                  //                                           //             : state.chosenList[index].requestFor!
                                  //                                           //                 .trim(),
                                  //                                           //         softWrap: true,
                                  //                                           //         style: const TextStyle(fontSize: 18),
                                  //                                           //       ),
                                  //                                           //       Text(
                                  //                                           //         'Qty: ${(state.requestStatus == RequestStatus.oldRequest) ? state.requestedData!.data![index].qty : state.chosenList[index].quantity}',
                                  //                                           //         softWrap: true,
                                  //                                           //         style: const TextStyle(fontSize: 18),
                                  //                                           //       ),
                                  //                                           //       Text(
                                  //                                           //         'Owner: ${(state.requestStatus == RequestStatus.oldRequest) ? state.requestedData!.data![index].ownerName!.trim() : state.chosenList[index].selectedContact!.name!.trim().toLowerCase()}',
                                  //                                           //         softWrap: false,
                                  //                                           //         maxLines: 2,
                                  //                                           //         overflow: TextOverflow.ellipsis,
                                  //                                           //         style: const TextStyle(fontSize: 18),
                                  //                                           //       ),
                                  //                                           //     ],
                                  //                                           //   ),
                                  //                                           // ),
                                  //                                         ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton:
                  BlocBuilder<EquipmentsCubit, EquipmentsCubitStates>(
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state.requestStatus == RequestStatus.oldRequest)
                        FloatingActionButton.extended(
                          heroTag: null,
                          onPressed: () {
                            // context.read<EquipmentsCubit>()
                            //     .submitAction(true);
                          },
                          icon: const Icon(Icons.verified),
                          label: const Text('Accept'),
                        ),
                      const SizedBox(height: 12),
                      if (state.requestStatus == RequestStatus.oldRequest)
                        FloatingActionButton.extended(
                          backgroundColor: Colors.red,
                          heroTag: null,
                          onPressed: () {},
                          icon: const Icon(Icons.dangerous),
                          label: const Text('Reject'),
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
                                locationFormKey.currentState!.getSelectedItem ==
                                    null ||
                                departmentFormKey
                                        .currentState!.getSelectedItem ==
                                    null) {
                              businessUnitFormKey.currentState!
                                  .popupOnValidate();
                              EasyLoading.showInfo(
                                'Fill All the fields',
                                maskType: EasyLoadingMaskType.black,
                              );
                            } else if (EquipmentsCubit.get(context)
                                .state
                                .chosenList
                                .isEmpty) {
                              EasyLoading.showInfo(
                                  'Add at least one item to request',
                                  maskType: EasyLoadingMaskType.black);
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
                              );
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (_) => const SuccessScreen(
                                            requestName: 'Equipment',
                                            routName:
                                                EquipmentsRequest.routeName,
                                            text: "Success",
                                          )));
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
            ),
          ),
        ),
      ),
    );
  }

  showAddRequestBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      backgroundColor: const Color(0xFF031A27),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      // useSafeArea: true,
      builder: (dialogContext) {
        return BottomSheet(
          // insetAnimationCurve: Curves.easeIn,
          // insetAnimationDuration: const Duration(milliseconds: 500),
          key: UniqueKey(), enableDrag: false,
          backgroundColor: const Color(0xFF031A27),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
          onClosing: () {},
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(10),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
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
                        HeroIcons.globe,
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
            );
          },
        );
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
        showEquipmentsDialog(context: context, name: name, id: id, icon: icon);
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

  showEquipmentsDialog(
      {required BuildContext context,
      required String name,
      required String id,
      required Widget icon}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF031A27),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (dialogContext) {
        return BottomSheet(
          // insetAnimationCurve: Curves.easeIn,
          // insetAnimationDuration: const Duration(milliseconds: 500),
          // backgroundColor: Colors.transparent,
          enableDrag: false,
          key: UniqueKey(),
          backgroundColor: const Color(0xFF031A27),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
          onClosing: () {},
          builder: (_) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text(name),
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  BlocProvider(
                    create: (context) =>
                        EquipmentsItemsCubit()..getEquipmentsItems(id: id),
                    child: BlocBuilder<EquipmentsItemsCubit,
                        EquipmentsItemsInitial>(
                      builder: (context, state) {
                        return buildDynamicDropDownMenu(
                          items: state.listEquipmentsItem,
                          listName: 'Select Item',
                          context: context,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: buildTextFormField(),
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
                  ElevatedButton.icon(
                    onPressed: () => onSubmitRequest(context, icon),
                    label: const Text('Done'),
                    icon: const Icon(Icons.done),
                  ),
                ],
              ),
            );
          },
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
        padding: const EdgeInsets.all(5.0),
        child: DropdownSearch<ContactsDataFromApi>(
          items: items,
          itemAsString: (contactKey) => contactKey.name!.trim(),
          key: ownerFormKey,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: listName,
              contentPadding: const EdgeInsets.all(10),
              icon: const Icon(
                Icons.people,
                color: Colors.white,
              ),
            ),
          ),
          popupProps: PopupProps.menu(
            showSearchBox: true,
            menuProps: MenuProps(
                backgroundColor: Theme.of(context).colorScheme.background,
                clipBehavior: Clip.hardEdge),
            fit: FlexFit.tight,
            searchFieldProps: const TextFieldProps(
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
        padding: const EdgeInsets.all(5.0),
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
          itemAsString: (equip) => equip.hardWareItemName!,
          dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                  labelText: listName,
                  contentPadding: const EdgeInsets.all(10),
                  icon: const Icon(
                    Icons.question_mark,
                    color: Colors.white,
                  ))),
          popupProps: PopupProps.menu(
              menuProps: MenuProps(
                backgroundColor: Theme.of(context).colorScheme.background,
              ),
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
        padding: const EdgeInsets.all(5.0),
        child: DropdownSearch<String?>(
          items: items,
          key: requestForFormKey,
          dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                  labelText: listName,
                  contentPadding: const EdgeInsets.all(10),
                  icon: const Icon(
                    Icons.question_mark,
                    color: Colors.white,
                  ))),
          popupProps: PopupProps.menu(
              menuProps: MenuProps(
                backgroundColor: Theme.of(context).colorScheme.background,
              ),
              showSearchBox: showSearch,
              fit: FlexFit.tight,
              searchFieldProps: const TextFieldProps(
                  padding: EdgeInsets.zero, scrollPadding: EdgeInsets.zero)),
        ),
      ),
    );
  }

  buildTextFormField() {
    controller.text = '1';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          fit: FlexFit.tight,
          child: IconButton(
            icon: const Icon(
              Icons.remove_circle,
              color: Colors.white,
            ),
            onPressed: () {
              int currentValue = int.parse(controller.text);
              currentValue--;
              controller.text = (currentValue > 1 ? currentValue : 1)
                  .toString(); // decrementing value
            },
          ),
        ),
        Flexible(
          flex: 2,
          child: TextFormField(
            textAlign: TextAlign.center,
            enabled: false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))
            ],
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: IconButton(
            icon: const Icon(
              Icons.add_circle,
              color: Colors.white,
            ),
            splashColor: Colors.transparent,
            onPressed: () {
              int currentValue = int.parse(controller.text);
              currentValue++;
              controller.text = (currentValue).toString(); // incrementing value
            },
          ),
        ),
      ],
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
