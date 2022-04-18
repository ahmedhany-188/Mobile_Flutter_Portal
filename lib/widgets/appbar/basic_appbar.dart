import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

PreferredSizeWidget basicAppBar(BuildContext context, String title){
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.primary,
    elevation: 5,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
    title: Text(title),
    leading: Builder(
      builder: (context) => IconButton(
        icon: Image.asset('assets/images/logo.png'),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    ),
    // actions: [
    //   // IconButton(
    //   //   icon: const Icon(Icons.add),
    //   //   onPressed: () {
    //   //     showDialog(
    //   //         barrierDismissible: true,
    //   //         context: context,
    //   //         builder: (context) {
    //   //           return AlertDialog(
    //   //             backgroundColor:
    //   //             Theme.of(context).colorScheme.background,
    //   //             title: const Text('Add News'),
    //   //             elevation: 20,
    //   //             contentPadding: const EdgeInsets.all(10.0),
    //   //             content: Column(
    //   //               children: const <Widget>[
    //   //                 SizedBox(
    //   //                   height: 10,
    //   //                 ),
    //   //                 TextField(
    //   //                   keyboardType: TextInputType.name,
    //   //                   autofocus: true,
    //   //                   decoration: InputDecoration(
    //   //                     border: OutlineInputBorder(),
    //   //                     labelText: 'Name',
    //   //                     hintText: 'eg. Hassan Allam',
    //   //                   ),
    //   //                 ),
    //   //                 SizedBox(
    //   //                   height: 10,
    //   //                 ),
    //   //                 TextField(
    //   //                   maxLines: 3,
    //   //                   keyboardType: TextInputType.multiline,
    //   //                   decoration: InputDecoration(
    //   //                     border: OutlineInputBorder(),
    //   //                     labelText: 'Add News',
    //   //                     hintText:
    //   //                     'eg. hassan Allam construction release ...',
    //   //                   ),
    //   //                 ),
    //   //               ],
    //   //             ),
    //   //             actions: <Widget>[
    //   //               TextButton(
    //   //                   child: const Text('CANCEL'),
    //   //                   onPressed: () {
    //   //                     Navigator.pop(context);
    //   //                   }),
    //   //               TextButton(
    //   //                   child: const Text('Add'),
    //   //                   onPressed: () {
    //   //                     //TODO: Add News
    //   //                     Navigator.pop(context);
    //   //                   }),
    //   //             ],
    //   //           );
    //   //         });
    //   //   },
    //   // ),
    // ],
    // bottom: const TabBar(
    //   indicatorColor: Colors.white,
    //   tabs: [
    //     Tab(
    //       icon: Icon(Icons.beach_access),
    //       text: 'Benefits',
    //     ),
    //     Tab(
    //       icon: Icon(Icons.people),
    //       text: 'Contacts',
    //     ),
    //     // Tab(
    //     //   icon: Icon(Icons.account_balance),
    //     //   text: 'Test',
    //     // ),
    //   ],
    // ),
  );
}
