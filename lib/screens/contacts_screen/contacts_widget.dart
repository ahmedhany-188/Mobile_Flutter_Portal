import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/screens/myprofile_screen/ProfileScreenDirectManager.dart';
import 'package:sizer/sizer.dart';

import '../../data/models/contacts_related_models/contacts_data_from_api.dart';

class ContactsWidget extends StatelessWidget {
  final List<ContactsDataFromApi> listFromContactsScreen;
  const ContactsWidget(this.listFromContactsScreen, {Key? key})
      : super(key: key);

  static final ScrollController _scrollController = ScrollController();

  static scrollToTop() {
    if(_scrollController.positions.isNotEmpty) {
      Timer(
      const Duration(seconds: 0), () => _scrollController.animateTo(0.0, curve: Curves.easeOut, duration: const Duration(milliseconds: 300)),
    );
    }
  }

  void contactDetails(BuildContext context, int contactIndex) {
    // Navigator.of(context).pushNamed(
    //   ContactDetailScreen.routeName,
    //   arguments: listFromContactsScreen[contactIndex],
    // );

    // print('pope'+listFromContactsScreen[contactIndex].phoneNumber.toString());
    Navigator.of(context).pushNamed(
      DirectManagerProfileScreen.routeName,
      arguments: {DirectManagerProfileScreen.employeeHrCode: "0",
        DirectManagerProfileScreen.selectedContactDataAsMap: listFromContactsScreen[contactIndex]},
    );
  }

  @override
  Widget build(BuildContext context) {
    // scrollToTop();
    return Sizer(
      builder: (c, o, d) => ConditionalBuilder(
        condition: listFromContactsScreen.isNotEmpty,
        builder: (context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

          itemBuilder: (context, index) {
            var imageProfile = listFromContactsScreen[index].imgProfile ?? "";
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  contactDetails(context, index);
                },
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.grey.shade400.withOpacity(0.4),
                    // gradient: const LinearGradient(
                    //     colors: [
                    //       Color(0xFF1a4c78),
                    //       Color(0xFF3772a6),
                    //     ],
                    //     begin: Alignment.bottomLeft,
                    //     end: Alignment.topRight,
                    //     tileMode: TileMode.clamp),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.4),
                    //     spreadRadius: 5,
                    //     blurRadius: 3,
                    //     offset: const Offset(0, 3), // changes position of shadow
                    //   ),
                    // ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child:
                        imageProfile.isNotEmpty ? CachedNetworkImage(
                          imageUrl: 'https://portal.hassanallam.com/Apps/images/Profile/$imageProfile',
                          imageBuilder: (context, imageProvider) => Container(
                            width: 80.sp,
                            height: 80.sp,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => Assets.images.logo.image(height: 60.sp),
                          errorWidget: (context, url, error) => Assets.images.logo.image(height: 60.sp),
                        ) : Assets.images.logo.image(height: 60.sp),
                        // CircleAvatar(
                        //   radius: 40.sp,
                        //   backgroundColor: Colors.transparent,
                        //   foregroundImage:
                        //   (imageProfile.isNotEmpty)
                        //       ?  CachedNetworkImageProvider(
                        //     'https://portal.hassanallam.com/Apps/images/Profile/$imageProfile',
                        //   )
                        //       : Image.asset(
                        //     'assets/images/logo.png',
                        //     height: 20.sp,
                        //     // fit: BoxFit.scaleDown,
                        //   ).image,
                        //   // onForegroundImageError: (o, t) {
                        //   //   Image.asset(
                        //   //     'assets/images/logo.png',
                        //   //     height: 50.sp,
                        //   //     // fit: BoxFit.scaleDown,
                        //   //   );
                        //   // },
                        //   // backgroundImage: AssetImage(
                        //   //   'assets/images/logo.png',
                        //   // ),
                        //   // child: Image.asset(
                        //   //   'assets/images/logo.png',
                        //   //   height: 50.sp,
                        //   //   // fit: BoxFit.scaleDown,
                        //   // ),
                        // ),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.loose,
                        child: SizedBox(
                          height: 100.0.sp,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  '${listFromContactsScreen[index].name?.toTitleCase()}'
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
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 5),
                                child: Container(
                                  width: double.infinity,
                                  height: 0.5.sp,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                clipBehavior: Clip.none,
                                alignment: Alignment.center,
                                // height: 10.sp,
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${listFromContactsScreen[index]
                                          .titleName}'
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
                                      '${listFromContactsScreen[index]
                                          .projectName}',
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
            child: Container(
              width: double.infinity,
              height: 0.5.sp,
              color: Colors.grey[300],
            ),
          ),
          itemCount: listFromContactsScreen.length,
        ),
        fallback: (context) => const Center(
          child: Center(
            child: Text('No data found'),
          ),
        ),
      ),
    );
  }
}
