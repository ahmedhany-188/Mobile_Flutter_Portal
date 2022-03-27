import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import './contact_detail_screen.dart';

class ContactsWidget extends StatelessWidget {
  final List<dynamic> listFromContactsScreen;
  const ContactsWidget(this.listFromContactsScreen, {Key? key}) : super(key: key);

  void contactDetails(BuildContext context, int contactIndex) {
    Navigator.of(context)
        .pushNamed(
        ContactDetailScreen.routeName,
        arguments: listFromContactsScreen[contactIndex],
    ); // we can add .then()
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: listFromContactsScreen.isNotEmpty,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Theme.of(context).colorScheme.secondary,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 5,
                  blurRadius: 3,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                contactDetails(context, index);
              },
              child: Row(
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        60.0,
                      ),
                      image: DecorationImage(
                        image: (listFromContactsScreen[index]['imgProfile'] == null ||
                            listFromContactsScreen[index]['imgProfile'].toString().isEmpty)
                            ? const AssetImage('assets/images/logo.png')
                                as ImageProvider
                            : NetworkImage(
                                'https://portal.hassanallam.com/Apps/images/Profile/${listFromContactsScreen[index]['imgProfile']}'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 120.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${listFromContactsScreen[index]['name']}'.trim(),
                            style: const TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            // overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              width: double.infinity,
                              height: 2.0,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text(
                                  '${listFromContactsScreen[index]['titleName']}'.trim(),
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '${listFromContactsScreen[index]['projectName']}',
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20.0,
          ),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        itemCount: listFromContactsScreen.length,
      ),
      fallback: (context) => const Center(child: CircularProgressIndicator()),
    );
  }
}
