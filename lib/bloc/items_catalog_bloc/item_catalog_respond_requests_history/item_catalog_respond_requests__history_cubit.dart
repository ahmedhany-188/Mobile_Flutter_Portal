
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_respond_requests_history/item_catalog_respond_requests__history_state.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_get_data_byhrcode.dart';
import 'package:hassanallamportalflutter/data/repositories/items_catalog_repositories/items_catalog_getall_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CatalogRespondRequestsHistoryCubit extends Cubit<CatalogRespondRequestsHistoryInitial> with HydratedMixin {
  CatalogRespondRequestsHistoryCubit(this.requestRepository) : super(const CatalogRespondRequestsHistoryInitial()){
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.catalogRespondRequestsHistoryEnumStates == CatalogRespondRequestsHistoryEnumStates.failed ||
          state.catalogRespondRequestsHistoryEnumStates ==
              CatalogRespondRequestsHistoryEnumStates.noConnection) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            getAllRequestList(requestRepository.userData?.employeeData?.userHrCode??"");
          } catch (e) {
            emit(state.copyWith(
              catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates.failed,
            ));
          }
        }
        else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates.noConnection,
          ));
        }
      }
    });
  }
  final ItemsCatalogGetAllRepository requestRepository;

  static CatalogRespondRequestsHistoryCubit get(context) => BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();

  Future<void> getAllRequestList(hrCode) async {
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      try {
        emit(state.copyWith(
          catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates.loading,
        ));

        await requestRepository.getCatalogGetDataHr(hrCode).then((groupNoValue) async{
          List<ItemCatalogUserInfo> inFoList=groupNoValue;
          await requestRepository.getCatalogRespondRequestsItems(inFoList[0].data![0].groupID)
              .then((respondListValue) async {
            emit(state.copyWith(
              catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates.success,
              getCatalogRespondRequestsHistoryList: respondListValue,
            ));
          }).catchError((error) {
            emit(state.copyWith(
              catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates.failed,
            ));
          });
        });

      } catch (e) {
        emit(state.copyWith(
          catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates.failed,
        ));
      }
    } else {
      emit(state.copyWith(
        catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates.noConnection,
      ));
    }

  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }

  @override
  CatalogRespondRequestsHistoryInitial? fromJson(Map<String, dynamic> json) {
    return CatalogRespondRequestsHistoryInitial.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(CatalogRespondRequestsHistoryInitial state) {
    if (state.catalogRespondRequestsHistoryEnumStates == CatalogRespondRequestsHistoryEnumStates.success &&
        state.getCatalogRespondRequestsHistoryList.isNotEmpty) {
      return state.toMap();
    } else {
      return null;
    }
  }

}