import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/data/models/myattendance_model.dart';
import 'package:hassanallamportalflutter/widgets/dialogpopoup/dialog_popup_userprofile.dart';
import '../../widgets/dialogpopoup/dialog_popup_attendance.dart';

// ignore: must_be_immutable
class AttendanceTicketWidgetDefault extends StatelessWidget {
  String type;
  int number;

  AttendanceTicketWidgetDefault(this.type, this.number, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      maintainBottomViewPadding: true,
      child: ConditionalBuilder(
        condition: true,
        builder: (context) =>
            GridView.builder(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                    .onDrag,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  // childAspectRatio: (1 / .4),
                  mainAxisExtent: 90, // here set custom Height You Want
                  // width between items
                  crossAxisSpacing: 2,
                  // height between items
                  mainAxisSpacing: 2,
                ),
                itemCount: number,
                itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: double.infinity,
                      child: Column(children: [
                        Text(type,
                            style: const TextStyle(color: Colors.white)),
                        Container(
                          height: 30,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            color: Colors.grey,
                          ),
                          alignment: Alignment.center,
                          width: double.infinity,
                        ),
                        Container(height: 5, color: Colors.white,),
                        Container(
                          height: 30,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5)),
                            color: Colors.grey,
                          ),
                          alignment: Alignment.center,
                          width: double.infinity,
                        ),
                      ]),
                    );
                }
            ),
        fallback: null, //(context) => const Center(child: LinearProgressIndicator()),
      ),
    );
  }
}
