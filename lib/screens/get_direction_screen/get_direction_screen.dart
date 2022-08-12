import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/screens/get_direction_screen/get_direction_widget.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:hassanallamportalflutter/widgets/search/general_search.dart';
import 'package:hassanallamportalflutter/bloc/get_direction_screen_bloc/get_direction_cubit.dart';
import 'package:sizer/sizer.dart';

class GetDirectionScreen extends StatefulWidget {
  static const routeName = 'get-direction';

  const GetDirectionScreen({Key? key}) : super(key: key);

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

    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Get Direction'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BlocProvider(
          create: (context) => GetDirectionCubit()..getDirection(),
          child: BlocConsumer<GetDirectionCubit, GetDirectionState>(
            listener: (context, state) {
              if (state is GetDirectionSuccessState) {
                projectsDirectionData = state.getDirectionList;
                setState(() {});
              }
            },
            builder: (context, state) {
              return (state is GetDirectionSuccessState ||
                      state is GetDirectionLoadingState)
                  ? Sizer(
                    builder: (c,v,b) => SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 2.5.w, right: 2.5.w, top: 2.5.h),
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
                                decoration: InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.all(10),
                                    filled: true,
                                    focusColor: Colors.white,
                                    fillColor: Colors.grey.shade400
                                        .withOpacity(0.4),
                                    // labelText: "Search contact",
                                    hintText: 'Search by project name',
                                    hintStyle:
                                    const TextStyle(color: Colors.white),
                                    prefixIcon: const Icon(Icons.search,
                                        color: Colors.white),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide.none)),
                              ),
                            ),
                            SizedBox(
                              height: deviceSize.height -
                                  ((deviceSize.height * 0.24) -
                                      MediaQuery.of(context).viewPadding.top),
                              // color: Colors.white,
                              child: (projectsSearchResult.isNotEmpty)
                                  ? GetDirectionWidget(projectsSearchResult)
                                  : (textController.text.isEmpty)
                                      ? GetDirectionWidget(projectsDirectionData)
                                      : const Center(
                                          child: Text('No data found'),
                                        ),
                            )
                          ],
                        ),
                      ),
                  )
                  : const AlertDialog(
                      title: Text('Something went wrong!'),
                      content: Text('Kindly check your internet connection'),
                    );
            },
          ),
        ),
      ),
    );
  }
}
