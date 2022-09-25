import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/my_requests_screen_bloc/my_requests_cubit.dart';
import 'package:hassanallamportalflutter/bloc/statistics_bloc/statistics_cubit.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_requests_model_form.dart';
import 'package:hassanallamportalflutter/screens/my_requests_screen/my_requests_ticket_widget.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class MyRequestsScreen extends StatefulWidget {
  static const routeName = "my-requests-screen";
  const MyRequestsScreen({Key? key}) : super(key: key);

  @override
  State<MyRequestsScreen> createState() => MyRequestsScreenClass();
}

class MyRequestsScreenClass extends State<MyRequestsScreen> {
  // with RestorationMixin {
  FocusNode searchTextFieldFocusNode = FocusNode();
  TextEditingController textController = TextEditingController();
  List<MyRequestsModelData> searchResult = [];

  // // final isSelected = [
  // //   RestorableBool(false),
  // //   RestorableBool(false),
  // //   RestorableBool(false),
  // // ];
  // @override
  // String get restorationId => 'toggle_button_demo';
  //
  // @override
  // void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
  //   // registerForRestoration(isSelected[0], 'first_item');
  //   // registerForRestoration(isSelected[1], 'second_item');
  //   // registerForRestoration(isSelected[2], 'third_item');
  // }
  //
  // @override
  // void dispose() {
  //   // for (final restorableBool in isSelected) {
  //   //   restorableBool.dispose();
  //   // }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return BlocProvider.value(
      value: MyRequestsCubit.get(context),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: CustomBackground(
          child: CustomTheme(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: const Text('My Requests'),
                centerTitle: true,
                actions: [
                  /// removed bloc provider
                  BlocBuilder<StatisticsCubit, StatisticsInitial>(
                    builder: (context, state) {
                      return IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                // isScrollControlled: true,
                                builder: (_) {
                                  return Container(
                                      // height:
                                      //     MediaQuery.of(context).size.height *
                                      //         0.85,
                                      // padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 2.5),
                                            child: Text(
                                              'Statistics',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: 250,
                                          //   child: Swiper(
                                          //     autoplay: true,
                                          //     autoplayDelay: 3000,
                                          //     physics: const BouncingScrollPhysics(),
                                          //     curve: Curves.easeOutSine,
                                          //     indicatorLayout: PageIndicatorLayout.COLOR,
                                          //     control: const SwiperControl(color: Colors.white),
                                          //     pagination: const SwiperPagination(
                                          //       alignment: Alignment.topLeft,
                                          //       margin: EdgeInsets.all(5),
                                          //       builder: FractionPaginationBuilder(
                                          //           color: Colors.white,
                                          //           activeColor: Colors.white,
                                          //           fontSize: 18,
                                          //           activeFontSize: 20),
                                          //     ),
                                          //     itemCount:
                                          //         state.statisticsList.length,
                                          //     itemBuilder: (c, index) {
                                          //       return SizedBox(
                                          //         height: 200,
                                          //         child: SfRadialGauge(
                                          //           enableLoadingAnimation:
                                          //               true,
                                          //           animationDuration: 1000,
                                          //           title: GaugeTitle(
                                          //               text: state
                                          //                   .statisticsList[
                                          //                       index]
                                          //                   .serviceName!,
                                          //               textStyle:
                                          //                   const TextStyle()),
                                          //           axes: [
                                          //             RadialAxis(
                                          //               ranges: [
                                          //                 GaugeRange(
                                          //                   startValue: 0,
                                          //                   endValue: double
                                          //                       .parse(state
                                          //                           .statisticsList[
                                          //                               index]
                                          //                           .consumed!),
                                          //                   rangeOffset: 1,
                                          //                   gradient:
                                          //                       const SweepGradient(
                                          //                           colors: [
                                          //                         ConstantsColors
                                          //                             .petrolTextAttendance,
                                          //                         ConstantsColors
                                          //                             .buttonColors
                                          //                       ]),
                                          //                 ),
                                          //               ],
                                          //               showLastLabel: true,
                                          //               radiusFactor: 1,
                                          //               minimum: 0,
                                          //               maximum: (double.parse(state
                                          //                           .statisticsList[
                                          //                               index]
                                          //                           .balance!) !=
                                          //                       0)
                                          //                   ? double.parse(state
                                          //                       .statisticsList[
                                          //                           index]
                                          //                       .balance!)
                                          //                   : 31,
                                          //               canScaleToFit: true,
                                          //               showTicks: false,
                                          //               axisLineStyle:
                                          //                   const AxisLineStyle(
                                          //                       thickness:
                                          //                           0.03,
                                          //                       thicknessUnit:
                                          //                           GaugeSizeUnit
                                          //                               .factor),
                                          //               axisLabelStyle:
                                          //                   const GaugeTextStyle(
                                          //                 color: Colors.white,
                                          //                 // fontSize: 20,
                                          //               ),
                                          //               interval: 2,
                                          //               pointers: [
                                          //                 NeedlePointer(
                                          //                   value: double
                                          //                       .parse(state
                                          //                           .statisticsList[
                                          //                               index]
                                          //                           .consumed!),
                                          //                   needleColor:
                                          //                       Colors.white,
                                          //                   needleEndWidth: 3,
                                          //                   knobStyle: const KnobStyle(
                                          //                       color: Colors
                                          //                           .white,
                                          //                       knobRadius:
                                          //                           0.04,
                                          //                       sizeUnit:
                                          //                           GaugeSizeUnit
                                          //                               .factor),
                                          //                 )
                                          //               ],
                                          //             ),
                                          //           ],
                                          //         ),
                                          //       );
                                          //     },
                                          //   ),
                                          // ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              const Text('Vacations'),
                                              Text(
                                                  '${state.statisticsList[0].balance} days'),
                                            ],
                                          ),
                                          SfSlider(
                                            value: double.parse(state
                                                    .statisticsList[0]
                                                    .consumed!) /
                                                double.parse(state
                                                    .statisticsList[0]
                                                    .balance!),
                                            onChanged: (_) {},
                                            thumbIcon: Center(
                                              child: Text(
                                                  '${state.statisticsList[0].consumed}'),
                                            ),
                                            activeColor: Colors.red,
                                            inactiveColor: Colors.white70,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              const Text(
                                                'Permissions',
                                              ),
                                              Text(
                                                  '${state.statisticsList[2].balance} hours'),
                                            ],
                                          ),
                                          SfSlider(
                                            value: double.parse(state
                                                    .statisticsList[2]
                                                    .consumed!) /
                                                double.parse(state
                                                    .statisticsList[2]
                                                    .balance!),
                                            onChanged: (_) {},
                                            thumbIcon: Center(
                                              child: Text(
                                                  '${state.statisticsList[2].consumed}'),
                                            ),
                                            activeColor: Colors.yellow,
                                            inactiveColor: Colors.white70,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: const [
                                              Text(
                                                'Business Mission',
                                              ),
                                              Text('No Limit'),
                                            ],
                                          ),
                                          SfSlider(
                                            value: double.parse(state
                                                    .statisticsList[1]
                                                    .consumed!) /
                                                31,
                                            onChanged: (_) {},
                                            thumbIcon: Center(
                                              child: Text(
                                                  '${state.statisticsList[1].consumed}'),
                                            ),
                                            activeColor: Colors.green,
                                            inactiveColor: Colors.white70,
                                          ),
                                        ],
                                      ));
                                });
                          },
                          icon: const Icon(Icons.stacked_bar_chart));
                    },
                  )
                ],
                bottom: PreferredSize(
                  preferredSize: const Size(double.infinity, 25),
                  child: BlocBuilder<MyRequestsCubit, MyRequestsState>(
                    builder: (context, state) {
                      return ToggleButtons(
                        borderColor: Colors.transparent,
                        selectedColor: Colors.lightBlue,
                        selectedBorderColor: Colors.transparent,
                        color: Colors.white,
                        isSelected: [
                          state.approved,
                          state.pending,
                          state.rejected,
                        ],
                        onPressed: (index) {
                          if (state.userRequestsEnumStates ==
                              UserRequestsEnumStates.success) {
                            // searchResult = [];

                            if (index == 0 && state.approved == false) {
                              // searchResult.addAll(state.getMyRequests
                              //     .where((element) => element.reqStatus == 1)
                              //     .toList());
                              MyRequestsCubit.get(context).onApprovedSelected([
                                ...state.getTempMyRequests,
                                ...state.getMyRequests
                                    .where((element) => element.reqStatus == 1)
                                    .toList(),
                              ]);
                            }
                            if (index == 1 && state.pending == false) {
                              // state.gettempMyRequests...addAll(state.getMyRequests
                              //     .where((element) => element.reqStatus == 0)
                              //     .toList());
                              MyRequestsCubit.get(context).onPendingSelected([
                                ...state.getTempMyRequests,
                                ...state.getMyRequests
                                    .where((element) => element.reqStatus == 0)
                                    .toList()
                              ]);
                            }
                            if (index == 2 && state.rejected == false) {
                              // searchResult.addAll(state.getMyRequests
                              //     .where((element) => element.reqStatus == 2)
                              //     .toList());
                              MyRequestsCubit.get(context).onRejectedSelected([
                                ...state.getTempMyRequests,
                                ...state.getMyRequests
                                    .where((element) => element.reqStatus == 2)
                                    .toList()
                              ]);
                            }

                            if (index == 0 && state.approved == true) {
                              // searchResult.removeWhere(
                              //     (element) => element.reqStatus == 1);
                              MyRequestsCubit.get(context).onApprovedUnSelected(
                                  [...state.getTempMyRequests]..removeWhere(
                                      (element) => element.reqStatus == 1));
                            }
                            if (index == 1 && state.pending == true) {
                              // searchResult.removeWhere(
                              //     (element) => element.reqStatus == 0);
                              MyRequestsCubit.get(context).onPendingUnSelected([
                                ...state.getTempMyRequests
                              ]..removeWhere(
                                  (element) => element.reqStatus == 0));
                            }
                            if (index == 2 && state.rejected == true) {
                              // searchResult.removeWhere(
                              //     (element) => element.reqStatus == 2);
                              MyRequestsCubit.get(context).onRejectedUnSelected(
                                  [...state.getTempMyRequests]..removeWhere(
                                      (element) => element.reqStatus == 2));
                            }
                            // MyRequestsCubit.get(context).setTemp(searchResult);

                            // MyRequestsCubit.get(context).checkAllFilters();
                            //sorting after selecting
                            // searchResult.sort((a, b) =>
                            //     b.reqDate?.compareTo(a.reqDate!) ?? 0);

                            // isSelected[index].value = !isSelected[index].value;
                          }
                          MyRequestsCubit.get(context).checkAllFilters();
                        },
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.done,
                                  color: Colors.greenAccent,
                                ),
                                Text(
                                  ' Approved',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.pending_actions_outlined,
                                  color: Colors.yellow,
                                ),
                                Text(
                                  ' In Progress',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                ),
                                Text(
                                  ' Rejected',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              resizeToAvoidBottomInset: false,
              body: RefreshIndicator(
                onRefresh: () async {
                  await MyRequestsCubit.get(context).getRequests();
                  // await Future.delayed(const Duration(milliseconds: 1000));
                  return Future(() => null);
                },
                child: BlocBuilder<MyRequestsCubit, MyRequestsState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: deviceSize.height,
                      child: (state.userRequestsEnumStates ==
                              UserRequestsEnumStates.success)
                          ? Column(
                              children: [
                                Container(
                                  height: deviceSize.height * 0.09,
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextField(
                                    controller: textController,
                                    focusNode: searchTextFieldFocusNode,
                                    onChanged: (text) {
                                      MyRequestsCubit.get(context)
                                          .writenText(text);
                                      // if(text.isEmpty){searchTextFieldFocusNode.unfocus();}
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(10),
                                      filled: true,
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText:
                                          "Search by 'request number, request name'",
                                      suffixIcon: (textController.text.isEmpty)
                                          ? null
                                          : IconButton(
                                              onPressed: () {
                                                textController.clear();
                                                searchTextFieldFocusNode
                                                    .unfocus();
                                                MyRequestsCubit.get(context)
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
                                SizedBox(
                                  height: deviceSize.height * 0.72,
                                  child: (!state.isFiltered)
                                      ? MyRequestsItemWidget(
                                          state.getMyRequests)
                                      : MyRequestsItemWidget(state.getResult),
                                ),
                              ],
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
