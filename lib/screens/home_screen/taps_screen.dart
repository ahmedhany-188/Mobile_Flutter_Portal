import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          // toolbarHeight: MediaQuery.of(context).size.height / 4,
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
              child: Image.asset('assets/images/login_image_background.png',
                  fit: BoxFit.fill),
            ),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
          leading: Builder(builder: (context) {
            return GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                      'https://portal.hassanallam.com/Apps/images/Profile/${user!.userHRCode}.jpg'),
                ),
              ),
            );
          }),
          leadingWidth: 100,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        title: const Text('Add News'),
                        elevation: 20,
                        contentPadding: const EdgeInsets.all(10.0),
                        content: Column(
                          children: const <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              keyboardType: TextInputType.name,
                              autofocus: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name',
                                hintText: 'eg. Hassan Allam',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Add News',
                                hintText:
                                    'eg. hassan Allam construction release ...',
                              ),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                              child: const Text('CANCEL'),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          TextButton(
                              child: const Text('Add'),
                              onPressed: () {
                                //TODO: Add News
                                Navigator.pop(context);
                              }),
                        ],
                      );
                    });
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            splashFactory: NoSplash.splashFactory,
            overlayColor: MaterialStateProperty.resolveWith(
              (Set states) {
                return states.contains(MaterialState.focused)
                    ? null
                    : Colors.transparent;
              },
            ),
            tabs: const [
              Tab(
                // child: Row(children: [Icon(
                //   Icons.beach_access,
                // ),Text('Benefits'),]),
                icon: Icon(
                  Icons.beach_access,
                ),
                text: 'Benefits',
              ),
              Tab(
                icon: Icon(Icons.people),
                text: 'Contacts',
              ),
              Tab(
                icon: Icon(Icons.account_balance),
                text: 'Test',
              ),
              Tab(
                child: CircleAvatar(
                  child: Icon(Icons.menu),
                  backgroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        drawerEnableOpenDragGesture: true,
        body:
            // DelayedDisplay(
            //  delay: Duration(milliseconds: 1000),
            //  child:
            SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: const TabBarView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              BenefitsScreen(),
              ContactsScreen(),
              BenefitsScreen(),
              ContactsScreen(),
            ],
          ),
        ),
        // ),

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
