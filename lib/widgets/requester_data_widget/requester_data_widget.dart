import 'package:authentication_repository/authentication_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../gen/assets.gen.dart';
import '../../gen/fonts.gen.dart';
import '../../screens/myprofile_screen/ProfileScreenDirectManager.dart';

class RequesterDataWidget extends StatelessWidget {
  const RequesterDataWidget({
    Key? key, required this.requesterData, required this.actionComment,
  }) : super(key: key);

  final EmployeeData requesterData;
  final Widget actionComment;

  @override
  Widget build(BuildContext context) {

    final imageProfile = requesterData.imgProfile ?? "";
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 1.h),
      alignment: Alignment.bottomLeft,
      color: Colors.transparent,
      child: InputDecorator(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: 20, vertical: 5),
          labelText: 'Requester Data',
          floatingLabelAlignment:
          FloatingLabelAlignment.start,
          alignLabelWithHint: true,
          // prefixIcon: Icon(Icons.event),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed(
                      DirectManagerProfileScreen.routeName,
                      arguments: {
                        DirectManagerProfileScreen
                            .employeeHrCode: requesterData.userHrCode});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    imageProfile.isNotEmpty
                        ? CachedNetworkImage(
                      imageUrl: 'https://portal.hassanallam.com/Apps/images/Profile/$imageProfile',
                      imageBuilder: (context,
                          imageProvider) =>
                          Container(
                            width: 40.sp,
                            height: 40.sp,
                            decoration: BoxDecoration(
                              shape: BoxShape
                                  .circle,
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit
                                      .cover),
                            ),
                          ),
                      placeholder: (context,
                          url) =>
                          Assets.images.logo
                              .image(
                              height: 60.sp),
                      errorWidget: (context,
                          url, error) =>
                          Assets.images.logo
                              .image(
                              height: 60.sp),
                    )
                        : Assets.images.logo
                        .image(height: 60.sp),
                    const SizedBox(width: 10,),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(requesterData.name!.toTitleCase(),
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontFamily.robotoFlex,
                                  color: Colors.white)),
                          Text('${requesterData.titleName}',
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white)),
                          Text('#${requesterData.userHrCode}',
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 0, vertical: 0),
                child: actionComment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionCommentWidget extends StatelessWidget {
  const ActionCommentWidget({
    Key? key, required this.onChanged,
  }) : super(key: key);
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: commentController,
      // key: UniqueKey(),
      enabled: true,
      onChanged: (comment) => onChanged(comment),
      keyboardType: TextInputType.multiline,
      // enabled: (widget.objectValidation) ? false : true,
      maxLines: 3,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              20.0),
        ),
        filled: true,
        hintStyle: TextStyle(
            color: Colors.grey[800]),
        labelText: "Action comment",
        // fillColor: Colors.white70,
        prefixIcon: const Icon(Icons.comment, color: Colors.white70,),
        enabled: true,
      ),
    );
  }
}