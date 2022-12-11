import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_respond_requests_history/item_catalog_respond_requests__history_cubit.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_respond_requests_history/item_catalog_respond_requests__history_state.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_request_work_flow.dart';
import 'package:hassanallamportalflutter/data/repositories/items_catalog_repositories/items_catalog_getall_repository.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/items_catalog_screen_getall.dart';

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
          (CatalogRespondRequestsHistoryCubit(ItemsCatalogGetAllRepository(user))..getAllWorkFlowRequestList(currentRequestData[CatalogRequestWorkFlowScreen.catalogRequestIDWorkFlow].toString())),
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
              },
              builder: (context, state) {

                return Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(80.0),
                    child: Hero(
                      tag: 'hero',
                      child: AppBar(
                        backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
                        elevation: 0,
                        leading: InkWell(onTap: () => Navigator.of(context).pushReplacementNamed(ItemsCatalogGetAllScreen.routeName),child: const Icon(Icons.home)),
                        title: const Text('Request WorkFlow'),
                        centerTitle: true,
                        // actions: <Widget>[
                        //   IconButton(
                        //     icon: const Icon(
                        //       Icons.shopping_cart,
                        //       color: Colors.white,
                        //     ),
                        //     onPressed: () {
                        //       Navigator.of(context).pushNamed(CartScreen.routeName);
                        //     },
                        //   ),
                        //   IconButton(
                        //     icon: const Icon(
                        //       Icons.favorite,
                        //       color: Colors.white,
                        //     ),
                        //     onPressed: () {
                        //       Navigator.of(context).pushNamed(
                        //           FavoriteScreen.routeName);
                        //     },
                        //   )
                        // ],
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25))),
                      ),
                    ),
                  ),

                  floatingActionButton:FloatingActionButton.extended(
                    onPressed: () {
                      // importDataRequests(state.getCatalogWorkFlowList[0]);
                    },
                    backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    icon: Assets.images.excel.image(fit: BoxFit.scaleDown,scale: 13),
                    label: const Text('Export'),
                  ),

                  body:
                  Container(
                    child: getCatalogWorkFlowHistoryData(
                        state.getCatalogWorkFlowList),
                  ),


                );
              }),
        )
    );
  }

  SafeArea getCatalogWorkFlowHistoryData(
      List<CatalogRequestWorkFlow> getCatalogWorkFlowList) {
    if (getCatalogWorkFlowList.isNotEmpty) {
      if (getCatalogWorkFlowList[0].data != null) {
        return SafeArea(
          maintainBottomViewPadding: true,
          child: ConditionalBuilder(
            condition: true,
            builder: (context) =>
                ListView.builder(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                        .onDrag,
                    shrinkWrap: true,
                    itemCount: getCatalogWorkFlowList[0].data?.length,
                    itemBuilder: (BuildContext context, int index)
                     {
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
                                        cardText(
                                            "Group Name: ${getCatalogWorkFlowList[0]
                                                .data![index].groupName
                                                .toString()}", 18.0),
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      children: <Widget>[
                                        const SizedBox(width: 30,),
                                        cardText(
                                            "Action: ${getCatalogWorkFlowList[0]
                                                .data![index].actionDesc
                                                .toString()}", 14.0),
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      children: <Widget>[
                                        const SizedBox(width: 30,),
                                        cardText(
                                            "Request ID: ${getCatalogWorkFlowList[0]
                                                .data![index].requestID
                                                .toString()}", 14.0),

                                      ],
                                    ),

                                    const SizedBox(height: 4,),
                                    Row(
                                      children: <Widget>[
                                        const SizedBox(width: 30,),
                                        Flexible(
                                          child: cardText(
                                              "Action by name: ${getCatalogWorkFlowList[0]
                                                  .data![index].actionByName
                                                  .toString()}", 14.0),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      children: <Widget>[
                                        const SizedBox(width: 30,),
                                        cardText(
                                            "Item Name: ${getCatalogWorkFlowList[0]
                                                .data![index].itemName
                                                .toString()}", 14.0),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        cardText(
                                            getCatalogWorkFlowList[0]
                                                .data![index].requestDate.toString(),
                                            12.0),
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
                                    Text(
                                        "${getCatalogWorkFlowList[0]
                                            .data![index]
                                            .action.toString()}",
                                        style: const TextStyle(fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),
            fallback: (context) =>
            const Center(
                child: CircularProgressIndicator(color: Colors.white,)),
          ),
        );
      } else {
        return const SafeArea(child: Text(""));
      }
    }
    else {
      return const SafeArea(child: Text(""),);
    }
  }

  Text cardText(String text, double size) {
    return Text(
      text,
      style: TextStyle(fontSize: size,
          color: ConstantsColors
              .bottomSheetBackground),);
  }
}