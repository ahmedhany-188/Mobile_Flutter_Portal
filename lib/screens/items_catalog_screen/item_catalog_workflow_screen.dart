import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_respond_requests_history/item_catalog_respond_requests__history_cubit.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_respond_requests_history/item_catalog_respond_requests__history_state.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_request_work_flow.dart';
import 'package:hassanallamportalflutter/data/repositories/items_catalog_repositories/items_catalog_getall_repository.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import '../../widgets/error/error_widget.dart';

class CatalogRequestWorkFlowScreen extends StatefulWidget{

  static const routeName = "/work-flow-catalog-request-screen";

  static const catalogRequestIDWorkFlow = "catalogRequestIDWorkFlow";

  const CatalogRequestWorkFlowScreen({Key? key, this.requestData}) : super(key: key);

  final dynamic requestData;

  @override
  State<CatalogRequestWorkFlowScreen> createState() => CatalogRequestWorkFlowScreenClass();
}

class CatalogRequestWorkFlowScreenClass extends State<CatalogRequestWorkFlowScreen> {


  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.userData);

    final currentRequestData = widget.requestData;

    return WillPopScope(
      onWillPop: () async {
        await EasyLoading.dismiss(animation: true);
        return true;
      },
      child: BlocProvider<CatalogRespondRequestsHistoryCubit>(
        create: (context) =>
        (CatalogRespondRequestsHistoryCubit(
            ItemsCatalogGetAllRepository(user))
          ..getAllWorkFlowRequestList(
              currentRequestData[CatalogRequestWorkFlowScreen
                  .catalogRequestIDWorkFlow].toString())),
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
              }else if (state.catalogRespondRequestsHistoryEnumStates ==
                  CatalogRespondRequestsHistoryEnumStates.noDataFound) {
                EasyLoading.showError("No Data Found");
              }
            },
            builder: (context, state) {
              return Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(80.0),
                  child: Hero(
                    tag: 'hero',
                    child: AppBar(
                      backgroundColor: ConstantsColors
                          .bottomSheetBackgroundDark,
                      elevation: 0,
                      title: const Text('Request WorkFlow'),
                      centerTitle: true,

                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () =>{
                    CatalogRespondRequestsHistoryCubit.get(context).exportWorkFlowData(),
                  },
                  backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  icon: Assets.images.excel.image(fit: BoxFit.scaleDown,scale: 13),
                  label: const Text('Export'),
                ),
                body:
                    Container(
                      child:getCatalogWorkFlowHistoryData(
                          state.getCatalogWorkFlowList,state),
                    ),
              );
            }),
      ),
    );
  }


  SafeArea getCatalogWorkFlowHistoryData(
      List<CatalogRequestWorkFlow> getCatalogWorkFlowList,CatalogRespondRequestsHistoryInitial state) {
    if (getCatalogWorkFlowList.isNotEmpty) {
      if (getCatalogWorkFlowList[0].data != null) {
        return SafeArea(
          maintainBottomViewPadding: true,
          child: ListView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                  .onDrag,
              shrinkWrap: true,
              itemCount: getCatalogWorkFlowList[0].data?.length,
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
                                        "Group Name: ${getCatalogWorkFlowList[0]
                                            .data![index].groupName
                                            .toString()}", 18.0),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 4,),
                              itemWidgetRequestWorkFlow(
                                  "Requester Name: ${getCatalogWorkFlowList[0]
                                      .data![index].requesterName
                                      .toString()}", 14.0),
                              const SizedBox(height: 4,),
                              itemWidgetRequestWorkFlow(
                                  "Requester HRcode: ${getCatalogWorkFlowList[0]
                                      .data![index].requesterHRCode
                                      .toString()}", 14.0),
                              const SizedBox(height: 4,),
                              itemWidgetRequestWorkFlow(
                                  "Requester Email: ${getCatalogWorkFlowList[0]
                                      .data![index].requesterEmail
                                      .toString()}", 14.0),

                              const SizedBox(height: 4,),
                              itemWidgetRequestWorkFlow(
                                  "Request ID: ${getCatalogWorkFlowList[0]
                                      .data![index].requestID
                                      .toString()}", 14.0),

                              const SizedBox(height: 4,),
                              itemWidgetRequestWorkFlow(
                                  "Item Name: ${getCatalogWorkFlowList[0]
                                      .data![index].itemName
                                      .toString()}", 14.0),
                              const SizedBox(height: 4,),
                              itemWidgetRequestWorkFlow(
                                  "Item Code: ${getCatalogWorkFlowList[0]
                                      .data![index].itemCode
                                      .toString()}", 14.0),
                              const SizedBox(height: 4,),
                              itemWidgetRequestWorkFlow(
                                  "Action HRCode: ${getCatalogWorkFlowList[0]
                                      .data![index].actionByHRCode
                                      .toString()}", 14.0),
                              const SizedBox(height: 4,),
                              itemWidgetRequestWorkFlow(
                                  "Action by name: ${getCatalogWorkFlowList[0]
                                      .data![index].actionByName
                                      .toString()}", 14.0),
                              const SizedBox(height: 4,),
                              itemWidgetRequestWorkFlow(
                                  "Action Email: ${getCatalogWorkFlowList[0]
                                      .data![index].actionByEmail
                                      .toString()}", 14.0),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: cardText(
                                  getCatalogWorkFlowList[0]
                                      .data?[index].submittedDate!=null?

                                        "Action date: ${GlobalConstants
                                            .dateFormatViewedWithTime.format(
                                            GlobalConstants.dateFormatServer
                                                .parse(getCatalogWorkFlowList[0].data?[index].submittedDate??""
                                            ))}":"Action date:", 12.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        dottedGreyLine(),
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
                              const SizedBox(height: 4,),
                              itemWidgetRequestWorkFlowActionName(
                                  getCatalogWorkFlowList[0]
                                      .data![index].action ?? 0, 14.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
          ),
        );
      } else {
        return SafeArea(child:getWorkFlowResult(state));
      }
    }
    else {
      return SafeArea(child:getWorkFlowResult(state));
    }
  }

  Text cardText(String text, double size) {
    return Text(
      text,
      style: TextStyle(fontSize: size,
          color: ConstantsColors
              .bottomSheetBackground),);
  }

  Row itemWidgetRequestWorkFlow(String name, double fontSize) {
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

  Container dottedGreyLine() {
    return Container(
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
    );
  }

  Row itemWidgetRequestWorkFlowActionName(int action, double fontSize) {
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
      case 2:
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

  Center getWorkFlowResult(CatalogRespondRequestsHistoryInitial state) {
    if (state.catalogRespondRequestsHistoryEnumStates ==
        CatalogRespondRequestsHistoryEnumStates.noDataFound) {
      return Center(child: noDataFoundContainerCatalog("List is empty"));
    } else if (state.catalogRespondRequestsHistoryEnumStates ==
        CatalogRespondRequestsHistoryEnumStates.noConnection) {
      return Center(child: noDataFoundContainerCatalog("No internet connection"));
    }  else if(state.catalogRespondRequestsHistoryEnumStates ==
        CatalogRespondRequestsHistoryEnumStates.failed) {
      return Center(child: noDataFoundContainerCatalog("Something went wrong"));
    }else{
      return Center(child: noDataFoundContainerCatalog(""));
    }
  }

}