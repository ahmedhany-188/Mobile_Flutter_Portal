
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EconomyNewsTicketWidget extends StatelessWidget {

  List<dynamic> EconomyNewsTicketWidgetData;

  EconomyNewsTicketWidget(this.EconomyNewsTicketWidgetData, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    var deviceSize = MediaQuery
        .of(context)
        .size;
    return SafeArea(


      maintainBottomViewPadding: true,
      child: ConditionalBuilder(
        condition: EconomyNewsTicketWidgetData.isNotEmpty,
        builder: (context) =>
            GridView.builder(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                    .onDrag,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  // childAspectRatio: (1 / .4),
                  mainAxisExtent: 150, // here set custom Height You Want
                  // width between items
                  crossAxisSpacing: 2,
                  // height between items
                  mainAxisSpacing: 2,
                ),
                itemCount: EconomyNewsTicketWidgetData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(

                      child: Container(


                          child: Stack(
                            children: [
                              FadeInImage(
                                image: NetworkImage(EconomyNewsTicketWidgetData[index]["urlToImage"]),
                                placeholder: AssetImage("assets/images/S_Background.png"),
                                fit: BoxFit.cover,
                                width: deviceSize.width,
                                // colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstIn),
                              ),
                              Container(
                                width: double.infinity,
                                color: Color.fromARGB(100, 22, 44, 33),
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  EconomyNewsTicketWidgetData[index]["title"],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),),
                              ),
                            ],
                          )

                      )

                    // decoration: BoxDecoration(
                    //
                    //   image: DecorationImage(
                    //     image: NetworkImage(
                    //         EconomyNewsTicketWidgetData[index]["urlToImage"]),
                    //     fit: BoxFit.cover,
                    //     colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstIn),
                    //   ),
                    // ),
                    // child: Container(
                    //   width: double.infinity,
                    //   color: Color.fromARGB(100, 22, 44, 33),
                    //   margin: EdgeInsets.all(10),
                    //   padding: EdgeInsets.all(10),
                    //   child: Text(
                    //     EconomyNewsTicketWidgetData[index]["title"],
                    //     style: TextStyle(fontSize: 16, color: Colors.white),),
                    // ),
                  );
                }
            ),
        fallback: (context) => const Center(child: LinearProgressIndicator()),
      ),

    );
  }
}

