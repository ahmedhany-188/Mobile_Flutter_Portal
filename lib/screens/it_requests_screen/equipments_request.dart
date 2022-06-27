import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/it_request_bloc/equipments_request/equipments_items_cubit/equipments_items_cubit.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/equipments_models/business_unit_model.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/equipments_models/equipments_items_model.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/equipments_models/equipments_location_model.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/contacts_screen_bloc/contacts_cubit.dart';
import '../../data/models/contacts_related_models/contacts_data_from_api.dart';
import '../../bloc/it_request_bloc/equipments_request/equipments_cubit/equipments_cubit.dart';
import '../../data/models/it_requests_form_models/equipments_models/departments_model.dart';

class EquipmentsRequest extends StatelessWidget {
  const EquipmentsRequest({Key? key}) : super(key: key);
  static const routeName = 'request-equipments-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Equipments request')),
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => EquipmentsCubit()..getAll(),
        child: Sizer(
          builder: (sizerContext, orientation, deviceType) {
            return SizedBox(
              width: 100.w,
              height: 100.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<EquipmentsCubit, EquipmentsCubitStates>(
                    builder: (context, state) {
                      return Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownSearch<BusinessUnitModel>(
                              items: state.listBusinessUnit,
                              itemAsString: (bussinessUnit) =>
                                  bussinessUnit.departmentName!,
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          labelText: 'Business Unit')),
                              popupProps: const PopupProps.dialog(
                                  showSearchBox: true,
                                  searchDelay: Duration.zero)),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<EquipmentsCubit, EquipmentsCubitStates>(
                    builder: (context, state) {
                      return Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownSearch<EquipmentsLocationModel>(
                            items: state.listLocation,
                            itemAsString: (loc) => loc.projectName!,
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                                    dropdownSearchDecoration:
                                        InputDecoration(labelText: 'Location')),
                            popupProps: PopupProps.bottomSheet(
                              showSearchBox: true,
                              title: AppBar(
                                  title: const Text('Choose fuckin Name'),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)))),
                              showSelectedItems: false,
                              searchDelay: Duration.zero,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<EquipmentsCubit, EquipmentsCubitStates>(
                    builder: (context, state) {
                      return Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownSearch<DepartmentsModel>(
                            items: state.listDepartment,
                            itemAsString: (dept) => dept.departmentName!,
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                        labelText: 'Department')),
                            popupProps: PopupProps.bottomSheet(
                              showSearchBox: true,
                              title: AppBar(
                                  title: const Text('Choose fuckin Name'),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)))),
                              showSelectedItems: false,
                              searchDelay: Duration.zero,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showAddRequestDialog(sizerContext);
                    },
                    child: const Text('Add Request'),
                  ),
                  SizedBox(
                    height: 60.h,
                    child: ListView.builder(
                        clipBehavior: Clip.hardEdge,
                        itemCount: 1,
                        itemBuilder: (listViewContext, index) {
                          return Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            behavior: HitTestBehavior.deferToChild,
                            background: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                ),
                                padding: EdgeInsets.all(10.sp),
                                margin:
                                    EdgeInsets.only(bottom: 8.sp, top: 8.sp),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.delete, size: 30.sp))),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 8.sp, top: 8.sp),
                              width: 100.w,
                              height: 20.h,
                              color: Colors.blueGrey,
                              child: Padding(
                                padding: EdgeInsets.all(10.0.sp),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.laptop, size: 25.sp),
                                        Text(
                                          'Laptop',
                                          softWrap: true,
                                          style: TextStyle(fontSize: 18.sp),
                                        ),
                                        Text(
                                          'replacement',
                                          softWrap: true,
                                          style: TextStyle(fontSize: 18.sp),
                                        ),
                                        Text(
                                          'Qty: 1',
                                          softWrap: true,
                                          style: TextStyle(fontSize: 18.sp),
                                        ),
                                      ],
                                    ),
                                    Flexible(
                                        child: Text(
                                      'Responsible person: Omar Amir Elsayed mohammed hasan',
                                      softWrap: true,
                                      style: TextStyle(fontSize: 18.sp),
                                    )),
                                    // Text('Request for:  replacement'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            );
          },
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
        showEquipmentsDialog(context: context, name: name, id: id);
      },
      child: Container(
        width: 20.w,
        height: 20.h,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Colors.red,
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
      required String id}) {
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
                    BlocProvider(
                      create: (context) =>
                          EquipmentsItemsCubit()..getEquipmentsItems(id: id),
                      child: BlocBuilder<EquipmentsItemsCubit,
                          EquipmentsItemsInitial>(
                        builder: (context, state) {
                          return buildDynamicDropDownMenu(
                              items: state.listEquipmentsItem,
                              listName: 'Select Item');
                        },
                      ),
                    ),
                    buildTextFormField(),
                    BlocBuilder<ContactsCubit, ContactCubitStates>(
                      builder: (context, state) {
                        return buildContactsDropDownMenu(
                          listName: 'Owner Employee',
                          items: ContactsCubit.get(context).state.listContacts,
                        );
                      },
                    ),
                    buildDropDownMenu(items: [
                      'New Hire',
                      'Replacement',
                      'Training',
                      'Mobilization'
                    ], listName: 'Request For'),
                    BlocBuilder<EquipmentsCubit, EquipmentsCubitStates>(
                      builder: (context, state) {
                        return ElevatedButton.icon(
                          onPressed: () => onSubmitRequest(),
                          label: const Text('Done'),
                          icon: const Icon(Icons.done),
                        );
                      },
                    )
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
  }) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DropdownSearch<ContactsDataFromApi>(
          items: items,
          itemAsString: (contactKey) => contactKey.name!.trim(),
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
                  icon: Icon(Icons.search),
                  hintText: 'Search for name',
                ),
              )),
        ),
      ),
    );
  }

  buildDynamicDropDownMenu(
      {required List<EquipmentsItemModel> items,
      required String listName,
      bool showSearch = false}) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DropdownSearch<EquipmentsItemModel>(
          items: items,
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
      bool showSearch = false}) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DropdownSearch<String?>(
          items: items,
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
    TextEditingController controller = TextEditingController();
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

  onSubmitRequest() {}
}
