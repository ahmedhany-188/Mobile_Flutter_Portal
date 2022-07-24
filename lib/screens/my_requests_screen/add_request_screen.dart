import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/business_card_screen.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/embassy_letter_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/vacation_request_screen/vacation_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/access_right_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/email_and_useraccount_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/equipments_request.dart';
import 'package:sizer/sizer.dart';

import '../hr_requests_screen/permission_request_screen/permission_screen.dart';

class AddRequestScreen extends StatelessWidget {
  const AddRequestScreen({Key? key}) : super(key: key);
  static const routeName = 'add-request-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Sizer(
        builder: (BuildContext context, Orientation orientation,
            DeviceType deviceType) {
          return ListView(
            children: [
              Card(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ExpansionTile(
                  expandedAlignment: Alignment.centerLeft,
                  leading: const Icon(Icons.usb, size: 40),
                  title: Text(
                    'IT Request',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(style: ButtonStyle(alignment: Alignment.centerLeft),
                        child: const Text('Email & User Account'),
                        onPressed: () {
                          Navigator.of(context).pushNamed(EmailAndUserAccountScreen.routeName);
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(style: ButtonStyle(alignment: Alignment.centerLeft),
                        child: const Text('Access Right'),
                        onPressed: () {
                          Navigator.of(context).pushNamed(AccessRightScreen.routeName);
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(style: ButtonStyle(alignment: Alignment.centerLeft),
                        child: const Text('Equipments'),
                        onPressed: () {
                          Navigator.of(context).pushNamed(EquipmentsRequest.routeName);
                        },
                      ),
                    ),
                    // TextButton(
                    //   child: const Text('Application'),
                    //   onPressed: () {
                    //     Navigator.of(context).pushNamed(App.routeName);
                    //   },
                    // ),
                  ],
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ExpansionTile(
                  expandedAlignment: Alignment.centerLeft,
                  leading: const Icon(Icons.calendar_month_outlined, size: 40),
                  title: Text(
                    'HR Request',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(style: ButtonStyle(alignment: Alignment.centerLeft),                        child: const Text('Business Mission'),
                        onPressed: () {
                          Navigator.of(context).pushNamed(BusinessMissionScreen.routeName);
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(style: ButtonStyle(alignment: Alignment.centerLeft),
                        child: const Text('Permission'),
                        onPressed: () {
                          Navigator.of(context).pushNamed(PermissionScreen.routeName);
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(style: ButtonStyle(alignment: Alignment.centerLeft),                        child: const Text('Vacation'),
                        onPressed: () {
                          Navigator.of(context).pushNamed(VacationScreen.routeName);
                        },
                      ),
                    ),
                    // TextButton(
                    //   child: const Text('Forget Sign In/Out'),
                    //   onPressed: () {},
                    // ),
                  ],
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ExpansionTile(
                  expandedAlignment: Alignment.centerLeft,
                  leading: const Icon(Icons.perm_contact_calendar_outlined,
                      size: 40),
                  title: Text(
                    'Admin Request',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(style: ButtonStyle(alignment: Alignment.centerLeft),                        child: const Text('Business Card'),
                        onPressed: () {
                          Navigator.of(context).pushNamed(BusinessCardScreen.routeName);
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(style: ButtonStyle(alignment: Alignment.centerLeft),                        child: const Text('Travel Request'),
                        onPressed: () {
                          Navigator.of(context).pushNamed(EmbassyLetterScreen.routeName);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
