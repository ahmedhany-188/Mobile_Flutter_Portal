import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/screens/home_screen/home_screen.dart';

import '../../screens/benefits_screen/benefits_screen.dart';
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
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.userData.user);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: MainDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: MediaQuery.of(context).size.height * 0.10,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
          ),
          elevation: 0,
          flexibleSpace: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,

            ///new added
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.only(bottomRight: Radius.circular(50)),
              child: Stack(
                  alignment: Alignment.topCenter,
                  fit: StackFit.expand,
                  clipBehavior: Clip.hardEdge,
                  children: <Widget>[
                    Image.asset('assets/images/login_image_background.png',
                        fit: BoxFit.fill),
                    Image.asset(
                      'assets/images/login_image_logo.png',
                      scale: 3,opacity: AlwaysStoppedAnimation(0.8),
                    ),
                  ]),
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
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: CircleAvatar(
                      radius: 28,
                      // borderRadius: BorderRadius.circular(50),
                      backgroundImage: NetworkImage(
                        'https://portal.hassanallam.com/Apps/images/Profile/${user!.userHRCode}.jpg',
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
            );
          }),
          leadingWidth: 100,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // showDialog(
                //     barrierDismissible: true,
                //     context: context,
                //     builder: (context) {
                //       return AlertDialog(
                //         backgroundColor:
                //             Theme.of(context).colorScheme.background,
                //         title: const Text('Add News'),
                //         elevation: 20,
                //         contentPadding: const EdgeInsets.all(10.0),
                //         content: Column(
                //           children: const <Widget>[
                //             SizedBox(
                //               height: 10,
                //             ),
                //             TextField(
                //               keyboardType: TextInputType.name,
                //               autofocus: true,
                //               decoration: InputDecoration(
                //                 border: OutlineInputBorder(),
                //                 labelText: 'Name',
                //                 hintText: 'eg. Hassan Allam',
                //               ),
                //             ),
                //             SizedBox(
                //               height: 10,
                //             ),
                //             TextField(
                //               maxLines: 3,
                //               keyboardType: TextInputType.multiline,
                //               decoration: InputDecoration(
                //                 border: OutlineInputBorder(),
                //                 labelText: 'Add News',
                //                 hintText:
                //                     'eg. hassan Allam construction release ...',
                //               ),
                //             ),
                //           ],
                //         ),
                //         actions: <Widget>[
                //           TextButton(
                //               child: const Text('CANCEL'),
                //               onPressed: () {
                //                 Navigator.pop(context);
                //               }),
                //           TextButton(
                //               child: const Text('Add'),
                //               onPressed: () {
                //                 Navigator.pop(context);
                //               }),
                //         ],
                //       );
                //     });
              },
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
            overlayColor: MaterialStateProperty.resolveWith(
              (Set states) {
                return states.contains(MaterialState.focused)
                    ? null
                    : Colors.transparent;
              },
            ),
            labelPadding: EdgeInsets.zero,
            tabs: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
                Icon(
                  Icons.home,
                ),
                Text(' Home'),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.people,
                  ),
                  Text(' Apps'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.people,
                  ),
                  Text(' Contacts'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: const Icon(Icons.menu, color: Colors.black),
                  ),
                ],
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
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              HomeScreen(),
              BenefitsScreen(),
              ContactsScreen(),
              ContactsScreen(),
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
    );
  }
}
