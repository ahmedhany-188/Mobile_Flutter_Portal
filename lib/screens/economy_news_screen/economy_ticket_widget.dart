

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EconomyNewsTicketWidget extends StatelessWidget{

  List<dynamic> EconomyNewsTicketWidgetData;

  EconomyNewsTicketWidget(this.EconomyNewsTicketWidgetData, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      maintainBottomViewPadding: true,

      child: ConditionalBuilder(
        condition: EconomyNewsTicketWidgetData.isNotEmpty,
        builder: (context) =>
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                // childAspectRatio: (1 / .4),
                mainAxisExtent: 90, // here set custom Height You Want
                // width between items
                crossAxisSpacing: 2,
                // height between items
                mainAxisSpacing: 2,
              ),
              itemCount: EconomyNewsTicketWidgetData.length,
              itemBuilder: (BuildContext context, int index) {

                    return Container(
                      width: double.infinity,
                      child:Text("abc"),

                    );

                  }

            ),
        fallback: (context) => const Center(child: LinearProgressIndicator()),
      ),

    );
  }
}