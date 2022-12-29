import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/data/data_providers/general_dio/general_dio.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/cart_screen.dart';
import 'package:hassanallamportalflutter/widgets/error/error_widget.dart';
import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../bloc/items_catalog_bloc/order_history/order_history_cubit.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';

class ItemCatalogOrderHistory extends StatelessWidget {
  const ItemCatalogOrderHistory({Key? key}) : super(key: key);
  static const routeName = 'order-history';

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.userData);
    return WillPopScope(
      onWillPop: () async {
        await EasyLoading.dismiss(animation: true);
        Navigator.of(context)
            .pushReplacementNamed(
            CartScreen.routeName);
        return true;
      },
      child: BlocProvider<OrderHistoryCubit>(
        create: (context) =>
        OrderHistoryCubit(GeneralDio(user))
          ..getOrderHistoryList(user.employeeData?.userHrCode ?? ""),
        //  ..checkTheValueOfTree()),
        child: BlocConsumer<OrderHistoryCubit, OrderHistoryState>(
          listener: (context, state) {
            if (state.orderHistoryEnumStates ==
                OrderHistoryEnumStates.success) {
              EasyLoading.dismiss();
            } else if (state.orderHistoryEnumStates ==
                OrderHistoryEnumStates.noConnection) {
              EasyLoading.showError("No Internet Connection");
            } else if (state.orderHistoryEnumStates ==
                OrderHistoryEnumStates.failed) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("error"),
                ),
              );
            } else if (state.orderHistoryEnumStates ==
                OrderHistoryEnumStates.loadingTreeData) {
              EasyLoading.show();
            } else if (state.orderHistoryEnumStates ==
                OrderHistoryEnumStates.noDataFound) {
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
                    leading: InkWell(
                      onTap: () =>
                      { Navigator.of(context)
                          .pushReplacementNamed(
                          CartScreen.routeName)},
                      child: const Icon(Icons.chevron_left,
                          color: Colors.white, size: 50),
                    ),
                    title: const Text('Order History'),
                    centerTitle: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                  ),
                ),
              ),
              body: SafeArea(
                maintainBottomViewPadding: true,
                child: state.orderHistoryList.isNotEmpty ? ListView.builder(
                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
                  shrinkWrap: true,
                  itemCount: state.orderHistoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.shade300, width: 3.0),
                          borderRadius: BorderRadius.circular(20),
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
                                      topRight: Radius.circular(24))),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.indigo.shade50,
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        child: SizedBox(
                                          height: 8,
                                          width: 8,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: Colors.indigo.shade400,
                                                borderRadius:
                                                BorderRadius.circular(5)),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0),
                                          child: cardText(
                                              "Order Number: ${state
                                                  .orderHistoryList[index].id}",
                                              16.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30.0, top: 4),
                                          child: cardText(
                                              "Items: ${state
                                                  .orderHistoryList[index]
                                                  .itemCount}",
                                              14.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0),
                                          child: cardText(
                                            GlobalConstants
                                                .dateFormatViewedWithTime
                                                .format(
                                              GlobalConstants.dateFormatServer
                                                  .parse(state
                                                  .orderHistoryList[index]
                                                  .orderDate
                                                  .toString()),
                                            ),
                                            13.0,
                                          ),
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
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: List.generate(
                                                (constraints.constrainWidth() /
                                                    10)
                                                    .floor(),
                                                    (index) =>
                                                    SizedBox(
                                                      height: 1,
                                                      width: 5,
                                                      child: DecoratedBox(
                                                        decoration:
                                                        BoxDecoration(
                                                            color: Colors
                                                                .grey
                                                                .shade400),
                                                      ),
                                                    )),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(24),
                                      bottomRight: Radius.circular(24))),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await OrderHistoryCubit.get(context)
                                            .getOrderData(
                                            user.employeeData
                                                ?.userHrCode ??
                                                "",
                                            state.orderHistoryList[index]
                                                .id)
                                            .then((_) =>
                                            OrderHistoryCubit
                                                .get(context)
                                                .showItemsDialog(
                                                context,
                                                user.employeeData
                                                    ?.userHrCode ??
                                                    ""));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(15))),
                                      child: const Text('Show Items'),
                                    ),
                                  ),
                                  Flexible(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await OrderHistoryCubit.get(context)
                                            .getOrderData(
                                            user.employeeData
                                                ?.userHrCode ??
                                                "",
                                            state.orderHistoryList[index]
                                                .id)
                                            .then(
                                              (_) {
                                            for (int i = 0;
                                            i <
                                                state
                                                    .orderDataList.length;
                                            i++) {
                                              OrderHistoryCubit.get(context)
                                                  .reAddToCart(
                                                hrCode: user.employeeData
                                                    ?.userHrCode ??
                                                    "",
                                                itemCode: state
                                                    .orderDataList[i]
                                                    .itemID ??
                                                    0,
                                              );
                                            }
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(15))),
                                      child: const Text('Re-Add to cart'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ) : getOrderHistoryResult(state),
              ),
            );
          },
        ),
      ),
    );
  }

  Center getOrderHistoryResult(OrderHistoryState state) {
    if (state.orderHistoryEnumStates ==
        OrderHistoryEnumStates.noDataFound) {
      return Center(child: noDataFoundContainerCatalog("List is empty"));
    } else if (state.orderHistoryEnumStates ==
        OrderHistoryEnumStates.noConnection) {
      return Center(child: noDataFoundContainerCatalog("No internet connection"));
    } else {
      return Center(child: noDataFoundContainerCatalog("Something went wrong"));
    }
  }

  Text cardText(String text, double size) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size, color: ConstantsColors.bottomSheetBackground),
    );
  }
}
