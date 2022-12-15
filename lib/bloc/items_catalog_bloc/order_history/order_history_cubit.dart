import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../constants/url_links.dart';
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

  static OrderHistoryCubit get(context) => BlocProvider.of(context);

  final Connectivity connectivity = Connectivity();
  final GeneralDio _generalDio;

  void getOrderHistoryList(String hrCode) async {
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
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
    else {
      emit(state.copyWith(
        orderHistoryEnumStates: OrderHistoryEnumStates.initial,
      ));
    }
  }

  Future<void> getOrderData(String hrCode, orderId) async {
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {

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
    else {
      emit(state.copyWith(
        orderHistoryEnumStates: OrderHistoryEnumStates.initial,
      ));
    }
  }

  Future<void> showItemsDialog(BuildContext context, String hrCode) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: state.orderDataList.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.network(getCatalogPhotos(
                            state.orderDataList[index].itemPhoto ?? ""))),
                    Text(state.orderDataList[index].itemName ?? "Not Defined"),
                    state.orderDataList[index].itemQty!=null?Text('${state.orderDataList[index].itemQty}'):const Text(""),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  //
  // reAddToCart() {
  //   //TODO: call API
  // }

  Future<void> reAddToCart({required String hrCode, required int itemCode}) async{

    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      EasyLoading.show(status: 'Loading...');
    emit(state.copyWith(
      orderHistoryEnumStates: OrderHistoryEnumStates.initial,
    ));
    Map<String, dynamic> cartDataPost =
    {
      "id": 0,
      "orderID": 0,
      "hrCode": hrCode,
      "item_Code": itemCode,
      // "itmCat_Items": {
      //   "item_ID": 0,
      //   "requestNo": 0,
      //   "systemItemCode": "",
      //   "itemCode": "",
      //   "item_Name": "",
      //   "item_Desc": "",
      //   "item_Qty": 0,
      //   "item_Price": 0,
      //   "item_AppearPrice": true,
      //   "in_User": "",
      //   "in_Date": DateTime.now().toString(),
      //   "up_User": "",
      //   "up_Date":  DateTime.now().toString(),
      //   // "items_Attaches": [
      //   //   {
      //   //     "id": 0,
      //   //     "item_ID": 0,
      //   //     "attach_File": "string",
      //   //     "in_User": "string",
      //   //     "in_Date":  DateTime.now().toString(),
      //   //     "up_User": "string",
      //   //     "up_Date":  DateTime.now().toString()
      //   //   }
      //   // ],
      //   "cat_ID": 0,
      //   // "category": {
      //   //   "cat_id": 0,
      //   //   "parent_ID": 0,
      //   //   "cat_Name": "string",
      //   //   "cat_Code": "string",
      //   //   "cat_Desc": "string",
      //   //   "cat_Photo": "string",
      //   //   "cat_StartDate":  DateTime.now().toString(),
      //   //   "cat_EndDate":  DateTime.now().toString(),
      //   //   "tags": "string",
      //   //   "isActive": true,
      //   //   "allow_Items": true,
      //   //   "in_User": "string",
      //   //   "in_Date":  DateTime.now().toString(),
      //   //   "up_User": "string",
      //   //   "up_Date":  DateTime.now().toString(),
      //   //   "category_Attach": [
      //   //     {
      //   //       "id": 0,
      //   //       "cat_id": 0,
      //   //       "attach_file": "string",
      //   //       "in_User": "string",
      //   //       "in_Date":  DateTime.now().toString(),
      //   //       "up_User": "string",
      //   //       "up_Date":  DateTime.now().toString()
      //   //     }
      //   //   ]
      //   // },
      //   "item_UOM": 0,
      //   // "itmCat_UOM": {
      //   //   "id": 0,
      //   //   "unit_Name": "string",
      //   //   "in_User": "string",
      //   //   "in_Date":  DateTime.now().toString(),
      //   //   "up_User": "string",
      //   //   "up_Date":  DateTime.now().toString()
      //   // },
      //   "item_MatGroup": 0,
      //   // "matrialGroup": {
      //   //   "id": 0,
      //   //   "material_Name": "string",
      //   //   "group_Desc": "string",
      //   //   "in_User": "string",
      //   //   "in_Date":  DateTime.now().toString(),
      //   //   "up_User": "string",
      //   //   "up_Date":  DateTime.now().toString()
      //   // },
      //   "item_MatType": 0,
      //   // "materialType": {
      //   //   "id": 0,
      //   //   "materialTyp_Name": "string",
      //   //   "type_Desc": "string",
      //   //   "in_User": "string",
      //   //   "in_Date":  DateTime.now().toString(),
      //   //   "up_User": "string",
      //   //   "up_Date":  DateTime.now().toString()
      //   // },
      //   "item_Photo": "",
      //   "tags": "",
      //   "enableBrand": true,
      //   "enableColor": true,
      //   "expirationDateFlag": true,
      //   "arabicDesc": ""
      // },
      "item_Qty": 1,
      "isClosed": true,
      "in_User": hrCode,
      "in_Date":  DateTime.now().toString(),
      "up_User": "",
      "up_Date":  DateTime.now().toString()
    };
    await _generalDio.postItemCatalogCart(cartDataPost).
    then((value) {
      // TODO: add to cart respnse here {value}
      // getCartItems(userHrCode: hrCode);
      emit(state.copyWith(
        orderHistoryEnumStates: OrderHistoryEnumStates.success,
      ));
      EasyLoading.showSuccess('order added');
    })
        .catchError((e) {
      EasyLoading.showError('Something went wrong');
      throw e;
    });

  }
  else {
  emit(state.copyWith(
  orderHistoryEnumStates: OrderHistoryEnumStates.initial,
  ));
  }
  }

}
