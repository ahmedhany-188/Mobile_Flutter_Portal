import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../constants/enums.dart';
import '../../data/repositories/request_repository.dart';
import '../../bloc/contacts_screen_bloc/contacts_cubit.dart';
import '../../data/models/contacts_related_models/contacts_data_from_api.dart';
import '../../data/models/it_requests_form_models/equipments_models/departments_model.dart';
import '../../bloc/it_request_bloc/equipments_request/equipments_cubit/equipments_cubit.dart';
import '../../data/models/it_requests_form_models/equipments_models/business_unit_model.dart';
import '../../data/models/it_requests_form_models/equipments_models/equipments_items_model.dart';
import '../../data/models/it_requests_form_models/equipments_models/equipments_location_model.dart';
import '../../data/models/it_requests_form_models/equipments_models/selected_equipments_model.dart';
import '../../bloc/it_request_bloc/equipments_request/equipments_items_cubit/equipments_items_cubit.dart';
import '../../widgets/success/success_request_widget.dart';

class EquipmentsRequest extends StatelessWidget {
  EquipmentsRequest({Key? key, this.requestData}) : super(key: key);
  static const routeName = 'request-equipments-screen';
  final  dynamic requestData;

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
    return WillPopScope(
      onWillPop: () async {
        await EasyLoading.dismiss(animation: true);
        return true;
      },
      child: BlocProvider<EquipmentsCubit>(
        create: (context) =>
            (EquipmentsCubit(RequestRepository(user))..getRequestData(requestStatus: RequestStatus.newRequest)..getAll()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Equipment request'),
          ),
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Sizer(
            builder: (sizerContext, orientation, deviceType) {
              return SizedBox(
                width: 100.w,
                height: 100.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 1.5.h,
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
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: 'Business Unit',
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                            popupProps: PopupProps.modalBottomSheet(
                              showSearchBox: true,
                              interceptCallBacks: true,
                              searchDelay: Duration.zero,
                              title: AppBar(
                                  title: const Text('Business Unit',
                                      style: TextStyle(color: Colors.black)),
                                  iconTheme: const IconThemeData.fallback(),
                                  centerTitle: true,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0),
                              listViewProps: const ListViewProps(
                                  padding: EdgeInsets.zero,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  keyboardDismissBehavior:
                                      ScrollViewKeyboardDismissBehavior.onDrag),
                              modalBottomSheetProps:
                                  const ModalBottomSheetProps(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20))),
                              ),
                              searchFieldProps: const TextFieldProps(
                                padding: EdgeInsets.all(20),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  isCollapsed: true,
                                  filled: true,
                                  hintText: "Search by name",
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide.none),
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
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: 'Location',
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                            popupProps: PopupProps.modalBottomSheet(
                              showSearchBox: true,
                              searchDelay: Duration.zero,
                              interceptCallBacks: true,
                              modalBottomSheetProps:
                                  const ModalBottomSheetProps(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20))),
                              ),
                              title: AppBar(
                                  title: const Text('Location',
                                      style: TextStyle(color: Colors.black)),
                                  iconTheme: const IconThemeData.fallback(),
                                  centerTitle: true,
                                  backgroundColor: Colors.transparent,
                                  titleSpacing: 0,
                                  elevation: 0),
                              searchFieldProps: const TextFieldProps(
                                padding: EdgeInsets.all(20),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    isCollapsed: true,
                                    filled: true,
                                    labelText: "Search for location",
                                    hintText: "Search for location",
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide.none)),
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
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                              labelText: 'Department',
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            )),
                            popupProps: const PopupProps.modalBottomSheet(
                              showSearchBox: true,
                              searchDelay: Duration.zero,
                              title: Center(
                                child: Text('Department',
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                              ),
                              modalBottomSheetProps: ModalBottomSheetProps(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20)))),
                              searchFieldProps: TextFieldProps(
                                padding: EdgeInsets.all(20),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    isCollapsed: true,
                                    filled: true,
                                    labelText: "Search for department",
                                    hintText: "Search for department",
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide.none)),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<EquipmentsCubit, EquipmentsCubitStates>(
                      builder: (context, state) {
                        return (EquipmentsCubit.get(context).state
                            .requestStatus == RequestStatus.newRequest)?
                         ElevatedButton.icon(
                          onPressed: () {
                            showAddRequestDialog(context);
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Request Item'),
                          style: ElevatedButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.padded,
                              primary: Colors.blueGrey),
                        ):Container();
                      },
                    ),
                    SizedBox(
                      height: 60.h,
                      child:
                          BlocBuilder<EquipmentsCubit, EquipmentsCubitStates>(
                        buildWhen: (prev, current) {
                          return prev.chosenList.length !=
                              current.chosenList.length;
                        },
                        builder: (context, state) {
                          return ListView.builder(
                            clipBehavior: Clip.hardEdge,
                            itemCount: state.chosenList.length,
                            padding: EdgeInsets.all(5.sp),
                            itemBuilder: (listViewContext, index) {
                              return Dismissible(
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
                                          title: const Text('Caution',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                          content: const Text(
                                              'Are you sure you want to delete this item?',
                                              style: TextStyle(
                                                  color: Colors.black)),
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
                                                Navigator.of(context).pop(true);
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
                                secondaryBackground: Container(
                                  clipBehavior: Clip.none,
                                  margin: EdgeInsets.only(
                                    bottom: 8.sp,
                                  ),
                                  padding: EdgeInsets.all(10.0.sp),
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.delete,
                                      size: 30.sp,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                background: Container(
                                  clipBehavior: Clip.none,
                                  margin: EdgeInsets.only(
                                    bottom: 8.sp,
                                  ),
                                  padding: EdgeInsets.all(10.0.sp),
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      Icons.edit,
                                      size: 30.sp,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  key: Key('value$index'),
                                  margin: EdgeInsets.only(
                                    bottom: 8.sp,
                                  ),
                                  padding: EdgeInsets.all(10.0.sp),
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                          child: state.chosenList[index].icon!),
                                      Text(
                                        state.chosenList[index].selectedItem!
                                            .hardWareItemName!
                                            .trim(),
                                        softWrap: true,
                                        style: TextStyle(fontSize: 18.sp),
                                      ),
                                      Text(
                                        state.chosenList[index].requestFor!
                                            .trim(),
                                        softWrap: true,
                                        style: TextStyle(fontSize: 18.sp),
                                      ),
                                      Text(
                                        'Qty: ${state.chosenList[index].quantity}',
                                        softWrap: true,
                                        style: TextStyle(fontSize: 18.sp),
                                      ),
                                      Text(
                                        'Owner: ${state.chosenList[index].selectedContact!.name!.trim().toLowerCase()}',
                                        softWrap: false,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 18.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          floatingActionButton:
              BlocBuilder<EquipmentsCubit, EquipmentsCubitStates>(
            builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(state
                        .requestStatus == RequestStatus.newRequest)
                    FloatingActionButton.extended(
                    label: const Text('Submit'),
                    icon: const Icon(Icons.save),
                    onPressed: () {
                      if (businessUnitFormKey.currentState!.getSelectedItem ==
                              null ||
                          locationFormKey.currentState!.getSelectedItem == null ||
                          departmentFormKey.currentState!.getSelectedItem == null) {
                        businessUnitFormKey.currentState!.popupOnValidate();
                        EasyLoading.showInfo(
                          'Fill All the fields',
                          maskType: EasyLoadingMaskType.black,
                        );
                      } else if (EquipmentsCubit.get(context)
                          .state
                          .chosenList
                          .isEmpty) {
                        EasyLoading.showInfo('Add at least one item to request',
                            maskType: EasyLoadingMaskType.black);
                      } else {
                        EquipmentsCubit.get(context).postEquipmentsRequest(
                          departmentObject:
                              departmentFormKey.currentState!.getSelectedItem!,
                          businessUnitObject:
                              businessUnitFormKey.currentState!.getSelectedItem!,
                          locationObject:
                              locationFormKey.currentState!.getSelectedItem!,
                          userHrCode: user.employeeData!.userHrCode!,
                          selectedItem: state.chosenList,
                        );
                        ;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) => const SuccessScreen(
                                  requestName: 'Equipment',
                                  routName: EquipmentsRequest.routeName,
                                  text: "Success",
                                )));
                      }
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    tooltip: 'Save Request',
              ),
                  ],
                );
            },
          ),
        ),
      ),
    );
  }

  showAddRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (dialogContext) {
        return Dialog(
          insetAnimationCurve: Curves.easeIn,
          insetAnimationDuration: const Duration(milliseconds: 500),
          key: UniqueKey(),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: GridView(
            shrinkWrap: true,
            padding: EdgeInsets.all(10.sp),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.sp,
              crossAxisSpacing: 10.sp,
            ),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              addRequestOptions(
                  id: '8',
                  context: context,
                  name: 'Accessories',
                  icon: const Icon(Icons.keyboard_alt_outlined)),
              addRequestOptions(
                  id: '2',
                  context: context,
                  name: 'Laptop',
                  icon: const Icon(Icons.laptop_chromebook_outlined)),
              addRequestOptions(
                  id: '9',
                  context: context,
                  name: 'Datashow / projector',
                  icon: const Icon(Icons.live_tv)),
              addRequestOptions(
                  id: '1',
                  context: context,
                  name: 'Desktop',
                  icon: const Icon(Icons.computer_outlined)),
              addRequestOptions(
                  id: '7',
                  context: context,
                  name: 'Fingerprint',
                  icon: const Icon(Icons.fingerprint)),
              addRequestOptions(
                  id: '11',
                  context: context,
                  name: 'Internet connection',
                  icon: const Icon(Icons.network_wifi_outlined)),
              addRequestOptions(
                  id: '10',
                  context: context,
                  name: 'Telephones',
                  icon: const Icon(Icons.call)),
              addRequestOptions(
                  id: '4',
                  context: context,
                  name: 'Printer',
                  icon: const Icon(Icons.print_outlined)),
              addRequestOptions(
                  id: '3',
                  context: context,
                  name: 'Server',
                  icon: const HeroIcon(HeroIcons.server)),
              addRequestOptions(
                  id: '6',
                  context: context,
                  name: 'Network',
                  icon: const HeroIcon(HeroIcons.globe)),
              addRequestOptions(
                  id: '14',
                  context: context,
                  name: 'Toner/Ink',
                  icon: const Icon(Icons.water_drop)),
            ],
          ),
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
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      child: Container(
        width: 20.w,
        height: 20.h,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          gradient: LinearGradient(
              colors: [
                Color(0xFF1a4c78),
                Color(0xFF3772a6),
                Colors.white,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topRight,
              tileMode: TileMode.clamp),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            Text(name, softWrap: true, textAlign: TextAlign.center),
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
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          insetAnimationCurve: Curves.easeIn,
          insetAnimationDuration: const Duration(milliseconds: 500),
          key: UniqueKey(),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: SizedBox(
            width: 90.w,
            height: 70.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Scaffold(
                appBar: AppBar(title: Text(name)),
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
                            items:
                                ContactsCubit.get(context).state.listContacts,
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
        padding: const EdgeInsets.all(5.0),
        child: DropdownSearch<ContactsDataFromApi>(
          items: items,
          itemAsString: (contactKey) => contactKey.name!.trim(),
          key: ownerFormKey,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                labelText: listName,
                contentPadding: EdgeInsets.zero,
                icon: const Icon(Icons.people)),
          ),
          popupProps: const PopupProps.menu(
              showSearchBox: true,
              fit: FlexFit.loose,
              searchFieldProps: TextFieldProps(
                padding: EdgeInsets.all(20),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    isCollapsed: true,
                    filled: true,
                    labelText: "Search for name",
                    hintText: "Search for name",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none)),
              )),
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
                  contentPadding: EdgeInsets.zero,
                  icon: const Icon(Icons.question_mark))),
          popupProps: PopupProps.menu(
              showSearchBox: showSearch,
              fit: FlexFit.loose,
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
                  contentPadding: EdgeInsets.zero,
                  icon: const Icon(Icons.question_mark))),
          popupProps: PopupProps.menu(
              showSearchBox: showSearch,
              fit: FlexFit.loose,
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
            icon: const Icon(Icons.remove_circle),
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
            icon: const Icon(Icons.add_circle),
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
      } catch (_) {
        EasyLoading.showError('You already add this item',
            maskType: EasyLoadingMaskType.black);
      }
    }
  }
}
