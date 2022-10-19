import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../data/data_providers/general_dio/general_dio.dart';
import '../../../data/data_providers/requests_data_providers/request_data_providers.dart';
import '../../../data/models/items_catalog_models/item_catalog_all_data.dart';
import '../../../data/models/items_catalog_models/item_catalog_search_model.dart';

part 'item_catalog_search_state.dart';

class ItemCatalogSearchCubit extends Cubit<ItemCatalogSearchInitial> {
  ItemCatalogSearchCubit(this._generalDio) : super(const ItemCatalogSearchInitial()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.itemCatalogSearchEnumStates ==
          ItemCatalogSearchEnumStates.failed) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            // getContacts();
          } catch (e) {
            emit(state.copyWith(
              itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed,
            ));
          }
        } else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed,
          ));
        }
      }
    });
  }

  final Connectivity connectivity = Connectivity();
  final GeneralDio _generalDio;

  static ItemCatalogSearchCubit get(context) => BlocProvider.of(context);

  void getSearchList({int? catalogId}) async {
    emit(state.copyWith(
      itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.initial,
    ));
    EasyLoading.show();
    await _generalDio
        .getItemCatalogSearch(state.searchString, categoryId: catalogId)
        .then((value) {
      print("==${value.data['data'] != null}");
      if (value.data['data'] != null && value.statusCode == 200) {
        List<ItemCatalogSearchData> searchResult =
            List<ItemCatalogSearchData>.from(value.data['data']
                .map((model) => ItemCatalogSearchData.fromJson(model)));
        emit(state.copyWith(
          itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.success,
          searchResult: searchResult,
        ));
        EasyLoading.dismiss();
      } else if (value.data['data'] == null) {
        EasyLoading.dismiss();
        emit(state.copyWith(
          searchResult: [],
          itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed,
        ));
      } else {
        throw RequestFailureApi.fromCode(value.statusCode!);
      }
    }).catchError((error) {
      emit(state.copyWith(
          itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed));
    });
    EasyLoading.dismiss();
  }

  void setSearchString(String searchString) {
    emit(state.copyWith(searchString: searchString));
    getSearchList();
  }

  void clearData() {
    emit(state.copyWith(searchString: '', searchResult: []));
  }

  void getAllCatalogList({required String itemCode}) async {
    emit(state.copyWith(
      itemCatalogAllDataEnumStates: ItemCatalogSearchEnumStates.initial,
    ));
    await _generalDio
        .getItemCatalogAllData(itemCode)
        .then((value) {
      if (value.data['data'] != null && value.statusCode == 200) {
        List<ItemCategorygetAllData> itemAllDatalist =
        List<ItemCategorygetAllData>.from(value.data['data']
            .map((model) => ItemCategorygetAllData.fromJson(model)));
        emit(state.copyWith(
          itemCatalogAllDataEnumStates: ItemCatalogSearchEnumStates.success,
          itemAllDatalist: itemAllDatalist,
        ));
      } else if (value.data['data'] == null) {
        emit(state.copyWith(
          itemAllDatalist: [],
          itemCatalogAllDataEnumStates: ItemCatalogSearchEnumStates.failed,
        ));
      } else {
        throw RequestFailureApi.fromCode(value.statusCode!);
      }
    }).catchError((error) {
      emit(state.copyWith(
          itemCatalogAllDataEnumStates: ItemCatalogSearchEnumStates.failed));
    });
  }

}
