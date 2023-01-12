import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/get_direction_screen_bloc/get_direction_cubit.dart';
import '../../constants/colors.dart';
import '../../data/models/get_location_model/location_data.dart';
import 'projects_details_screen.dart';

class ProjectsPortfolioScreen extends StatelessWidget {
  static const routeName = 'projects-portfolio';
  ProjectsPortfolioScreen({Key? key}) : super(key: key);

  final FocusNode searchTextFieldFocusNode = FocusNode();
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Projects Portfolio'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BlocProvider<GetDirectionCubit>.value(
          value: GetDirectionCubit.get(context),
          child: BlocBuilder<GetDirectionCubit, GetDirectionInitial>(
            builder: (context, state) {
              return Sizer(
                builder: (c, v, b) => Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 2.5.w, right: 2.5.w, top: 2.5.h, bottom: 2.5.h),
                      child: TextField(
                        focusNode: searchTextFieldFocusNode,
                        controller: textController,
                        onSubmitted: (searchValue) {
                          searchTextFieldFocusNode.unfocus();
                        },
                        onChanged: (value) {
                          GetDirectionCubit.get(context)
                              .searchForLocations(value);
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          filled: true,
                          focusColor: Colors.white,
                          fillColor: Colors.grey.shade400.withOpacity(0.4),
                          hintText: 'Search by project name',
                          hintStyle: const TextStyle(color: Colors.white),
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.white),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide.none),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Flexible(
                        child: (state.tempItems.isNotEmpty &&
                                textController.text.isNotEmpty)
                            ? buildList(state.tempItems)
                            : buildList(state.items))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget buildList(List<LocationData> projectsDirectionData) {
  return ConditionalBuilder(
    condition: projectsDirectionData.isNotEmpty,
    builder: (context) => ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: projectsDirectionData.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
              ProjectDetailsScreen.routeName,
              arguments: projectsDirectionData[index]),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            // height: MediaQuery.of(context).size.height * 0.20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white38,
                child: Column(children: [
                  Text(
                      projectsDirectionData[index].projectName ?? "Not Defined",
                      style: const TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                      textAlign: TextAlign.center),
                  const Divider(color: Colors.white, thickness: 2),
                  Text(
                    projectsDirectionData[index].departmentName ?? "",
                    style: const TextStyle(
                      fontSize: 13,
                      color: ConstantsColors.bottomSheetBackgroundDark,
                    ),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    ),
    fallback: (context) => const Center(
        child: CircularProgressIndicator(
      color: Colors.white,
    )),
  );
}
