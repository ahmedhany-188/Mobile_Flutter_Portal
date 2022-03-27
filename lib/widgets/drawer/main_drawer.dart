import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  Widget buildListTile(String title, IconData icon, tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Drawer(
          elevation: 5,
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.none,
                height: deviceHeight * 0.4,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                color: Theme.of(context).colorScheme.primary,
                // decoration: BoxDecoration(), use it if you will set another decoration apart from color
                child: const Text(
                  'welcome!',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.black,
                    // Theme.of(context).primaryColor,
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              Container(
                height: deviceHeight * 0.6,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildListTile(
                        'Home',
                        Icons.home,
                        () {
                          Navigator.of(context)
                              .pushReplacementNamed(TapsScreen.routeName);
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      buildListTile(
                        'About',
                        Icons.nature_people,
                        () {
                          // Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      buildListTile(
                        'Logout',
                        Icons.logout,
                        () {
                          // Navigator.of(context).pushReplacementNamed(.routeName);
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      buildListTile(
                        'Logout',
                        Icons.logout,
                        () {
                          // Navigator.of(context).pushReplacementNamed(.routeName);
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
