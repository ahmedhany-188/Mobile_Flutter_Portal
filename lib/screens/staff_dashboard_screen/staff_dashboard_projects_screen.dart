import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/bloc/staff_dashboard_project_bloc/staff_dashboard_project_cubit.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/screens/staff_dashboard_screen/staff_dashboard_projects_widget.dart';

import '../../bloc/staff_dashboard_bloc/staff_dashboard_cubit.dart';

class StaffDashBoardProjectScreen extends StatefulWidget {
  static const companyID = "/company-id";
  static const project = "/project";
  static const director = "/director";
  static const date = "/date";

  static const routeName = "/staff-dashboard-project-screen";

  const StaffDashBoardProjectScreen({Key? key, this.requestData})
      : super(key: key);
  final dynamic requestData;

  @override
  State<StaffDashBoardProjectScreen> createState() =>
      StaffDashBoardProjectScreenClass();
}

class StaffDashBoardProjectScreenClass
    extends State<StaffDashBoardProjectScreen> {
  TextEditingController textController = TextEditingController();
  FocusNode textFoucus = FocusNode();
  @override
  Widget build(BuildContext context) {
    final currentRequestData = widget.requestData;

    return WillPopScope(
        onWillPop: () async {
          await EasyLoading.dismiss(animation: true);
          return true;
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.staffdashboard.dashboardbgsub.image().image,
              fit: BoxFit.fill,
            ),
          ),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                  backgroundColor: ConstantsColors.petrolTextAttendance,
                  elevation: 0,
                  title: const Text("Projects"),
                  // title: Text('Dashboard $formattedDateTitle'),
                  centerTitle: true,
                  actions: <Widget>[
                    BlocProvider.value(
                      value: StaffDashboardCubit.get(context),
                      child:
                          BlocBuilder<StaffDashboardCubit, StaffDashboardState>(
                        builder: (context, state) {
                          return IconButton(
                              icon: const Icon(
                                Icons.date_range,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                context
                                    .read<StaffDashboardProjectCubit>()
                                    .getStaffBoardChangedProjects( currentRequestData[StaffDashBoardProjectScreen.companyID],
                                    currentRequestData[StaffDashBoardProjectScreen.project],
                                    currentRequestData[
                                    StaffDashBoardProjectScreen.director],context);
                              });
                        },
                      ),
                    )
                  ]),
              body: BlocProvider.value(
                  value: StaffDashboardProjectCubit.get(context)
                    ..getFirstStaffBoardProjects(
                        currentRequestData[
                        StaffDashBoardProjectScreen.companyID],
                        currentRequestData[StaffDashBoardProjectScreen.project],
                        currentRequestData[
                        StaffDashBoardProjectScreen.director],
                        currentRequestData[StaffDashBoardProjectScreen.date])
                    ..onClearData(),
                  child: BlocConsumer<StaffDashboardProjectCubit,
                      StaffDashboardProjectState>(
                    listener: (context, state) {
                      if (state.projectStaffDashBoardEnumStates ==
                          ProjectStaffDashBoardEnumStates.success) {
                        EasyLoading.dismiss(animation: true);
                      } else if (state.projectStaffDashBoardEnumStates ==
                          ProjectStaffDashBoardEnumStates.loading) {
                        EasyLoading.show(
                          status: 'loading...',
                          maskType: EasyLoadingMaskType.black,
                          dismissOnTap: false,
                        );
                      } else if (state.projectStaffDashBoardEnumStates ==
                          ProjectStaffDashBoardEnumStates.failed) {
                        EasyLoading.dismiss(animation: true);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("error"),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 10, right: 10),
                            child: TextFormField(
                              focusNode: textFoucus,
                              // key: uniqueKey,
                              controller: textController,

                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              onChanged: (text) {
                                StaffDashboardProjectCubit.get(context)
                                    .writenText(text);
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                filled: true,
                                focusColor: Colors.black,
                                fillColor: Colors.grey.withOpacity(0.6),
                                // labelText: "Search contact",
                                hintText: 'Project Name...',
                                hintStyle: const TextStyle(color: Colors.black),
                                prefixIcon: const Icon(Icons.search,
                                    color: Colors.black),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide.none),
                                suffixIcon: (textController.text.isEmpty)
                                    ? null
                                    : IconButton(
                                  onPressed: () {
                                    textController.clear();
                                    textFoucus.unfocus();
                                    StaffDashboardProjectCubit.get(
                                        context)
                                        .onClearData();
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: _showModal(context),
                          ),
                          state.projectStaffDashBoardEnumStates ==
                              ProjectStaffDashBoardEnumStates.success
                              ? Flexible(
                            child: (state.isFiltered)
                                ? StaffDashboardProjectWidget(
                                state.getResult, state.date)
                                : StaffDashboardProjectWidget(
                                state.projectStaffDashBoardList,
                                state.date),
                          )
                              : Center(
                              child: (EasyLoading.isShow)
                                  ? Container()
                                  : const CircularProgressIndicator()),
                        ],
                      );
                    },
                  )),
            ),
          ),
        ));
  }

  Widget _showModal(context) {
    StaffDashboardProjectCubit.get(context).updateFilters();

    return DropdownSearch(
      // key: UniqueKey(),
        items: StaffDashboardProjectCubit.get(context).state.directorFilter,
        selectedItem: StaffDashboardProjectCubit.get(context)
            .state
            .chosenDirectorFilter
            .isEmpty
            ? null
            : StaffDashboardProjectCubit.get(context)
            .state
            .chosenDirectorFilter,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            filled: true,
            focusColor: Colors.black,
            fillColor: Colors.grey.withOpacity(0.6),
            // labelText: "Search contact",
            hintText: 'Directors',
            hintStyle: const TextStyle(color: Colors.black),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide.none),
          ),
        ),
        onChanged: (selectedFilters) {
          StaffDashboardProjectCubit.get(context)
              .chosenDirectorOptions(selectedFilters.toString());

          StaffDashboardProjectCubit.get(context).checkAllFilters();
        });

    // return BlocBuilder<StaffDashboardProjectCubit, StaffDashboardProjectState>(
    //    buildWhen: (previous, current) {
    //      return previous.chosenDirector !=
    //          current.chosenDirector;
    //    },
    //    builder: (cubitContext, state) {
    //      return Padding(
    //        padding: const EdgeInsets.all(5.0),
    //        child: MultiSelectionChipsFilters(
    //          filtersList:
    //          StaffDashboardProjectCubit.get(context).state.directorFilter,
    //          filterName: 'Directors',
    //          initialValue: state.chosenDirectorFilter,
    //          onTap: (item) {
    //            StaffDashboardProjectCubit.get(cubitContext)
    //                .chosenDirectorOptions([
    //              ...state.chosenDirectorFilter
    //            ]..remove(item));
    //          },
    //          onConfirm: (selectedFilters) {
    //            StaffDashboardProjectCubit.get(context)
    //                .chosenDirectorOptions(selectedFilters
    //                .map((e) => e.toString())
    //                .toList());
    //            StaffDashboardProjectCubit.get(context).checkAllFilters();
    //          },
    //        ),
    //      );
    //    },
    //  );
    // showModalBottomSheet(
    //     backgroundColor: const Color(0xff0F3C55),
    //     isScrollControlled: true,
    //     shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
    //     ),
    //     context: context,
    //     builder: (_) {
    //       return BlocProvider.value(
    //         value: BlocProvider.of<StaffDashboardProjectCubit>(context),
    //         child: StatefulBuilder(
    //             builder: (BuildContext context, StateSetter setState) {
    //           return BlocBuilder<StaffDashboardProjectCubit,
    //               StaffDashboardProjectState>(
    //             builder: (context, state) {
    //               return DraggableScrollableSheet(
    //                   expand: false,
    //                   maxChildSize: 0.8,
    //                   snap: true,
    //                   builder: (BuildContext context,
    //                       ScrollController scrollController) {
    //                     return BlocBuilder<StaffDashboardProjectCubit, StaffDashboardProjectState>(
    //                       buildWhen: (previous, current) {
    //                         return previous.chosenDirector !=
    //                             current.chosenDirector;
    //                       },
    //                       builder: (cubitContext, state) {
    //                         return Padding(
    //                           padding: const EdgeInsets.all(5.0),
    //                           child: MultiSelectionChipsFilters(
    //                             filtersList:
    //                             StaffDashboardProjectCubit.get(context).state.directorFilter,
    //                             filterName: 'Company',
    //                             initialValue: state.chosenDirectorFilter,
    //                             onTap: (item) {
    //                               StaffDashboardProjectCubit.get(cubitContext)
    //                                   .chosenCompaniesOptions([
    //                                 ...state.chosenDirectorFilter
    //                               ]..remove(item));
    //                             },
    //                             onConfirm: (selectedFilters) {
    //                               StaffDashboardProjectCubit.get(context)
    //                                   .chosenCompaniesOptions(selectedFilters
    //                                   .map((e) => e.toString())
    //                                   .toList());
    //                             },
    //                           ),
    //                         );
    //                       },
    //                     );
    //                     // return ItemView(items: state.projectStaffDashBoardList,bloc: StaffDashboardProjectCubit.get(context),scrollController: scrollController,);
    //                   });
    //             },
    //           );
    //         }),
    //       );
    //     });
  }
}

// class ItemView extends StatelessWidget {
//   const ItemView(
//       {Key? key, required this.items, required this.bloc, required this.scrollController,})
//       : super(key: key);
//
//   final ScrollController scrollController;
//   final List<ProjectStaffDashboardModel> items;
//   final StaffDashboardProjectCubit bloc;
//
//
//   @override
//   Widget build(BuildContext context) {
//     List<ProjectStaffDashboardModel> searchItems = items;
//     // final ResponsibleVacationCubit responsibleVacationCubit = BlocProvider.of<
//     //     ResponsibleVacationCubit>(context);
//     return Column(children: [
//       Padding(
//           padding: const EdgeInsets.all(8),
//           child: Row(children: [
//             Expanded(
//                 child: TextField(style: const TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.all(8),
//                       border: OutlineInputBorder(
//                         borderRadius:
//                         BorderRadius.circular(15.0),
//                         borderSide: const BorderSide(),
//                       ),
//
//                       prefixIcon: const Icon(
//                         Icons.search, color: Colors.white60,),
//                     ),
//                     onChanged: (value) {
//                       searchItems = items.where((element) => element.toString().toLowerCase().contains(value.toLowerCase())).toList();
//                       // StaffDashboardProjectCubit.searchForContacts(value);
//                     })),
//             CloseButton(
//                 color: Colors.white24,
//
//                 // icon: Icon(Icons.close),
//                 // color: Color(0xFF1F91E7),
//                 onPressed: () {
//                   StaffDashboardProjectCubit.get(context).onClearData();
//                   Navigator.of(context).pop();
//                 }),
//           ])),
//       Expanded(
//         child: ListView.separated(
//             controller: scrollController,
//             //5
//             itemCount: searchItems.isNotEmpty? searchItems.length :items.length,
//             separatorBuilder: (context, _) {
//               return const SizedBox(height: 2,);
//             },
//             itemBuilder: (context, index) {
//               return InkWell(
//                   child: _showBottomSheetWithSearch(
//                       index, searchItems.isNotEmpty? searchItems:items),
//                   onTap: () {
//                     //7
//                     // ScaffoldMessenger.of(context)
//                     //   ..hideCurrentSnackBar()
//                     //   ..showSnackBar(
//                     //       SnackBar(
//                     //           // behavior: SnackBarBehavior.floating,
//                     //           content: Text((items.isNotEmpty)
//                     //               ? items[index].name ?? ""
//                     //               : items[index].name ?? "")));
//                     // showSnackBar(
//                     //     SnackBar(
//                     //         behavior: SnackBarBehavior.floating,
//                     //         content: Text((_tempListOfCities !=
//                     //             null &&
//                     //             _tempListOfCities.length > 0)
//                     //             ? _tempListOfCities[index]
//                     //             : _listOfCities[index])));
//
//                     // bloc.chosenDirector(items[index]);
//                     // bloc.onClearData();
//                     Navigator.of(context).pop();
//                   });
//             }),
//       )
//     ]);
//
//
//     // return items.isEmpty
//     //     ? const Center(child: Text('no content'))
//     //     : ListView.builder(
//     //   itemBuilder: (BuildContext context, int index) {
//     //     return ItemTile(
//     //       item: items[index],
//     //       onDeletePressed: (id) {
//     //         // context.read<ResponsibleVacationCubit>().deleteItem(id);
//     //       },
//     //     );
//     //   },
//     //   itemCount: items.length,
//     // );
//   }
//
//
//   Widget _showBottomSheetWithSearch(int index,
//       List<ProjectStaffDashboardModel> listOfCities) {
//     return SizedBox(
//       height: 30,
//       child: Center(
//         child: Text(listOfCities[index].name ?? "Not Assigned",
//             // style: const TextStyle(color: Colors.black, fontSize: 16),
//             textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
//       ),
//     );
//   }
// }