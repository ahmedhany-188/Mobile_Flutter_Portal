import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../data/helpers/assist_function.dart';
import '../../widgets/appbar/internal_appbar.dart';
import '../../widgets/drawer/main_drawer.dart';

class ValueScreen extends StatelessWidget {
  static const routeName = 'value-screen';
  const ValueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar:AppBar(),/// basicAppBar(context, 'Values'),
        // drawer: MainDrawer(),
        body: Sizer(builder: (c, o, d) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.0.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    titleText('QUALITY'),
                    paragraphText(
                        "We understand the impact our work has on the futures of the communities where we operate.this is why we are committed to delivering the highest quality the first time around in every single project and undertaking."),
                    Divider(thickness: 2.sp),
                    titleText('INTEGRITY'),
                    paragraphText(
                        "We uphold the values of honesty and integrity in all our dealings with stakeholders. We believe compromising on ethics id short sighted."),
                    Divider(thickness: 2.sp),
                    titleText('RELIABILITY'),
                    paragraphText(
                        "As one of Egypt's construction pioneers, we have successfully navigated the economic and business cycles of the region for 80 years, developing a strong reputation for reliability and for delivering in ‘tough times’. As a result, our business centres are in strong and long-term partnerships with local and international clients."),
                    Divider(thickness: 2.sp),
                    titleText('INNOVATION'),
                    paragraphText(
                        "Innovation is the key to mastering future challenges. That is why we give great importance to constantly developing and improving our people, processes, systems, products and know-how. Our aim is tow achieve leadership through technical innovations."),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
