import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_respond_requests_history/item_catalog_respond_requests__history_cubit.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_respond_requests_history/item_catalog_respond_requests__history_state.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_respond_requests_model.dart';
import 'package:hassanallamportalflutter/data/repositories/items_catalog_repositories/items_catalog_getall_repository.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/item_catalog_workflow_screen.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/items_catalog_screen_getall.dart';
import '../../widgets/error/error_widget.dart';

class CatalogHistoryRespondScreen extends StatefulWidget{

  static const routeName = "/history-catalog-respond-screen";
  const CatalogHistoryRespondScreen({Key? key}) : super(key: key);
  @override
  State<CatalogHistoryRespondScreen> createState() => CatalogHistoryRespondScreenClass();
}

class CatalogHistoryRespondScreenClass extends State<CatalogHistoryRespondScreen> {

  @override
  Widget build(BuildContext context) {
    FocusNode textFoucus = FocusNode();
    TextEditingController textController = TextEditingController();
    final user = context.select((AppBloc bloc) => bloc.state.userData);
    return WillPopScope(
        onWillPop: () async {
          await EasyLoading.dismiss(animation: true);
          return true;
        },
        child: BlocProvider<CatalogRespondRequestsHistoryCubit>(
          create: (context) =>
          CatalogRespondRequestsHistoryCubit(ItemsCatalogGetAllRepository(user))
            ..getAllRequestList(user.employeeData?.userHrCode),
          child: BlocConsumer<CatalogRespondRequestsHistoryCubit,
              CatalogRespondRequestsHistoryInitial>(
              listener: (context, state) {
                if (state.catalogRespondRequestsHistoryEnumStates ==
                    CatalogRespondRequestsHistoryEnumStates.success) {
                  EasyLoading.dismiss(animation: true);
                }
                else if (state.catalogRespondRequestsHistoryEnumStates ==
                    CatalogRespondRequestsHistoryEnumStates.loading) {
                  EasyLoading.show(status: 'loading...',
                    maskType: EasyLoadingMaskType.black,
                    dismissOnTap: false,);
                }
                else if (state.catalogRespondRequestsHistoryEnumStates ==
                    CatalogRespondRequestsHistoryEnumStates.failed) {
                  EasyLoading.showError(state.message);
                } else if (state.catalogRespondRequestsHistoryEnumStates ==
                    CatalogRespondRequestsHistoryEnumStates.valid) {
                  EasyLoading.dismiss(animation: true);
                }
                else if (state.catalogRespondRequestsHistoryEnumStates ==
                    CatalogRespondRequestsHistoryEnumStates.noConnection) {
                  EasyLoading.dismiss(animation: true);
                } else if (state.catalogRespondRequestsHistoryEnumStates ==
                    CatalogRespondRequestsHistoryEnumStates.noDataFound) {
                  EasyLoading.showError("No Data Found");
                }
              },
              builder: (context, state) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(150.0),
                    child: Hero(
                      tag: 'hero',
                      child: AppBar(
                        backgroundColor: ConstantsColors
                            .bottomSheetBackgroundDark,
                        elevation: 0,
                        title: const Text('Request Status'),
                        centerTitle: true,
                        leading: InkWell(onTap: () =>
                            Navigator.of(context)
                                .pop(ItemsCatalogGetAllScreen
                                .routeName), child: const Icon(Icons.home)),
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(0.0),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 40.0, right: 40, bottom: 20),
                              child: TextFormField(
                                focusNode: textFoucus,
                                // key: uniqueKey,
                                keyboardType: TextInputType.number,
                                controller: textController,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                onChanged: (text) {
                                  if (text.isEmpty) {
                                    CatalogRespondRequestsHistoryCubit.get(
                                        context).clearData();
                                    textController.clear();
                                    textFoucus.unfocus();
                                  } else {
                                    CatalogRespondRequestsHistoryCubit.get(
                                        context).setSearchString(text);
                                  }
                                },
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets
                                        .all(10),
                                    filled: true,
                                    focusColor: Colors.white,
                                    fillColor: Colors.grey.shade400
                                        .withOpacity(0.4),
                                    // labelText: "Search contact",
                                    hintText: 'request ID',
                                    suffixIcon: (textController.text
                                        .isNotEmpty ||
                                        textController.text != "")
                                        ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      color: Colors.red,
                                      onPressed: () {
                                        CatalogRespondRequestsHistoryCubit.get(
                                            context)
                                            .clearData();
                                        textController.clear();
                                        textFoucus.unfocus();
                                      },
                                    )
                                        : null,
                                    hintStyle: const TextStyle(
                                        color: Colors.white),
                                    prefixIcon:
                                    const Icon(
                                        Icons.search,
                                        color: Colors.white),
                                    border: const OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(20.0)),
                                        borderSide: BorderSide.none)),
                              ),
                            ),
                          ),
                        ),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25))),
                      ),
                    ),
                  ),
                  body: Container(
                    child: state.filter
                        ? getRespondCatalogHistoryData(
                        state.getCatalogWorkFlowSearchList, state)
                        : getRespondCatalogHistoryData(
                        state.getCatalogRespondRequestsHistoryList, state),
                    // child: getRespondCatalogHistoryData(
                    //     state.getCatalogRespondRequestsHistoryList),
                  ),
                );
              }),
        )
    );
  }

  SafeArea getRespondCatalogHistoryData(
      List<ItemCatalogRespondRequests> getCatalogRespondRequestsHistoryList,
      CatalogRespondRequestsHistoryInitial state) {
    if (getCatalogRespondRequestsHistoryList.isNotEmpty) {
      if (getCatalogRespondRequestsHistoryList[0].data != null) {
        return SafeArea(
          maintainBottomViewPadding: true,
          child: ListView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              shrinkWrap: true,
              itemCount: getCatalogRespondRequestsHistoryList[0].data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300,
                            width: 3.0),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                        color: Colors.white
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 5, top: 16),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.indigo.shade50,
                                        borderRadius: BorderRadius
                                            .circular(20)
                                    ),
                                    child: SizedBox(
                                      height: 8,
                                      width: 8,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Colors.indigo.shade400,
                                            borderRadius: BorderRadius
                                                .circular(5)
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5,),
                                  Flexible(
                                    child: cardText(
                                        "user Action: ${getCatalogRespondRequestsHistoryList[0]
                                            .data![index].userAction
                                            .toString()}", 18.0),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5,),

                              itemWidgetRequestRespond(
                                  "Request No: ${getCatalogRespondRequestsHistoryList[0]
                                      .data![index].requestNo
                                      .toString()}", 14.0),

                              const SizedBox(height: 4,),

                              itemWidgetRequestRespond(
                                  "Item Name: ${getCatalogRespondRequestsHistoryList[0]
                                      .data![index].request?.itemName
                                      .toString()}", 14.0),

                              const SizedBox(height: 4,),

                              itemWidgetRequestRespond(
                                  "Item Code: ${getCatalogRespondRequestsHistoryList[0]
                                      .data![index].request?.itemCode
                                      .toString()}", 14.0),

                              const SizedBox(height: 4,),

                              itemWidgetRequestRespond(
                                  "Category Name: ${getCatalogRespondRequestsHistoryList[0]
                                      .data![index].catName
                                      .toString()}", 14.0),

                              const SizedBox(height: 4,),

                              itemWidgetRequestRespond(
                                  "User Hr Action: ${getCatalogRespondRequestsHistoryList[0]
                                      .data![index].submittedHrCode
                                      .toString()}", 14.0),

                              const SizedBox(height: 4,),

                              itemWidgetRequestRespondActionName(
                                  getCatalogRespondRequestsHistoryList[0]
                                      .data![index].action ?? -1, 14.0),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: cardText(
                                  //       "Action date:"+getCatalogRespondRequestsHistoryList[0]
                                  //           .data![index].submittedDate
                                  // .toString(),
                                        "Action date: ${GlobalConstants
                                            .dateFormatViewedWithTime.format(
                                            GlobalConstants.dateFormatServer
                                                .parse(
                                                getCatalogRespondRequestsHistoryList[0]
                                                    .data![index].inDate
                                                    .toString()
                                            ))}",
                                        12.0
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Container(
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return Flex(
                                        direction: Axis.horizontal,
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: List.generate(
                                            (constraints
                                                .constrainWidth() /
                                                10).floor(), (index) =>
                                            SizedBox(height: 1,
                                              width: 5,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                    color: Colors.grey
                                                        .shade400),),)
                                        ),
                                      );
                                    },),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(24),
                                  bottomRight: Radius.circular(24))
                          ),

                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  CatalogRequestWorkFlowScreen.routeName,
                                  arguments: {
                                    CatalogRequestWorkFlowScreen
                                        .catalogRequestIDWorkFlow:
                                    getCatalogRespondRequestsHistoryList[0]
                                        .data![index].request?.requestID
                                  });
                            },
                            label: const Text(
                                'Life Cycle',
                                style: TextStyle(
                                    color: Colors
                                        .white)),
                            icon: const Icon(
                                Icons.incomplete_circle,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
          ),
        );
      } else {
        return SafeArea(child: getHistoryRespondResult(state),);
      }
    }
    else {
      return SafeArea(child: getHistoryRespondResult(state),);
    }
  }

  Center getHistoryRespondResult(CatalogRespondRequestsHistoryInitial state) {
    if (state.catalogRespondRequestsHistoryEnumStates ==
        CatalogRespondRequestsHistoryEnumStates.noDataFound) {
      return Center(child: noDataFoundContainerCatalog("List is empty"));
    } else if (state.catalogRespondRequestsHistoryEnumStates ==
        CatalogRespondRequestsHistoryEnumStates.noConnection) {
      return Center(
          child: noDataFoundContainerCatalog("No internet connection"));
    } else if(state.catalogRespondRequestsHistoryEnumStates ==
        CatalogRespondRequestsHistoryEnumStates.failed) {
      return Center(child: noDataFoundContainerCatalog("Something went wrong"));
    }else{
      return Center(child: noDataFoundContainerCatalog(""));
    }
  }

  Text cardText(String text, double size) {
    return Text(
      text,
      style: TextStyle(fontSize: size,
          color: ConstantsColors
              .bottomSheetBackground),);
  }

  Row itemWidgetRequestRespond(String name, double fontSize) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 30,),
        Flexible(
          child: cardText(
              name, fontSize),
        ),
      ],
    );
  }

  Row itemWidgetRequestRespondActionName(int action, double fontSize) {
    switch (action) {
      case 1:
        return
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.verified,
                color: Colors.greenAccent,
              ),
              Text(
                ' Approved',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ],
          );
      case 4:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.pending_actions_outlined,
              color: Colors.yellow,
            ),
            Text(
              'Category Changed',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            )
          ],
        );

      case 3:
        return
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.cancel,
                color: Colors.red,
              ),
              Text(
                ' Return to user',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ],
          );

      default:
        {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.pending_actions_outlined,
                color: Colors.yellow,
              ),
              Text(
                ' Pending',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )
            ],
          );
        }
    }
  }
}