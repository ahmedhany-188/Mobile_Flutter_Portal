import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/my_requests_screen_bloc/my_requests_cubit.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_requests_model_form.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:hassanallamportalflutter/screens/my_requests_screen/my_requests_ticket_widget.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';

class MyRequestsScreen extends StatefulWidget {
  static const routeName = "my-requests-screen";
  const MyRequestsScreen({Key? key}) : super(key: key);

  @override
  State<MyRequestsScreen> createState() => MyRequestsScreenClass();
}

class MyRequestsScreenClass extends State<MyRequestsScreen>
    with RestorationMixin {
  FocusNode searchTextFieldFocusNode = FocusNode();
  TextEditingController textController = TextEditingController();
  List<MyRequestsModelData> searchResult = [];

  final isSelected = [
    RestorableBool(false),
    RestorableBool(false),
    RestorableBool(false),
  ];
  @override
  String get restorationId => 'toggle_button_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(isSelected[0], 'first_item');
    registerForRestoration(isSelected[1], 'second_item');
    registerForRestoration(isSelected[2], 'third_item');
  }

  @override
  void dispose() {
    for (final restorableBool in isSelected) {
      restorableBool.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    final user = context.select((AppBloc bloc) => bloc.state.userData);

    return BlocProvider.value
      (value:MyRequestsCubit.get(context)
          ..getRequests(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: CustomBackground(
          child: CustomTheme(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: const Text('My Requests'),
                centerTitle: true,
                bottom: PreferredSize(
                  preferredSize: const Size(double.infinity, 20),
                  child: BlocBuilder<MyRequestsCubit, MyRequestsState>(
                    builder: (context, state) {
                      return ToggleButtons(
                        borderColor: Colors.transparent,
                        selectedColor: Colors.lightBlue,
                        selectedBorderColor: Colors.transparent,
                        color: Colors.white,
                        onPressed: (index) {
                          if (state is BlocGetMyRequestsSuccessState) {
                            if (index == 0 && isSelected[index].value == false) {
                              searchResult.addAll(state.getMyRequests
                                  .where((element) => element.reqStatus
                                      .toString()
                                      .toLowerCase()
                                      .trim()
                                      .contains('1'))
                                  .toList());
                            }
                            if (index == 1 && isSelected[index].value == false) {
                              searchResult.addAll(state.getMyRequests
                                  .where((element) => element.reqStatus
                                      .toString()
                                      .toLowerCase()
                                      .trim()
                                      .contains('0'))
                                  .toList());
                            }
                            if (index == 2 && isSelected[index].value == false) {
                              searchResult.addAll(state.getMyRequests
                                  .where((element) => element.reqStatus
                                      .toString()
                                      .toLowerCase()
                                      .trim()
                                      .contains('2'))
                                  .toList());
                            }

                            if (index == 0 && isSelected[index].value == true) {
                              searchResult
                                  .removeWhere((element) => element.reqStatus == 1);
                            }
                            if (index == 1 && isSelected[index].value == true) {
                              searchResult
                                  .removeWhere((element) => element.reqStatus == 0);
                            }
                            if (index == 2 && isSelected[index].value == true) {
                              searchResult
                                  .removeWhere((element) => element.reqStatus == 2);
                            }
                          }

                          //sorting after selecting
                          searchResult.sort((a,b) => b.reqDate?.compareTo(a.reqDate!) ?? 0);

                          setState(() {
                            isSelected[index].value = !isSelected[index].value;
                          });
                        },
                        isSelected:
                            isSelected.map((element) => element.value).toList(),
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
                                      fontSize: 15, fontWeight: FontWeight.bold),
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
                                      fontSize: 15, fontWeight: FontWeight.bold),
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
                                      fontSize: 15, fontWeight: FontWeight.bold),
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
              body: BlocBuilder<MyRequestsCubit, MyRequestsState>(
                builder: (context, state) {
                  return SizedBox(
                    height: deviceSize.height,
                    child: state is BlocGetMyRequestsSuccessState
                        ? Column(
                            children: [
                              Container(
                                height: deviceSize.height * 0.09,
                                padding: const EdgeInsets.all(10.0),
                                child: TextField(
                                  controller: textController,
                                  onChanged: (_) {
                                    setState(() {
                                      searchResult = (searchResult.isEmpty)
                                          ? state.getMyRequests
                                          : searchResult
                                              .where(
                                                (element) =>
                                                    element.requestNo
                                                        .toString()
                                                        .toLowerCase()
                                                        .trim()
                                                        .contains(
                                                            textController.text) ||
                                                    element.serviceName
                                                        .toString()
                                                        .toLowerCase()
                                                        .trim()
                                                        .contains(
                                                            textController.text),
                                              )
                                              .toList();
                                    });
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    filled: true,
                                    prefixIcon: const Icon(Icons.search,color: Colors.white,),
                                    border: const OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide.none),
                                    // labelText: 'Search',
                                    hintText: "Search by 'request number, request name'",
                                    suffixIcon: (textController.text.isEmpty)
                                        ? null
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                searchResult.clear();
                                                textController.clear();
                                                searchTextFieldFocusNode.unfocus();
                                              });
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
                                height: deviceSize.height * 0.73,
                                child: (searchResult.isEmpty)
                                    ? (textController.text.isNotEmpty)
                                        ? const Center(
                                            child: Text('No Data Found'),
                                          )
                                        : MyRequestsItemWidget(state.getMyRequests)
                                    : MyRequestsItemWidget(searchResult),
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
    );
  }
}
