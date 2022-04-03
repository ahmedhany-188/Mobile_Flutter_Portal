import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/screens/contacts_screen/search_for_contacts.dart';
import 'package:hassanallamportalflutter/screens/get_direction_screen/get_direction_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hassanallamportalflutter/bloc/get_direction_screen_bloc/get_direction_cubit.dart';
import 'package:hassanallamportalflutter/constants/google_map_api_key.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';

class GetDirectionScreen extends StatefulWidget {
  static const routeName = 'get-direction';

  GetDirectionScreen({Key? key}) : super(key: key);

  static Future<void> openMap(double latitude, double longitude) async {
    // String googleUrl ='https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    String appleUrl = 'https://maps.apple.com/?sll=$latitude,$longitude';
    String googleUrl =
        'https://www.google.com/maps/dir/?api=1&origin=30.1074108,31.3818438&destination=$latitude,$longitude&travelmode=driving&dir_action=navigate';

    if (Platform.isIOS) {
      if (await canLaunch(appleUrl)) {
        await launch(appleUrl);
      } else {
        throw 'Could not open the map.';
      }
    } else {
      /// any platform apart from IOS
      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      } else {
        throw 'Could not open the map.';
      }
    }

    /// /// other way to be done
    /// String goo = 'comgooglemaps://?center=$latitude, $longitude';
    /// if (await canLaunch("comgooglemaps://")) {
    ///   print('launching com googleUrl');
    ///   await launch(googleUrl);
    /// } else if (await canLaunch(appleUrl)) {
    ///   print('launching apple url');
    ///   await launch(appleUrl);
    /// } else {
    ///   throw 'Could not launch url';
    /// }
  }

  @override
  State<GetDirectionScreen> createState() => _GetDirectionScreenState();
}

class _GetDirectionScreenState extends State<GetDirectionScreen> {
  List<dynamic> projectsDirectionData = [];
  List<dynamic> projectsSearchResult = [];
  FocusNode searchTextFieldFocusNode = FocusNode();
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      drawer: MainDrawer(),
      body: BlocProvider(
        create: (context) => GetDirectionCubit()..getDirection(),
        child: BlocConsumer<GetDirectionCubit, GetDirectionState>(
          listener: (context, state) {
            if (state is GetDirectionSuccessState) {
              projectsDirectionData = state.getDirectionList;
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      focusNode: searchTextFieldFocusNode,
                      controller: textController,
                      onSubmitted: (searchValue) {
                        searchTextFieldFocusNode.unfocus();
                        setState(() {});
                      },
                      onChanged: (_) {
                        setState(() {
                          projectsSearchResult =
                              SearchForContacts().setSearchFromApiList(
                            query: textController.text,
                            listKeyForCondition: 'projectName',
                            listFromApi: projectsDirectionData,
                          );
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: "Search projects by name",
                          hintText: "Search projects by name",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  ),
                  Container(
                    height: deviceSize.height -
                        ((deviceSize.height * 0.2) -
                            MediaQuery.of(context).viewPadding.top),
                    color: Colors.grey,
                    child: (projectsSearchResult.isNotEmpty)
                        ? GetDirectionWidget(projectsSearchResult)
                        : GetDirectionWidget(projectsDirectionData),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
