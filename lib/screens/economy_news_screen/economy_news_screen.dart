import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/economy_news_screen_bloc/economy_news_cubit.dart';
import 'package:hassanallamportalflutter/screens/economy_news_screen/economy_ticket_widget.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';

class EconomyNewsScreen extends StatefulWidget{

  static const routeName = "/economynews-list-screen";
  const EconomyNewsScreen({Key? key}) : super(key: key);

  @override
  State<EconomyNewsScreen> createState() => _economynews_screenState();
}

class _economynews_screenState extends State<EconomyNewsScreen> {

  // ignore: non_constant_identifier_names
  List<dynamic> EconomyNewsListData = [];

  // ignore: non_constant_identifier_names
  String EconomyNewsStringData = "";


  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Economy news'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      // drawer: MainDrawer(),

      body: BlocProvider<EconomyNewsCubit>(
        create: (context) =>
        EconomyNewsCubit()
          ..getEconomyNews(),
        child: BlocConsumer<EconomyNewsCubit, EconomyNewsState>(
          listener: (context, state) {
            if (state is BlocGetTheEconomyNewsSuccesState) {
              EconomyNewsStringData = state.EconomyNewsList;
              EconomyNewsListData =
              jsonDecode(EconomyNewsStringData)["articles"];
            }
            else if (state is BlocGetTheEconomyNewsLoadingState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Loading"),
                ),
              );
            }
            else if (state is BlocGetTheEconomyNewsErrorState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("error"),
                ),
              );
            }
          },
          builder: (context, state) {
            return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(
                      "assets/images/S_Background.png"),
                      fit: BoxFit.cover)
              ),
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    height: deviceSize.height,
                    child: EconomyNewsTicketWidget(EconomyNewsListData),
                  )
              ),
            );
          },
        ),
      ),
    );
  }
}