import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/models/appraisal_models/object_appraisal_model.dart';
import 'package:percent_indicator/percent_indicator.dart';

class EmployeeAppraisalTicketWidget extends StatelessWidget {

  final List<ObjectAppraisalModel> employeeAppraisaleList;

  const EmployeeAppraisalTicketWidget(this.employeeAppraisaleList, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      maintainBottomViewPadding: true,
      child: ConditionalBuilder(
        condition: employeeAppraisaleList.isNotEmpty,
        builder: (context) =>
            GridView.builder(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                    .onDrag,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // childAspectRatio: (1 / .4),
                  // width between items
                  crossAxisSpacing: 2,
                  // height between items
                  mainAxisSpacing: 2,
                ),
                itemCount: employeeAppraisaleList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: CircularPercentIndicator(
                      radius: 70.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: employeeAppraisaleList[index].value / 100,
                      center: Text(
                        "${employeeAppraisaleList[index].value}%",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      footer: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          employeeAppraisaleList[index].name,
                          style:
                          const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15.0),
                        ),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: ConstantsColors.backgroundEndColor,
                    ),
                  );
                }
            ),
        fallback: (context) => const Center(child: CircularProgressIndicator(color: Colors.white,)),
      ),
    );
  }
}