import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hassanallamportalflutter/bloc/admin_requests_screen_bloc/business_card_request/business_card_cubit.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/permission_request.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/embassy_letter_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/permission_request_screen/permission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/vacation_request_screen/vacation_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/access_right_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/email_and_useraccount_screen.dart';

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
                crossAxisSpacing: 30,
                // height between items
                mainAxisSpacing: 30,
              ),
              itemCount: listFromRequestScreen.length,
              itemBuilder: (BuildContext context, int index) {
                List<String> rDate = listFromRequestScreen[index]["rDate"]
                    .toString().split('T');

                String status_Name = listFromRequestScreen[index]["status_Name"];
                String service_Name = listFromRequestScreen[index]["service_Name"];

                return SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      switch (service_Name) {
                        case "Vacation Request":
                          {
                            Navigator.of(context).pushNamed(VacationScreen.routeName);
                            break;
                          }

                        case "Permission":
                          {
                            Navigator.of(context).pushNamed(PermissionScreen.routeName);
                            break;
                          }
                        case "Business Mission":
                          {
                            Navigator.of(context).pushNamed(BusinessMissionScreen.routeName);
                            break;
                          }
                        case "Embassy Letter":
                          {
                            Navigator.of(context).pushNamed(EmbassyLetterScreen.routeName);
                            break;
                          }
                        case "Email Account":
                          {
                            Navigator.of(context).pushNamed(EmailAndUserAccountScreen.routeName);
                            break;
                          }
                        case "Business Card Request":
                          {
                            Navigator.of(context).pushNamed(BusinessMissionScreen.routeName);
                            break;
                          }
                        case "Access Right IT" :
                          {
                            Navigator.of(context).pushNamed(AccessUserAccountScreen.routeName);
                            break;
                          }
                      }
                    },
                    child: Container(

                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(service_Name,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16)),
                          MyRequestStatus(status_Name, context),
                          Text(rDate[0],
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
        fallback: (context) => const Center(child: LinearProgressIndicator()),
      ),
    );
  }

  dynamic MyRequestStatus(String status_Name, BuildContext context) {
    switch (status_Name) {
      case "Approved" :
        {
          return Row(children: [
            Text(status_Name),
            Icon(Icons.verified, color: Colors.green,),
          ],
            crossAxisAlignment: CrossAxisAlignment.center,
          );
        }
      case "Rejected" :
        {
          return Row(children: [
            Text(status_Name),
            Icon(Icons.cancel, color: Colors.red,)
          ],
            crossAxisAlignment: CrossAxisAlignment.center,);
        }
      default:
        {
          return Row(children: [
            Text(status_Name),
            Icon(Icons.camera, color: Colors.yellow,)
          ],
            crossAxisAlignment: CrossAxisAlignment.center,);
        }
    }
  }
}