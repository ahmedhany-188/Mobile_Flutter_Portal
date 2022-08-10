import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/screens/economy_news_screen/economy_news_screen.dart';
import 'package:hassanallamportalflutter/screens/get_direction_screen/get_direction_screen.dart';
import 'package:hassanallamportalflutter/screens/news_screen/news_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/url_links.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          GridView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 0),
            children: [
              InkWell(
                onTap: () async {
                  Navigator.of(context).pushNamed(GetDirectionScreen.routeName);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                        colors: [
                          Color(0xFF1a4c78),
                          Color(0xFF3772a6),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        tileMode: TileMode.clamp),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Flexible(
                        child: Text(
                          'Get Direction',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // InkWell(
              //   onTap: () async {
              //     Navigator.of(context).pushNamed(AboutScreen.routeName);
              //   },
              //   child: Container(
              //     margin: const EdgeInsets.only(bottom: 5),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20),
              //       gradient: const LinearGradient(
              //           colors: [
              //             Color(0xFF1a4c78),
              //             Color(0xFF3772a6),
              //           ],
              //           begin: Alignment.bottomLeft,
              //           end: Alignment.topRight,
              //           tileMode: TileMode.clamp),
              //     ),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: const [
              //         Flexible(
              //           child: Text(
              //             'About',
              //             style: TextStyle(
              //               fontSize: 20,
              //               fontWeight: FontWeight.w400,
              //               color: Colors.white,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1a4c78),
                        Color(0xFF3772a6),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      tileMode: TileMode.clamp),
                ),
                child: TextButton(
                  onPressed: () {
                    launchUrl(Uri.parse(getHrManagment()),
                        mode: LaunchMode.externalApplication);
                  },
                  child: const Text(
                    'HR Management',
                    style: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1a4c78),
                        Color(0xFF3772a6),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      tileMode: TileMode.clamp),
                ),
                child: TextButton(
                  onPressed: () {
                    launchUrl(Uri.parse(getHSEManagment()),
                        mode: LaunchMode.externalApplication);
                  },
                  child: const Text(
                    'HSE Management',
                    style: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1a4c78),
                        Color(0xFF3772a6),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      tileMode: TileMode.clamp),
                ),
                child: TextButton(
                  onPressed: () {
                    launchUrl(Uri.parse(getCompliance()),
                        mode: LaunchMode.externalApplication);
                  },
                  child: const Text(
                    'Compliance',
                    style: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1a4c78),
                        Color(0xFF3772a6),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      tileMode: TileMode.clamp),
                ),
                child: TextButton(
                  onPressed: () {
                    launchUrl(Uri.parse(getCodeOfConduct()),
                        mode: LaunchMode.externalApplication);
                  },
                  child: const Text(
                    'Code Of Conduct',
                    style: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1a4c78),
                        Color(0xFF3772a6),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      tileMode: TileMode.clamp),
                ),
                child: TextButton(
                  onPressed: () {
                    launchUrl(Uri.parse(getTrainingPlan()),
                        mode: LaunchMode.externalApplication);
                  },
                  child: const Text(
                    'Training Plan',
                    style: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          // Container(margin: const EdgeInsetsDirectional.only(start: 10,end: 10),width: double.infinity,height: 2,color: Colors.grey,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ExpansionTile(
                collapsedBackgroundColor: const Color(0xFF3772a6),
                collapsedTextColor: Colors.white,
                backgroundColor: const Color(0xFF3772a6),
                collapsedIconColor: Colors.white,
                iconColor: Colors.white,
                textColor: Colors.white,
                childrenPadding: const EdgeInsets.all(10),
                leading: const Icon(
                  Icons.newspaper_outlined,
                  size: 25,
                  color: Colors.white,
                ),
                title: const Text(
                  'News',
                  style: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(NewsScreen.routeName);
                      },
                      child: const Text(
                        'News',
                        style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(EconomyNewsScreen.routeName);
                      },
                      child: const Text(
                        'Economy News',
                        style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  ExpansionTile(
                    collapsedTextColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    leading: const Icon(
                      Icons.newspaper_outlined,
                      size: 20,
                    ),
                    title: const Text(
                      'News Letter',
                      style: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            launchUrl(
                                Uri.parse(
                                    'https://portal.hassanallam.com/NewsLatter/index-ar.html'),
                                mode: LaunchMode.externalApplication);
                          },
                          child: const Text(
                            'عربي',
                            style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            launchUrl(
                                Uri.parse(
                                    'https://portal.hassanallam.com/NewsLatter/index.html'),
                                mode: LaunchMode.externalApplication);
                          },
                          child: const Text(
                            'English',
                            style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ExpansionTile(
                collapsedBackgroundColor: const Color(0xFF3772a6),
                collapsedTextColor: Colors.white,
                backgroundColor: const Color(0xFF3772a6),
                collapsedIconColor: Colors.white,
                iconColor: Colors.white,
                textColor: Colors.white,
                childrenPadding: const EdgeInsets.all(10),
                leading: const Icon(
                  Icons.newspaper_outlined,
                  size: 25,
                  color: Colors.white,
                ),
                title: const Text(
                  'Quality',
                  style: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        launchUrl(Uri.parse(getQualityIso()),
                            mode: LaunchMode.externalApplication);
                      },
                      child: const Text(
                        'Quality ISO',
                        style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        launchUrl(Uri.parse(getQualityAsme()),
                            mode: LaunchMode.externalApplication);
                      },
                      child: const Text(
                        'Quality ASME',
                        style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        launchUrl(Uri.parse(getQualityBestPractice()),
                            mode: LaunchMode.externalApplication);
                      },
                      child: const Text(
                        'Quality Best Practice',
                        style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ExpansionTile(
                collapsedBackgroundColor: const Color(0xFF3772a6),
                collapsedTextColor: Colors.white,
                backgroundColor: const Color(0xFF3772a6),
                collapsedIconColor: Colors.white,
                iconColor: Colors.white,
                textColor: Colors.white,
                childrenPadding: const EdgeInsets.all(10),
                leading: const Icon(
                  Icons.newspaper_outlined,
                  size: 25,
                  color: Colors.white,
                ),
                title: const Text(
                  'IT Management',
                  style: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        launchUrl(Uri.parse(getItOperationsPortal()),
                            mode: LaunchMode.externalApplication);
                      },
                      child: const Text(
                        'IT Operations Portal',
                        style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        launchUrl(Uri.parse(getEDMSPortal()),
                            mode: LaunchMode.externalApplication);
                      },
                      child: const Text(
                        'EDMS Portal',
                        style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        launchUrl(Uri.parse(getItTicketingSystem()),
                            mode: LaunchMode.externalApplication);
                      },
                      child: const Text(
                        'IT Ticketing System',
                        style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        launchUrl(Uri.parse(getConferenceCall()),
                            mode: LaunchMode.externalApplication);
                      },
                      child: const Text(
                        'Conference Call',
                        style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
