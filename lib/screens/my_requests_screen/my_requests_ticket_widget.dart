

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hassanallamportalflutter/screens/my_requests_screen/my_requests_screen.dart';

class MyReqyestsTicketWidget extends StatelessWidget {


  final List<dynamic> listFromRequestScreen;

  const MyReqyestsTicketWidget(this.listFromRequestScreen, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      maintainBottomViewPadding: true,
      child: ConditionalBuilder(
        condition: listFromRequestScreen.isNotEmpty,

        builder: (context) =>
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                  .onDrag,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                // childAspectRatio: (1 / .4),
                mainAxisExtent: 90, // here set custom Height You Want
                // width between items
                crossAxisSpacing: 2,
                // height between items
                mainAxisSpacing: 2,
              ),
              itemCount: listFromRequestScreen.length,
              itemBuilder: (BuildContext context, int index) {

                List<String> rDate = listFromRequestScreen[index]["rDate"]
                    .toString().split('-');

                String status_Name = listFromRequestScreen[index]["status_Name"];
                String service_Name = listFromRequestScreen[index]["service_Name"];

                return SizedBox(
                  width: double.infinity,
                  child: InkWell(

                    child: Container(
                        child: Text(status_Name + "/" + service_Name,
                            style: const TextStyle(color: Colors.white)),
                        height: 65,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(5)),
                          color: Colors.grey,
                        ),
                        alignment: Alignment.center,
                        width: double.infinity,),
                  ),
                );


              },
            ),
        fallback: (context) => const Center(child: LinearProgressIndicator()),
      ),
    );
  }
}