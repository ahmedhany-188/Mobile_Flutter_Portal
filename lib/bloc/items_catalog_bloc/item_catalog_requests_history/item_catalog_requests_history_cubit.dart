import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_requests_history/item_catalog_requests_history_state.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_new_request_model.dart';
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
    emit(state.copyWith(
      getCatalogRequestsHistoryList: [],
    ));
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      try {
        emit(state.copyWith(
          catalogRequestsHistoryEnumStates: CatalogRequestsHistoryEnumStates
              .loading,
        ));
        await requestRepository.getCatalogRequestsItems(
          userHRCode,)
            .then((value) async {
          if (value.isNotEmpty) {
            emit(state.copyWith(
              catalogRequestsHistoryEnumStates: CatalogRequestsHistoryEnumStates
                  .success,
              getCatalogRequestsHistoryList: value,
            ));
          } else {
            emit(state.copyWith(
                getCatalogRequestsHistoryList: [],
                catalogRequestsHistoryEnumStates: CatalogRequestsHistoryEnumStates
                    .noDataFound));
          }
        }).catchError((error) {
          emit(state.copyWith(
            catalogRequestsHistoryEnumStates: CatalogRequestsHistoryEnumStates
                .failed,
          ));
        });
      } catch (e) {
        emit(state.copyWith(
          catalogRequestsHistoryEnumStates: CatalogRequestsHistoryEnumStates
              .failed,
        ));
      }
    } else {
      emit(state.copyWith(
        catalogRequestsHistoryEnumStates: CatalogRequestsHistoryEnumStates
            .noConnection,
      ));
    }
  }

  Future<void> cancelRequest(NewRequestCatalogModel  newRequestCatalogModelResponse,userHRCode) async {
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      await requestRepository.cancelRequestRepository(
          newRequestCatalogModelResponse).then((value) async {
        if (value == false) {
          print("here1");
          getAllRequestList(userHRCode);
          print("here2");
          // emit(state.copyWith(
          //   catalogRequestsHistoryEnumStates: CatalogRequestsHistoryEnumStates
          //       .success,
          //     message: "Request cancelled"
          //   // getCatalogRequestsHistoryList: value,
          // ));
        } else {
          emit(state.copyWith(
            catalogRequestsHistoryEnumStates: CatalogRequestsHistoryEnumStates
                .failed,
            message: "failed to delete request"
          ));
        }
      }).catchError((e) {
        print("error "+e.toString());
        emit(state.copyWith(
          catalogRequestsHistoryEnumStates: CatalogRequestsHistoryEnumStates
              .failed,));

        // throw RequestFailureApi.fromCode(value.statusCode??0);
      });
    } else {
      emit(state.copyWith(
        catalogRequestsHistoryEnumStates: CatalogRequestsHistoryEnumStates
            .noConnection,
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