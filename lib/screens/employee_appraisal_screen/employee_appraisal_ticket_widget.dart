import 'package:circular/circular.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/data/models/appraisal_models/object_appraisal_model.dart';

// ignore: must_be_immutable
class EmployeeAppraisalTicketWidget extends StatelessWidget{

  List<ObjectAppraisalModel> employeeAppraisaleList;

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
                // width between items
                crossAxisSpacing: 2,
                // height between items
                mainAxisSpacing: 2,
              ),
              itemCount: employeeAppraisaleList.length,

              itemBuilder: (BuildContext context,int index){
                return  Container(

                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Text(
                          employeeAppraisaleList[index].name,
                          style: const TextStyle(fontSize: 20,color: Colors.white)
                      ),

                      CircularViewer(


                        value: employeeAppraisaleList[index].value,
                        maxValue: 100,
                        radius: 65,

                        textStyle: const TextStyle(fontSize: 25),
                        color: const Color(0xffEEEEEE),
                        sliderColor: const Color(0xff62CBDA),
                        unSelectedColor: const Color(0xffD7DEE7),
                      )
                    ],
                  ),
                );
              }
          ),
          fallback: (context) => const Center(child: LinearProgressIndicator()),

        ),
    );

  }

}