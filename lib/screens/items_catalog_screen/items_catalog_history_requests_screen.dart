import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_requests_history/item_catalog_requests_history_cubit.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_requests_history/item_catalog_requests_history_state.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_requestCatalog_reponse.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_new_request_model.dart';
import 'package:hassanallamportalflutter/data/repositories/items_catalog_repositories/items_catalog_getall_repository.dart';
import '../../widgets/error/error_widget.dart';

class CatalogHistoryRequestScreen extends StatefulWidget{
  static const routeName = "/history-catalog-request-screen";
  const CatalogHistoryRequestScreen({Key? key}) : super(key: key);
  @override
  State<CatalogHistoryRequestScreen> createState() => CatalogHistoryRequestScreenClass();
}

class CatalogHistoryRequestScreenClass extends State<CatalogHistoryRequestScreen> {

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.userData);
    return WillPopScope(
        onWillPop: () async {
          await EasyLoading.dismiss(animation: true);
          return true;
        },
        child: BlocProvider<CatalogRequestsHistoryCubit>(
          create: (context) =>
          CatalogRequestsHistoryCubit(ItemsCatalogGetAllRepository(user))
            ..getAllRequestList(user.employeeData?.userHrCode.toString()),
          child: BlocConsumer<CatalogRequestsHistoryCubit,
              CatalogRequestsHistoryInitial>(
              listener: (context, state) {
                if (state.catalogRequestsHistoryEnumStates ==
                    CatalogRequestsHistoryEnumStates.success) {
                  EasyLoading.dismiss(animation: true);
                }
                else if (state.catalogRequestsHistoryEnumStates ==
                    CatalogRequestsHistoryEnumStates.loading) {
                  EasyLoading.show(status: 'loading...',
                    maskType: EasyLoadingMaskType.black,
                    dismissOnTap: false,);
                }
                else if (state.catalogRequestsHistoryEnumStates ==
                    CatalogRequestsHistoryEnumStates.failed) {
                  EasyLoading.showError(state.message);
                } else if (state.catalogRequestsHistoryEnumStates ==
                    CatalogRequestsHistoryEnumStates.valid) {
                  EasyLoading.dismiss(animation: true);
                }
                else if (state.catalogRequestsHistoryEnumStates ==
                    CatalogRequestsHistoryEnumStates.noConnection) {
                  EasyLoading.dismiss(animation: true);
                }else if (state.catalogRequestsHistoryEnumStates ==
                    CatalogRequestsHistoryEnumStates.noDataFound) {
                  EasyLoading.showError("No Data Found");
                }
              },
              builder: (context, state) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(80.0),
                    child: Hero(
                      tag: 'hero',
                      child: AppBar(
                        backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
                        elevation: 0,
                        leading: InkWell(onTap: () => Navigator.of(context).pop(),child: const Icon(Icons.home)),
                        title: const Text('Request History'),
                        centerTitle: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25))),
                      ),
                    ),
                  ),
                  body: Container(
                    child: getCatalogHistoryData(
                        state.getCatalogRequestsHistoryList,state),
                  ),
                );
              }),
        )
    );
  }

  SafeArea getCatalogHistoryData(
      List<NewRequestCatalogModelResponse> getCatalogRequestsHistoryList,CatalogRequestsHistoryInitial state) {
    if (getCatalogRequestsHistoryList.isNotEmpty) {
      if (getCatalogRequestsHistoryList[0].data != null) {
        return SafeArea(
          maintainBottomViewPadding: true,
          child: ListView.builder(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                        .onDrag,
                    shrinkWrap: true,
                    itemCount: getCatalogRequestsHistoryList[0].data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300,
                                  width: 3.0),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24),
                              )
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 5, top: 16),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(24),
                                        topRight: Radius.circular(24))
                                ),

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
                                              "Item Name: ${getCatalogRequestsHistoryList[0]
                                                  .data?[index].itemName
                                                  .toString()}", 18.0),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      children: <Widget>[
                                        const SizedBox(width: 30,),
                                        Flexible(
                                          child: cardText(
                                              "Description: ${getCatalogRequestsHistoryList[0]
                                                  .data?[index].itemDesc
                                                  .toString()}", 14.0),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      children: <Widget>[
                                        const SizedBox(width: 30,),
                                        Flexible(
                                          child: cardText(
                                              "Request ID: ${getCatalogRequestsHistoryList[0]
                                                  .data?[index].requestID
                                                  .toString()}", 14.0),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 4,),
                                    Row(
                                      children: <Widget>[
                                        const SizedBox(width: 30,),
                                        Flexible(
                                          child: cardText(
                                              "Category: ${getCatalogRequestsHistoryList[0]
                                                  .data?[index].catName
                                                  .toString()}", 14.0),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: cardText(

                                    GlobalConstants.dateFormatViewedWithTime.format(
                                    GlobalConstants.dateFormatServer.parse(
                                          getCatalogRequestsHistoryList[0]
                                              .data?[index].date.toString()??""
                                    )),
                                              12.0),
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
                                child: Row(
                                  children: <Widget>[


                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius: BorderRadius.circular(
                                                20)
                                        ),
                                        child: const Icon(Icons.cached,
                                            color: ConstantsColors
                                                .backgroundStartColor),
                                      ),
                                      const SizedBox(width: 16,),
                                      Flexible(
                                        child: Text(
                                            "${getCatalogRequestsHistoryList[0]
                                                .data?[index]
                                                .status.toString()}...",
                                            style: const TextStyle(fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey)),
                                      ),

                                  ],
                                ),
                              ),
                              getCatalogRequestsHistoryList[0]
                                  .data?[index].groupStep==1
                              && getCatalogRequestsHistoryList[0]
                              .data?[index].status=="In Progress"
                                  ?ElevatedButton.icon(
                                onPressed: () {
                                  NewRequestCatalogModel cancelRequestObject = NewRequestCatalogModel(
                                      requestID:getCatalogRequestsHistoryList[0].data?[index].requestID,
                                      findItemID:getCatalogRequestsHistoryList[0].data?[index].findItemID,
                                      inDate:getCatalogRequestsHistoryList[0].data?[index].date,
                                      itemName:getCatalogRequestsHistoryList[0].data?[index].itemName,
                                      catID:getCatalogRequestsHistoryList[0].data?[index].catID,
                                      itemDesc:getCatalogRequestsHistoryList[0].data?[index].itemDesc,
                                      groupStep:getCatalogRequestsHistoryList[0].data?[index].groupStep
                                  );
                                  context.read<CatalogRequestsHistoryCubit>().cancelRequest(cancelRequestObject);
                                },
                                label: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                        color: Colors
                                            .white)),
                                icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.redAccent),
                              ):Text(""),
                            ],
                          ),
                        ),
                      );
                    }
                ),
        );
      } else {
        return SafeArea(child: getFavoriteResult(state));
      }
    }
    else {
      return  SafeArea(child: getFavoriteResult(state));
    }
  }
  Text cardText(String text, double size) {
    return Text(
      text,
      style: TextStyle(fontSize: size,
          color: ConstantsColors
              .bottomSheetBackground),);
  }

  Center getFavoriteResult(CatalogRequestsHistoryInitial state) {
    if (state.catalogRequestsHistoryEnumStates ==
        CatalogRequestsHistoryEnumStates.noDataFound) {
      return Center(child: noDataFoundContainerCatalog("List is empty"));
    } else if (state.catalogRequestsHistoryEnumStates ==
        CatalogRequestsHistoryEnumStates.noConnection) {
      return Center(child: noDataFoundContainerCatalog("No internet connection"));
    }  else if(state.catalogRequestsHistoryEnumStates ==
        CatalogRequestsHistoryEnumStates.failed) {
      return Center(child: noDataFoundContainerCatalog("Something went wrong"));
    }else{
      return Center(child: noDataFoundContainerCatalog(""));
    }
  }
}

