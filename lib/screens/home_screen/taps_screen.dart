import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hassanallamportalflutter/screens/benefits_screen/benefits_screen.dart';
import 'package:hassanallamportalflutter/screens/contacts_screen/contacts_screen.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';

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
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: MainDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
            ),
          ),
          elevation: 0,
          flexibleSpace: Container(
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
              child: Image.asset('assets/images/login_image_background.png',
                  fit: BoxFit.fill),
            ),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Image.asset('assets/images/logo.png'),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
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
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
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
                child: CircleAvatar(child: Icon(Icons.list),backgroundColor: Colors.white,),
              ),
            ],
          ),
        ),
        drawerEnableOpenDragGesture: true,
        body:
            // DelayedDisplay(
            //  delay: Duration(milliseconds: 1000),
            //  child:
            const TabBarView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            BenefitsScreen(),
            ContactsScreen(),
            BenefitsScreen(),
            ContactsScreen(),
          ],
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
class WaveClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double curveHeight = size.height / 2;
    var p = Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(0, curveHeight, curveHeight, curveHeight)
      ..lineTo(size.width - curveHeight, curveHeight)
      ..quadraticBezierTo(size.width, curveHeight, size.width, size.height)
      ..lineTo(size.width, 0);

    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}