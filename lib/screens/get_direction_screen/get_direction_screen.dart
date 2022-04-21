import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/screens/contacts_screen/search_for_contacts.dart';
import 'package:hassanallamportalflutter/screens/get_direction_screen/get_direction_widget.dart';
import 'package:hassanallamportalflutter/widgets/search/general_search.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hassanallamportalflutter/bloc/get_direction_screen_bloc/get_direction_cubit.dart';
import 'package:hassanallamportalflutter/constants/google_map_api_key.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';

class GetDirectionScreen extends StatefulWidget {
  static const routeName = 'get-direction';

  GetDirectionScreen({Key? key}) : super(key: key);

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
              setState(() {

              });
            }
          },
          builder: (context, state) {
            return (state is GetDirectionSuccessState ||
                    state is GetDirectionLoadingState)
                ? SingleChildScrollView(
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
                                    GeneralSearch().setGeneralSearch(
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
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(25.0)))),
                          ),
                        ),
                        Container(
                          height: deviceSize.height -
                              ((deviceSize.height * 0.24) -
                                  MediaQuery.of(context).viewPadding.top),
                          color: Colors.grey,
                          child: (projectsSearchResult.isNotEmpty ||
                                  textController.text.isNotEmpty)
                              ? GetDirectionWidget(projectsSearchResult)
                              : GetDirectionWidget(projectsDirectionData),
                        )
                      ],
                    ),
                  )
                : const AlertDialog(
                    title: Text('Something went wrong!'), content: Text('Kindly check your internet connection'),);
          },
        ),
      ),
    );
  }
}
