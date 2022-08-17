import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../gen/fonts.gen.dart';

class RequesterDataWidget extends StatelessWidget {
  const RequesterDataWidget({
    Key? key, required this.requesterData, required this.actionComment,
  }) : super(key: key);

  final EmployeeData requesterData;
  final Widget actionComment;

  @override
  Widget build(BuildContext context) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 29,
                    // borderRadius: BorderRadius.circular(50),
                    backgroundImage: NetworkImage(
                      'https://portal.hassanallam.com/Apps/images/Profile/${requesterData
                          .imgProfile}',
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
                  const SizedBox(width: 5,),
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
      key: UniqueKey(),
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