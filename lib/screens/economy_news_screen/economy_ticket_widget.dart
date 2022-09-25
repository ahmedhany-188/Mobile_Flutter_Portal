import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class EconomyNewsTicketWidget extends StatelessWidget {

  // ignore: non_constant_identifier_names
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
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                    .onDrag,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  // childAspectRatio: (1 / .4),
                  mainAxisExtent: 180, // here set custom Height You Want
                  // width between items
                  crossAxisSpacing: 2,
                  // height between items
                  mainAxisSpacing: 5,
                ),
                itemCount: EconomyNewsTicketWidgetData.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: (){
                        launchUrl(
                        Uri.parse(EconomyNewsTicketWidgetData[index]["url"]),
                        mode: LaunchMode.externalApplication,
                      );
                      },
                      child:Container(
                    decoration: BoxDecoration(

                      image: getHeadineImage(index)
                    ),

                    child: Container(
                      width: double.infinity,
                      color: const Color.fromARGB(100, 22, 44, 33),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        EconomyNewsTicketWidgetData[index]["title"],
                        style: const TextStyle(fontSize: 16, color: Colors.white),),
                    ),
                  )
                  );
                }
            ),
        fallback: (context) => const Center(child: CircularProgressIndicator(color: Colors.white,)),
      ),
    );
  }


  dynamic getHeadineImage(int index) {
    if (EconomyNewsTicketWidgetData[index]["urlToImage"] != null) {
      return DecorationImage(
        image: NetworkImage(
            EconomyNewsTicketWidgetData[index]["urlToImage"]),
        fit: BoxFit.cover,
        colorFilter:  ColorFilter.mode(
            Colors.black.withOpacity(0.7), BlendMode.dstIn),
      );
    }
    else {
      return DecorationImage(
        image: const AssetImage("assets/images/S_Background.png"),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.0), BlendMode.dstIn),
      );
    }
  }

}

