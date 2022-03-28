import 'package:flutter/material.dart';

class ContactDetailScreen extends StatelessWidget {
  static const routeName = '/contact-detail-screen';
  @override
  Widget build(BuildContext context) {
    final selectedContactListOfData =
        ModalRoute.of(context)!.settings.arguments;

    final selectedContactDataAsMap =
        selectedContactListOfData as Map<String, dynamic>;
    // selectedContactDataAsMap['companyName'];

    Widget detailedColumnForContactData(
        String staticDataName, String? dynamicDataString) {
      return Column(
        children: [
          Row(
            children: [
              Text(
                staticDataName.trim(),
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  dynamicDataString.toString().trim(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ],
      );
    }

    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(selectedContactDataAsMap['name'].toString().trim()),
      ),
      // drawer: MainDrawer(),
      body: Container(
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/images/background.png"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  // alignment: Alignment.center,
                  width: deviceSize.width,
                  height: deviceSize.height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      30.0,
                    ),
                    image: DecorationImage(
                      image: (selectedContactDataAsMap['imgProfile'] == null ||
                              selectedContactDataAsMap['imgProfile']
                                  .toString()
                                  .isEmpty)
                          ? const AssetImage('assets/images/logo.png')
                              as ImageProvider
                          : NetworkImage(
                              'https://portal.hassanallam.com/Apps/images/Profile/${selectedContactDataAsMap['imgProfile']}'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                detailedColumnForContactData(
                  'Hr Code: ',
                  selectedContactDataAsMap['userHrCode'],
                ),
                const SizedBox(height: 10),
                detailedColumnForContactData(
                  'Name: ',
                  selectedContactDataAsMap['name'],
                ),
                const SizedBox(height: 10),
                detailedColumnForContactData(
                  'Email: ',
                  selectedContactDataAsMap['email'],
                ),
                const SizedBox(height: 10),
                detailedColumnForContactData(
                  'Project Name: ',
                  selectedContactDataAsMap['projectName'],
                ),
                const SizedBox(height: 10),
                detailedColumnForContactData(
                  'Main Department: ',
                  selectedContactDataAsMap['mainDepartment'],
                ),
                const SizedBox(height: 10),
                detailedColumnForContactData(
                  'Main Function: ',
                  selectedContactDataAsMap['mainFunction'],
                ),
                const SizedBox(height: 10),
                detailedColumnForContactData(
                  'Title Name: ',
                  selectedContactDataAsMap['titleName'],
                ),
                const SizedBox(height: 10),
                detailedColumnForContactData(
                  'Company Name: ',
                  selectedContactDataAsMap['companyName'],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
