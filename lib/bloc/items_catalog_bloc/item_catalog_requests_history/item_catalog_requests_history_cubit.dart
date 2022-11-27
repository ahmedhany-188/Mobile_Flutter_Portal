import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_requests_history/item_catalog_requests_history_state.dart';
import 'package:hassanallamportalflutter/data/repositories/items_catalog_repositories/items_catalog_getall_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';


class CatalogRequestsHistoryCubit extends Cubit<CatalogRequestsHistoryInitial> with HydratedMixin {
  CatalogRequestsHistoryCubit(this.requestRepository) : super(const CatalogRequestsHistoryInitial()){
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.catalogRequestsHistoryEnumStates == CatalogRequestsHistoryEnumStates.failed ||
          state.catalogRequestsHistoryEnumStates ==
              CatalogRequestsHistoryEnumStates.noConnection) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            getAllRequestList(requestRepository.userData?.employeeData?.userHrCode??"");
          } catch (e) {
            emit(state.copyWith(
              catalogRequestsHistoryEnumStates: CatalogRequestsHistoryEnumStates.failed,
            ));
          }
        }
        else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            catalogRequestsHistoryEnumStates: CatalogRequestsHistoryEnumStates.noConnection,
          ));
        }
      }
    });
  }
  final ItemsCatalogGetAllRepository requestRepository;

  static CatalogRequestsHistoryCubit get(context) => BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();

  Future<void> getAllRequestList(userHRCode) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        try {
          emit(state.copyWith(
            catalogRequestsHistoryEnumStates: CatalogRequestsHistoryEnumStates.loading,
          ));
          await requestRepository.getCatalogRequestsItems(
              userHRCode,)
              .then((value) async {
                emit(state.copyWith(
                  catalogRequestsHistoryEnumStates: CatalogRequestsHistoryEnumStates.success,
                  getCatalogRequestsHistoryList: value,
                ));

          }).catchError((error) {
            print("ohhh here");
            emit(state.copyWith(
              catalogRequestsHistoryEnumStates: CatalogRequestsHistoryEnumStates.failed,
            ));
          });
        } catch (e) {
          print("also here");
          emit(state.copyWith(
            catalogRequestsHistoryEnumStates: CatalogRequestsHistoryEnumStates.failed,
          ));
      }} else {
        emit(state.copyWith(
          catalogRequestsHistoryEnumStates: CatalogRequestsHistoryEnumStates.noConnection,
        ));
      }

  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }

  @override
  CatalogRequestsHistoryInitial? fromJson(Map<String, dynamic> json) {
    return CatalogRequestsHistoryInitial.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(CatalogRequestsHistoryInitial state) {
    if (state.catalogRequestsHistoryEnumStates == CatalogRequestsHistoryEnumStates.success &&
        state.getCatalogRequestsHistoryList.isNotEmpty) {
      return state.toMap();
    } else {
      return null;
    }
  }

}