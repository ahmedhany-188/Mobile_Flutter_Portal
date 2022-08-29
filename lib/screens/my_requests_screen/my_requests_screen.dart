import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/my_requests_screen_bloc/my_requests_cubit.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_requests_model_form.dart';
import 'package:hassanallamportalflutter/screens/my_requests_screen/my_requests_ticket_widget.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';

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
                          state.rejected
                        ],
                        onPressed: (index) {
                          if (state.userRequestsEnumStates ==
                              UserRequestsEnumStates.success) {
                            if (index == 0 && state.approved == false) {
                              searchResult.addAll(state.getMyRequests
                                  .where((element) => element.reqStatus
                                      .toString()
                                      .toLowerCase()
                                      .trim()
                                      .contains('1'))
                                  .toList());
                              MyRequestsCubit.get(context)
                                  .onApprovedSelected(searchResult);
                            }
                            if (index == 1 && state.pending == false) {
                              searchResult.addAll(state.getMyRequests
                                  .where((element) => element.reqStatus
                                      .toString()
                                      .toLowerCase()
                                      .trim()
                                      .contains('0'))
                                  .toList());
                              MyRequestsCubit.get(context)
                                  .onPendingSelected(searchResult);
                            }
                            if (index == 2 && state.rejected == false) {
                              searchResult.addAll(state.getMyRequests
                                  .where((element) => element.reqStatus
                                      .toString()
                                      .toLowerCase()
                                      .trim()
                                      .contains('2'))
                                  .toList());
                              MyRequestsCubit.get(context)
                                  .onRejectedSelected(searchResult);
                            }

                            if (index == 0 && state.approved == true) {
                              searchResult.removeWhere(
                                  (element) => element.reqStatus == 1);
                              MyRequestsCubit.get(context)
                                  .onApprovedUnSelected(searchResult);
                            }
                            if (index == 1 && state.pending == true) {
                              searchResult.removeWhere(
                                  (element) => element.reqStatus == 0);
                              MyRequestsCubit.get(context)
                                  .onPendingUnSelected(searchResult);
                            }
                            if (index == 2 && state.rejected == true) {
                              searchResult.removeWhere(
                                  (element) => element.reqStatus == 2);
                              MyRequestsCubit.get(context)
                                  .onRejectedUnSelected(searchResult);
                            }

                            MyRequestsCubit.get(context).checkAllFilters();

                            //sorting after selecting
                            searchResult.sort((a, b) =>
                                b.reqDate?.compareTo(a.reqDate!) ?? 0);

                            // isSelected[index].value = !isSelected[index].value;
                          }
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
                                )
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
                                      : MyRequestsItemWidget(
                                          state.gettempMyRequests),
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
