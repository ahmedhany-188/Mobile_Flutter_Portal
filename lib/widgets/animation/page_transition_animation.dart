import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class PageTransitionAnimation {
  Widget pageDirection;
  BuildContext context;
  int delayedDuration;
  int transitionDuration;

  PageTransitionAnimation(
      {required this.pageDirection,
      required this.context,
      required this.delayedDuration,
      required this.transitionDuration});

  // Navigator.of(context).pushReplacement(
  //   PageRouteBuilder(
  //     pageBuilder: (context, animation, anotherAnimation) {
  //       return pageDirection!;
  //     },
  //     transitionDuration: const Duration(milliseconds: 1000),
  //     transitionsBuilder: (context, animation, anotherAnimation, child) {
  //       animation =
  //           CurvedAnimation(curve: Curves.easeIn, parent: animation);
  //       return FadeTransition(
  //         opacity: animation,
  //         child: child,
  //       );
  //     },
  //   ),
  // );

  Future<Widget> navigateWithFading() {
    return Future.delayed(Duration(milliseconds: delayedDuration), () async {
      return await Navigator.of(context).pushReplacement(PageTransition(
        type: PageTransitionType.fade,
        curve: Curves.easeIn,
        child: pageDirection,
        alignment: Alignment.bottomCenter,
        duration: Duration(milliseconds: transitionDuration),
        reverseDuration: const Duration(milliseconds: 1500),
      )).catchError((err){});
    });
  }
  Future<Widget> navigateFromBottom() {
    return Future.delayed(Duration(milliseconds: delayedDuration), () async {
      return await Navigator.of(context).pushReplacement(PageTransition(
        type: PageTransitionType.bottomToTop,
        curve: Curves.bounceIn,
        child: pageDirection,
        alignment: Alignment.bottomCenter,
        duration: Duration(milliseconds: transitionDuration),
        reverseDuration: const Duration(milliseconds: 1500),
      )).catchError((err){});
    });
  }
  Future<void> navigateFromBottomWithoutReplace() {
    return Future.delayed(Duration(milliseconds: delayedDuration), () async {
      return await Navigator.of(context).push(PageTransition(
        type: PageTransitionType.bottomToTop,
        curve: Curves.elasticIn,
        child: pageDirection,
        alignment: Alignment.bottomCenter,
        duration: Duration(milliseconds: transitionDuration),
        reverseDuration: const Duration(milliseconds: 500),
      )).catchError((err){throw err;});
    });
  }
  //
  // Future<Widget> navigateFromBottomToTopJoined(Widget currentPage) async {
  //   return Future.delayed(Duration(milliseconds: delayedDuration), () async {
  //     return await Navigator.of(context).pushReplacement(PageTransition(
  //       type: PageTransitionType.bottomToTopJoined,
  //       child: pageDirection,
  //       childCurrent: currentPage,
  //       duration: Duration(milliseconds: transitionDuration),
  //       // reverseDuration: const Duration(milliseconds: 1500),
  //     ));
  //   });
  // }
}
