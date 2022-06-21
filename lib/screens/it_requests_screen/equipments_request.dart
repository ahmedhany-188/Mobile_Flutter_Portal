import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EquipmentsRequest extends StatelessWidget {
  const EquipmentsRequest({Key? key}) : super(key: key);
  static const routeName = 'request-equipments-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Equipments request')),
      resizeToAvoidBottomInset: false,
      body: Sizer(
        builder: (sizerContext, orientation, deviceType) {
          return SizedBox(
            width: 100.w,
            height: 100.h,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownSearch(
                          items: const [
                            "Brazil",
                            "France",
                            "Tunisia",
                            "Canada"
                          ],
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration:
                                  InputDecoration(labelText: 'Business Unit')),
                          popupProps: const PopupProps.dialog()),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownSearch(
                        items: const ["Brazil", "France", "Tunisia", "Canada"],
                        dropdownButtonProps: const DropdownButtonProps(
                          color: Colors.red,
                        ),
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration:
                                InputDecoration(labelText: 'Location')),
                        popupProps: PopupProps.bottomSheet(
                          showSearchBox: true,
                          title: AppBar(
                              title: Text('Choose fuckin Name'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)))),
                          showSelectedItems: false,
                          searchDelay: Duration.zero,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownSearch(
                        items: const ["Brazil", "France", "Tunisia", "Canada"],
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration:
                                InputDecoration(labelText: 'Department')),
                        popupProps: PopupProps.bottomSheet(
                          showSearchBox: true,
                          title: AppBar(
                              title: Text('Choose fuckin Name'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)))),
                          showSelectedItems: false,
                          searchDelay: Duration.zero,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: sizerContext,
                          builder: (dialogContext) {
                            return Dialog(
                              child: Container(
                                height: 100.h,
                                width: 100.w,
                                color: Colors.grey,
                              child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 10.sp,
                                        crossAxisSpacing: 10.sp,),
                                keyboardDismissBehavior:
                                    ScrollViewKeyboardDismissBehavior.onDrag,
                                itemCount: 11,
                                itemBuilder: (ctx, index) {
                                  return Container(
                                    width: 20.w,
                                    height: 20.h,
                                    // padding: EdgeInsets.all(20),
                                    margin: EdgeInsets.all(20),
                                    color: Colors.red,
                                  );
                                },
                              ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Text('Add Request'),
                    ),
                  ),
                  // Container(
                  //   height: 20.h,
                  //   color: Colors.grey,
                  //   child: ListView.builder(
                  //       shrinkWrap: true,
                  //       scrollDirection: Axis.horizontal,
                  //       keyboardDismissBehavior:
                  //           ScrollViewKeyboardDismissBehavior.onDrag,
                  //       itemCount: 11,
                  //       itemBuilder: (ctx, index) {
                  //         return Container(
                  //           width: 20.w,
                  //           height: 20.h,
                  //           // padding: EdgeInsets.all(20),
                  //           margin: EdgeInsets.all(20),
                  //           color: Colors.red,
                  //         );
                  //       }),
                  // ),
                ]),
          );
        },
      ),
    );
  }
}
