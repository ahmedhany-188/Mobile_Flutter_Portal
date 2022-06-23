import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/contacts_screen_bloc/contacts_cubit.dart';
import 'package:hassanallamportalflutter/data/models/contacts_related_models/contacts_data_from_api.dart';
import '../../bloc/it_request_bloc/equipments_request/business_unit_cubit/business_unit_cubit.dart';
import 'package:sizer/sizer.dart';

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
                      List<String?> businessUnitList = [];
                      for (int i = 0; i < state.listBusinessUnit.length; i++) {
                        businessUnitList
                            .add(state.listBusinessUnit[i].departmentName);
                      }
                      return Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownSearch(
                              items: businessUnitList,
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          labelText: 'Business Unit')),
                              popupProps: const PopupProps.dialog()),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<EquipmentsCubit, EquipmentsCubitStates>(
                    builder: (context, state) {
                      List<String?> location = [];
                      for (int i = 0; i < state.listLocation.length; i++) {
                        location
                            .add(state.listLocation[i].projectName.toString());
                      }
                      return Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownSearch(
                            items: location,
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
                      List<String?> department = [];
                      for (int i = 0; i < state.listDepartment.length; i++) {
                        department.add(state.listDepartment[i].departmentName);
                      }
                      return Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownSearch(
                            items: department,
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
                      showAddRequestDialog(context);
                    },
                    child: const Text('Add Request'),
                  ),
                  SizedBox(
                    height: 60.h,
                    child: ListView.builder(clipBehavior: Clip.hardEdge,itemCount: 11,itemBuilder: (listViewContext, index){
                      return Container(margin: const EdgeInsets.only(bottom: 10,top: 10),width: 100.w,height: 20.h,color: Colors.blueGrey,);
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

  buildContactsDropDownMenu(
      {required List<ContactsDataFromApi> items,
      required String listName,
      bool showSearch = false}) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DropdownSearch<ContactsDataFromApi>(
          items: items,
          itemAsString: (contactKey) => contactKey.name!.trim(),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: listName,
              contentPadding: EdgeInsets.zero,icon: const Icon(Icons.people)
            ),
          ),
          popupProps: PopupProps.menu(
              showSearchBox: showSearch,
              fit: FlexFit.loose,
              searchFieldProps: const TextFieldProps(
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

  buildDropDownMenu(
      {required List<String?> items,
      required String listName,
      bool showSearch = false}) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DropdownSearch(
          items: items,
          dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(labelText: listName,contentPadding: EdgeInsets.zero,icon: const Icon(Icons.question_mark))),
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
              // setState(() {
              currentValue++;
              controller.text = (currentValue).toString(); // incrementing value
              // });
            },
          ),
        ),
      ],
    );
  }

  showAddRequestDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          insetAnimationCurve: Curves.easeIn,
          insetAnimationDuration:
          const Duration(milliseconds: 500),
          key: UniqueKey(),
          shape: const RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(25))),
          child: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(10.sp),
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.sp,
              crossAxisSpacing: 10.sp,
            ),
            keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: 11,
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () {
                  showEquipmentsDialog(context);
                },
                child: Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(25)),
                    color: Colors.red,
                  ),
                  child:
                  Center(child: Text('${index + 1}')),
                ),
              );
            },
          ),
        );
      },
    );
  }
  showEquipmentsDialog(BuildContext context){
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          insetAnimationCurve: Curves.easeIn,
          insetAnimationDuration:
          const Duration(
              milliseconds: 500),
          key: UniqueKey(),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(25))),
          child: SizedBox(
            width: 90.w,
            height: 70.h,
            child: ClipRRect(
              borderRadius:
              BorderRadius.circular(25),
              child: Scaffold(
                appBar: AppBar(
                    title:
                    const Text('Laptop')),
                body: Column(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .center,
                  children: [
                    buildDropDownMenu(
                        items: ['Laptop'],
                        listName:
                        'Select Item'),
                    buildTextFormField(),
                    buildContactsDropDownMenu(
                        listName:
                        'Owner Employee',
                        items:
                        ContactsCubit.get(
                            context)
                            .state
                            .listContacts,
                        showSearch: true),
                    buildDropDownMenu(
                        items: [
                          'New Hire',
                          'Replacement',
                          'Training',
                          'Mobilization'
                        ],
                        listName:
                        'Request For'),
                    ElevatedButton.icon(
                      onPressed: () {},
                      label:
                      const Text('Done'),
                      icon: const Icon(
                          Icons.done),
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
}
