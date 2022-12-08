import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../data/data_providers/general_dio/general_dio.dart';
import '../../../data/data_providers/requests_data_providers/request_data_providers.dart';
import '../../../data/models/items_catalog_models/item_catalog_all_data.dart';
import '../../../data/models/items_catalog_models/order_history_model.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit(this._generalDio) : super(const OrderHistoryState()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.orderHistoryEnumStates == OrderHistoryEnumStates.failed) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            // getOrderHistoryList();
          } catch (e) {
            emit(state.copyWith(
              orderHistoryEnumStates: OrderHistoryEnumStates.failed,
            ));
          }
        } else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            orderHistoryEnumStates: OrderHistoryEnumStates.failed,
          ));
        }
      }
    });
  }

  final Connectivity connectivity = Connectivity();
  final GeneralDio _generalDio;

  void getOrderHistoryList(String hrCode) async {
    emit(state.copyWith(
      orderHistoryEnumStates: OrderHistoryEnumStates.initial,
    ));
    EasyLoading.show(status: 'Loading...');
    await _generalDio.getOrderHistory(hrCode).then((value) {
      if (value.data['data'] != null && value.statusCode == 200) {
        List<OrderHistoryData> result = List<OrderHistoryData>.from(value
            .data['data']
            .map((model) => OrderHistoryData.fromJson(model)));
        emit(state.copyWith(
          orderHistoryEnumStates: OrderHistoryEnumStates.success,
          orderHistoryList: result,
        ));
        EasyLoading.dismiss();
      } else if (value.data['data'] == null) {
        EasyLoading.dismiss();
        emit(state.copyWith(
          orderHistoryList: [],
          orderHistoryEnumStates: OrderHistoryEnumStates.failed,
        ));
      } else {
        throw RequestFailureApi.fromCode(value.statusCode!);
      }
    });
  }

  void getOrderData(String hrCode, orderId) async {
    emit(state.copyWith(
      orderHistoryEnumStates: OrderHistoryEnumStates.initial,
    ));
    await _generalDio.getOrderData(hrCode, orderId).then((value) {
      if (value.data['data'] != null && value.statusCode == 200) {
        List<ItemCategorygetAllData> result = List<ItemCategorygetAllData>.from(
            value.data['data']
                .map((model) => ItemCategorygetAllData.fromJson(model)));
        emit(state.copyWith(
          orderHistoryEnumStates: OrderHistoryEnumStates.success,
          orderDataList: result,
        ));
      } else if (value.data['data'] == null) {
        EasyLoading.dismiss();
        emit(state.copyWith(
          orderHistoryList: [],
          orderHistoryEnumStates: OrderHistoryEnumStates.failed,
        ));
      } else {
        throw RequestFailureApi.fromCode(value.statusCode!);
      }
    });
  }
}
