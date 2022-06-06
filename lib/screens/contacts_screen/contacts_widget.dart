import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../data/models/contacts_related_models/contacts_data_from_api.dart';
import './contact_detail_screen.dart';

class ContactsWidget extends StatelessWidget {
  final List<ContactsDataFromApi> listFromContactsScreen;
  const ContactsWidget(this.listFromContactsScreen, {Key? key})
      : super(key: key);

  void contactDetails(BuildContext context, int contactIndex) {
    Navigator.of(context).pushNamed(
      ContactDetailScreen.routeName,
      arguments: listFromContactsScreen[contactIndex],
    ); // we can add .then()
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (c, o, d) => ConditionalBuilder(
              condition: listFromContactsScreen.isNotEmpty,
              builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: const  LinearGradient(
                          colors: [
                            Color(0xFF1a4c78),
                            Color(0xFF3772a6),
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          tileMode: TileMode.clamp),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 5,
                          blurRadius: 3,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        // ContactDetailScreen(selectedContactDataAsMap: listFromContactsScreen[index],);
                        contactDetails(context, index);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: CircleAvatar(
                              radius: 40.sp,
                              backgroundColor: Colors.transparent,
                              foregroundImage: CachedNetworkImageProvider(
                                  'https://portal.hassanallam.com/Apps/images/Profile/${listFromContactsScreen[index].imgProfile}'),
                              child: Image.asset(
                                'assets/images/logo.png',
                                scale: 3,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 25.0.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Text(
                                      '${listFromContactsScreen[index].name}'
                                          .trim(),
                                      style: const TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                      maxLines: 2,
                                      // overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5,bottom: 5),
                                    child: Container(
                                      width: double.infinity,
                                      height: 0.2.h,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Text(
                                            '${listFromContactsScreen[index].titleName}'
                                                .trim(),
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.white,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            '${listFromContactsScreen[index].projectName}',
                                            style: const TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.white,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 0.2.h,
                    color: Colors.grey[300],
                  ),
                ),
                itemCount: listFromContactsScreen.length,
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ));
  }
}
