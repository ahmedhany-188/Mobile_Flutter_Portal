import 'package:circular/circular.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeAppraisalTicketWidget extends StatelessWidget{

  List<dynamic> employeeAppraisaleList;

  EmployeeAppraisalTicketWidget(this.employeeAppraisaleList,{Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(

        maintainBottomViewPadding: true,
        child: ConditionalBuilder(
          condition: employeeAppraisaleList.isNotEmpty,
        builder: (context)=>
          GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // childAspectRatio: (1 / .4),
                mainAxisExtent: 90, // here set custom Height You Want
                // width between items
                crossAxisSpacing: 2,
                // height between items
                mainAxisSpacing: 2,
              ),
              itemCount: employeeAppraisaleList.length,

              itemBuilder: (BuildContext context,int index){
                return  Container(
                  color: const Color(0xffEEEEEE),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircularViewer(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(-10, -10),
                                  color: Colors.white,
                                  blurRadius: 20,
                                  spreadRadius: 1),
                              BoxShadow(
                                  offset: Offset(10, 10),
                                  color: Color.fromARGB(255, 158, 158, 158),
                                  blurRadius: 20,
                                  spreadRadius: 1)
                            ]),
                        value: employeeAppraisaleList[index],
                        maxValue: 100,
                        radius: 100,
                        textStyle: const TextStyle(fontSize: 30),
                        color: const Color(0xffEEEEEE),
                        sliderColor: const Color(0xff62CBDA),
                        unSelectedColor: const Color(0xffD7DEE7),
                      )
                    ],
                  ),
                  alignment: Alignment.center,
                );
              }
          ),
          fallback: (context) => const Center(child: LinearProgressIndicator()),

        ),
    );


  }


}