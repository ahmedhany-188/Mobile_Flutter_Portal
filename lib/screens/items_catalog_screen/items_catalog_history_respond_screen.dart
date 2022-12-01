import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_respond_requests_history/item_catalog_respond_requests__history_cubit.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_respond_requests_history/item_catalog_respond_requests__history_state.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_respond_requests_model.dart';
import 'package:hassanallamportalflutter/data/repositories/items_catalog_repositories/items_catalog_getall_repository.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/cart_screen.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/favorite_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/item_catalog_workflow_screen.dart';

class CatalogHistoryRespondScreen extends StatefulWidget{

  static const routeName = "/history-catalog-respond-screen";
  const CatalogHistoryRespondScreen({Key? key}) : super(key: key);
  @override
  State<CatalogHistoryRespondScreen> createState() => CatalogHistoryRespondScreenClass();
}

class CatalogHistoryRespondScreenClass extends State<CatalogHistoryRespondScreen> {


  @override
  Widget build(BuildContext context) {
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
              },
              builder: (context, state) {

                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
                    elevation: 0,
                    title: const Text('Request History'),
                    centerTitle: true,
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(CartScreen.routeName);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              FavoriteScreen.routeName);
                        },
                      )
                    ],
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                  ),

                  floatingActionButton:FloatingActionButton.extended(
                    onPressed: () {
                      // importDataRespondRequests(state.getCatalogRespondRequestsHistoryList[0]);
                    },
                    backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    icon: Assets.images.excel.image(fit: BoxFit.scaleDown,scale: 13),
                    label: const Text('Export'),
                  ),

                  body: Container(
                    child: getRespondCatalogHistoryData(
                        state.getCatalogRespondRequestsHistoryList),
                  ),

                );
              }),
        )
    );
  }

  SafeArea getRespondCatalogHistoryData(List<ItemCatalogRespondRequests> getCatalogRespondRequestsHistoryList) {
    if (getCatalogRespondRequestsHistoryList.isNotEmpty) {
      if (getCatalogRespondRequestsHistoryList[0].data != null) {
        return SafeArea(
          maintainBottomViewPadding: true,
          child: ConditionalBuilder(
            condition: true,
            builder: (context) =>
                GridView.builder(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                        .onDrag,
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      // childAspectRatio: (1 / .4),
                      // mainAxisExtent: 285, // here set custom Height You Want
                      // width between items
                      crossAxisSpacing: 2,
                      // height between items
                      mainAxisSpacing: 5,
                    ),
                    itemCount: getCatalogRespondRequestsHistoryList[0].data?.length,
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
                                          padding: EdgeInsets.all(5),
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
                                        SizedBox(width: 5,),
                                        Flexible(
                                          child: cardText(
                                              "user Action: ${getCatalogRespondRequestsHistoryList[0]
                                                  .data![index].userAction
                                                  .toString()}", 18.0),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4,),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(width: 30,),
                                        cardText(
                                            "cat Name: ${getCatalogRespondRequestsHistoryList[0]
                                                .data![index].catName
                                                .toString()}", 14.0),
                                      ],
                                    ),
                                    SizedBox(height: 4,),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(width: 30,),
                                        cardText(
                                            "Action Name: ${getCatalogRespondRequestsHistoryList[0]
                                                .data![index].actionName
                                                .toString()}", 14.0),
                                      ],
                                    ),
                                    SizedBox(height: 4,),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(width: 30,),
                                        cardText(
                                            "Request No: ${getCatalogRespondRequestsHistoryList[0]
                                                .data![index].requestNo
                                                .toString()}", 14.0),

                                      ],
                                    ),

                                    SizedBox(height: 4,),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(width: 30,),
                                        cardText(
                                            "Category ID: ${getCatalogRespondRequestsHistoryList[0]
                                                .data![index].catID
                                                .toString()}", 14.0),

                                      ],
                                    ),

                                    SizedBox(height: 4,),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(width: 30,),
                                        cardText(
                                            "Submitted Hr Code: ${getCatalogRespondRequestsHistoryList[0]
                                                .data![index].submittedHrCode
                                                .toString()}", 14.0),

                                      ],
                                    ),

                                    SizedBox(height: 4,),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(width: 30,),
                                        cardText(
                                            "Category: ${getCatalogRespondRequestsHistoryList[0]
                                                .data![index].catName
                                                .toString()}", 14.0),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        cardText(
                                            "Submitted Date: ${getCatalogRespondRequestsHistoryList[0]
                                                .data![index].submittedDate.toString()}",
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

                                child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).pushNamed(CatalogRequestWorkFlowScreen.routeName,
                                    arguments: {
                                      CatalogRequestWorkFlowScreen.catalogRequestIDWorkFlow:
                                      getCatalogRespondRequestsHistoryList[0].data![index].request?.requestID
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius: BorderRadius.circular(
                                                20)
                                        ),
                                        child: Icon(Icons.incomplete_circle,
                                            color: ConstantsColors
                                                .backgroundStartColor),
                                      ),
                                      SizedBox(width: 16,),
                                      Text(
                                          "Status action: ${getCatalogRespondRequestsHistoryList[0]
                                              .data![index]
                                              .action.toString()}...",
                                          style: const TextStyle(fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey)),
                                    ],
                                  ),
                                )

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