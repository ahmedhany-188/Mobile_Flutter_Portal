import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/notification_bloc/bloc/user_notification_bloc.dart';
import 'package:hassanallamportalflutter/screens/apps_screen/apps_screen.dart';
import 'package:hassanallamportalflutter/screens/home_screen/home_screen.dart';
import 'package:hassanallamportalflutter/screens/notification_screen/notifications_screen.dart';

import '../../screens/contacts_screen/contacts_screen.dart';
import '../../widgets/drawer/main_drawer.dart';
import '../../bloc/auth_app_status_bloc/app_bloc.dart';

class TapsScreen extends StatefulWidget {
  static const routeName = 'tabs-screen';

  const TapsScreen({Key? key}) : super(key: key);

  @override
  State<TapsScreen> createState() => _TapsScreenState();
}

class _TapsScreenState extends State<TapsScreen> {
  // late List<Map<String, dynamic>> _pages;
  // int _selectedPageIndex = 0;
  // @override
  // void initState() {
  //   _pages = [
  //     {
  //       'page': NewsScreen(),
  //       'title': 'Categories',
  //     },
  //     {
  //       'page': ContactsScreen(),
  //       'title': 'Your Favorites',
  //     },
  //   ];
  //   super.initState();
  // }
  // void _selectPage(int index) {
  //   setState(() {
  //     _selectedPageIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext mainContext) {
    final user =
        mainContext.select((AppBloc bloc) => bloc.state.userData.employeeData);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: DefaultTabController(
        length: 4,
        animationDuration: const Duration(milliseconds: 500),
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          drawer: MainDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: MediaQuery.of(context).size.height * 0.10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(35)),
            ),
            elevation: 0,
            flexibleSpace: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,

              ///new added
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(35)),
                child: Stack(
                  // alignment: Alignment.topCenter,
                  fit: StackFit.expand,
                  clipBehavior: Clip.hardEdge,
                  children: <Widget>[
                    Image.asset('assets/images/Cover.png', fit: BoxFit.cover),
                    Image.asset(
                      'assets/images/login_image_logo.png',
                      scale: 3.5,
                      // opacity: const AlwaysStoppedAnimation(0.8),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
            ),
            leading: Builder(builder: (context) {
              return GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 1,
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurStyle: BlurStyle.normal,
                              offset: Offset(-2.0, 3.0))
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: CircleAvatar(
                          radius: 29,
                          // borderRadius: BorderRadius.circular(50),
                          backgroundImage: NetworkImage(
                            'https://portal.hassanallam.com/Apps/images/Profile/${user?.imgProfile}',
                          ),
                          onBackgroundImageError: (_, __) {
                            Image.asset(
                              'assets/images/logo.png',
                              fit: BoxFit.fitHeight,
                              width: 65,
                              height: 65,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
            leadingWidth: 100,
            actions: [
              Stack(
                children: [
                  BlocProvider.value(
                    value: BlocProvider.of<UserNotificationBloc>(context),
                    child: BlocBuilder<UserNotificationBloc,
                        UserNotificationState>(
                      builder: (context, state) {
                        return Badge(
                          toAnimate: true,
                          animationDuration: const Duration(milliseconds: 1000),
                          animationType: BadgeAnimationType.scale,
                          badgeColor: Colors.red,
                          badgeContent: Text(
                            "${state.notifications.length}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                          position: const BadgePosition(
                            start: 5,
                            top: 4,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.notifications),
                            onPressed: () {
                              Navigator.of(mainContext)
                                  .pushNamed(NotificationsScreen.routeName);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
            // title: Image.asset(
            //   'assets/images/login_image_logo.png',
            //   scale: 3,opacity: AlwaysStoppedAnimation(0.8),
            // ),centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.transparent,
              unselectedLabelColor: Colors.white54,
              splashFactory: NoSplash.splashFactory,
              onTap: (index) {
                FocusScope.of(context).requestFocus(FocusNode());
                // FocusManager.instance.primaryFocus!.unfocus();
                // SystemChannels.textInput.invokeMethod('TextInput.hide');
              },
              overlayColor: MaterialStateProperty.resolveWith(
                (Set states) {
                  return states.contains(MaterialState.focused)
                      ? null
                      : Colors.transparent;
                },
              ),
              isScrollable: true,
              padding: const EdgeInsets.only(left: 20),
              labelPadding: const EdgeInsets.only(bottom: 5),
              tabs: [
                Container(
                  width: ((MediaQuery.of(context).size.width - 20) / 3.5),
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.home,
                        size: 25,
                      ),
                      Text(
                        ' Home',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: ((MediaQuery.of(context).size.width - 20) / 3.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.apps,
                        size: 25,
                      ),
                      Text(
                        ' Apps',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: ((MediaQuery.of(context).size.width - 20) / 3.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.people,
                        size: 25,
                      ),
                      Text(
                        ' Contacts',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                  width: (MediaQuery.of(context).size.width - 20) / 7,
                  // padding: EdgeInsets.only(),
                  // decoration: const BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.menu,
                        color: Colors.black,
                        size: 25,
                      )),
                ),
              ],
            ),
          ),
          drawerEnableOpenDragGesture: true,
          body: Container(
            height: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).size.height / 10),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home_cropped.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: const TabBarView(
              physics: BouncingScrollPhysics(),
              children: [
                HomeScreen3(),
                AppsScreen(),
                ContactsScreen(),
                HomeScreen(),
              ],
            ),
          ),

          // _pages[_selectedPageIndex]['page'],

          // bottomNavigationBar:  BottomNavigationBar(
          //   onTap: _selectPage,
          //   backgroundColor: Colors.grey,
          //   unselectedItemColor: Colors.white,
          //   selectedItemColor: Colors.white,
          //   currentIndex: _selectedPageIndex,
          //   type: BottomNavigationBarType.fixed,
          //   items: [
          //     BottomNavigationBarItem(
          //       backgroundColor: Colors.grey,
          //       icon: Icon(Icons.category),
          //       title: Text('Categories'),
          //     ),
          //     BottomNavigationBarItem(
          //       backgroundColor: Colors.grey,
          //       icon: Icon(Icons.star),
          //       title: Text('Favorites'),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
