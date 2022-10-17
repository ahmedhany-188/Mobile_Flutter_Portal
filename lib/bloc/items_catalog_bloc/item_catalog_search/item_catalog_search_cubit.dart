import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_providers/general_dio/general_dio.dart';
import '../../../data/data_providers/requests_data_providers/request_data_providers.dart';
import '../../../data/models/items_catalog_models/item_catalog_search_model.dart';

part 'item_catalog_search_state.dart';

class ItemCatalogSearchCubit extends Cubit<ItemCatalogSearchInitial> {
  ItemCatalogSearchCubit(this._generalDio) : super(ItemCatalogSearchInitial()){
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.itemCatalogSearchEnumStates == ItemCatalogSearchEnumStates.failed) {
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

  void getSearchList({int? catalogId}) async{
    await _generalDio.getItemCatalogSearch(state.searchString,categoryId: catalogId).then((value) {
      if (value.data != null && value.statusCode == 200){
        List<ItemCatalogSearchData> searchResult = List<ItemCatalogSearchData>.from(
            value.data['data'].map((model) => ItemCatalogSearchData.fromJson(model)));
        emit(state.copyWith(
            itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.success,
            searchResult: searchResult,
            ));
      }else{
        throw RequestFailureApi.fromCode(value.statusCode!);
      }
    }).catchError((error) {
      emit(state.copyWith(itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed));
    });
  }

  void setSearchString(String searchString){
    emit(state.copyWith(searchString: searchString));
    getSearchList();
  }

}
