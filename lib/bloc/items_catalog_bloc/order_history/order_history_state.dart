part of 'order_history_cubit.dart';

enum OrderHistoryEnumStates {
  initial,
  success,
  filtered,
  failed,
  loadingTreeData,
  successTreeData,
  noConnection
}

class OrderHistoryState extends Equatable {
  final OrderHistoryEnumStates orderHistoryEnumStates;
  final List<OrderHistoryData> orderHistoryList;
  final List<ItemCategorygetAllData> orderDataList;

  const OrderHistoryState({
    this.orderHistoryEnumStates = OrderHistoryEnumStates.initial,
    this.orderHistoryList = const [],
    this.orderDataList = const [],
  });

  OrderHistoryState copyWith(
      {OrderHistoryEnumStates? orderHistoryEnumStates,
      List<OrderHistoryData>? orderHistoryList,
      List<ItemCategorygetAllData>? orderDataList}) {
    return OrderHistoryState(
      orderHistoryEnumStates:
          orderHistoryEnumStates ?? this.orderHistoryEnumStates,
      orderHistoryList: orderHistoryList ?? this.orderHistoryList,
      orderDataList: orderDataList ?? this.orderDataList,
    );
  }

  @override
  List<Object> get props => [
        orderHistoryEnumStates,
        orderHistoryList,
        orderDataList,
      ];
}
