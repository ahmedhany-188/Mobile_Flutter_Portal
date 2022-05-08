import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/economy_news_screen_bloc/economy_news_cubit.dart';
import 'package:hassanallamportalflutter/bloc/myattendance_screen_bloc/attendance_cubit.dart';
import 'package:hassanallamportalflutter/screens/economy_news_screen/economy_ticket_widget.dart';
import 'package:hassanallamportalflutter/screens/myattendance_screen/attendance_ticket_widget.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';

class EconomyNewsScreen extends StatefulWidget{

  static const routeName = "/economynews-list-screen";

  const EconomyNewsScreen({Key? key}) : super(key: key);

  State<EconomyNewsScreen> createState() => _economynews_screenState();

}


class _economynews_screenState extends State<EconomyNewsScreen>{

  List<dynamic> EconomyNewsListData = [];
  String EconomyNewsStringData = "";


  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery
        .of(context)
        .size;


    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      drawer: MainDrawer(),

      body: BlocProvider<EconomyNewsCubit>(
        create: (context) => EconomyNewsCubit()..getSuccessMessage(),
        child: BlocConsumer<EconomyNewsCubit,EconomyNewsState>(
          listener: (context ,state){

            if (state is BlocGetTheEconomyNewsSuccesState) {


              print("--,,,--"+state.EconomyNewsList+"");
              EconomyNewsStringData = state.EconomyNewsList;
              EconomyNewsListData = jsonDecode(EconomyNewsStringData);
              print(EconomyNewsListData.length);
              // open pdf file in
              // final  _url = "https://portal.hassanallam.com/Public/medical.aspx?FormID=2217";
              // if (await canLaunch(_url))
              //   await launch(_url);

            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      height: deviceSize.height -
                          ((deviceSize.height * 0.24) -
                              MediaQuery
                                  .of(context)
                                  .viewPadding
                                  .top),
                      child: AttendanceTicketWidget(EconomyNewsListData),
                      // decoration: const BoxDecoration(
                      //     image: DecorationImage(image: AssetImage(
                      //         "assets/images/backgroundattendance.jpg"),
                      //         fit: BoxFit.cover)
                      // ),
                    )
                  ],
                )
            );
          },



        ),

      ),
    );
  }






}