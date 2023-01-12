import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_respond_requests_history/item_catalog_respond_requests__history_state.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_get_data_byhrcode.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_respond_requests_model.dart';
import 'package:hassanallamportalflutter/data/repositories/items_catalog_repositories/items_catalog_getall_repository.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/export_excel.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CatalogRespondRequestsHistoryCubit extends Cubit<CatalogRespondRequestsHistoryInitial> with HydratedMixin {
  CatalogRespondRequestsHistoryCubit(this.requestRepository)
      : super(const CatalogRespondRequestsHistoryInitial()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.catalogRespondRequestsHistoryEnumStates ==
          CatalogRespondRequestsHistoryEnumStates.failed ||
          state.catalogRespondRequestsHistoryEnumStates ==
              CatalogRespondRequestsHistoryEnumStates.noConnection) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            getAllRequestList(
                requestRepository.userData?.employeeData?.userHrCode ?? "");
          } catch (e) {
            emit(state.copyWith(
              catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates
                  .failed,
            ));
          }
        }
        else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates
                .noConnection,
          ));
        }
      }
    });
  }

  final ItemsCatalogGetAllRepository requestRepository;

  static CatalogRespondRequestsHistoryCubit get(context) =>
      BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();

  void clearData() {
    emit(state.copyWith(searchCatalogWorkFlow: '', getCatalogWorkFlowSearchList: [],filter: false));
  }

  void setSearchString(String searchString) {
    emit(state.copyWith(searchCatalogWorkFlow: searchString));
    getSearchList();
  }

  void getSearchList(){
    List<DataRR> catalogRequestWorkFlowData=[];
    if (state.getCatalogRespondRequestsHistoryList.isNotEmpty) {
      if (state.getCatalogRespondRequestsHistoryList[0].data != null) {
        for(int i=0;i<state.getCatalogRespondRequestsHistoryList[0].data!.length;i++){
          if(state.getCatalogRespondRequestsHistoryList[0].data![i].requestNo.toString().contains(state.searchCatalogWorkFlow)){
            catalogRequestWorkFlowData.add(state.getCatalogRespondRequestsHistoryList[0].data![i]);
          }
        }
        if(catalogRequestWorkFlowData.isEmpty){
          ItemCatalogRespondRequests getCatalogWorkFlowSearchList=ItemCatalogRespondRequests(data: catalogRequestWorkFlowData);
          emit(state.copyWith(getCatalogWorkFlowSearchList: [getCatalogWorkFlowSearchList],filter: true,
    catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates.failed,message: "Req ID Not Found"));
        }else{
          ItemCatalogRespondRequests getCatalogWorkFlowSearchList=ItemCatalogRespondRequests(data: catalogRequestWorkFlowData);
          emit(state.copyWith(getCatalogWorkFlowSearchList: [getCatalogWorkFlowSearchList],filter: true
          ,catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates.success,message: ""));
        }
      }
    }
  }

  Future<void> getAllWorkFlowRequestList(String requestID) async {
    emit(state.copyWith(
      getCatalogWorkFlowList: [],
    ));
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      try {
        emit(state.copyWith(
          catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates
              .loading,
        ));
        await requestRepository.getCatalogWorkFlow(requestID).then((
            workFlowData) async {
          if(workFlowData.isNotEmpty){
            emit(state.copyWith(
              catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates
                  .success,
              getCatalogWorkFlowList: workFlowData,
            ));
          }else{
            emit(state.copyWith(
              catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates.noDataFound,
            ));
          }

        }).catchError((error) {
          emit(state.copyWith(
            catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates
                .failed,
            message: error,
          ));
        });
      } catch (e) {
        if (isClosed) {} else {
          emit(state.copyWith(
            catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates
                .failed,
            message: e.toString(),
          ));
        }
      }
    } else {
      emit(state.copyWith(
        catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates
            .noConnection,
      ));
    }
  }

  Future<void> exportWorkFlowData() async {
    if (state.getCatalogWorkFlowList.isNotEmpty) {
      if (state.getCatalogWorkFlowList[0].data != null) {
        await importDataWorkFlowCatalog(state.getCatalogWorkFlowList,
            "Request ID- ${state.getCatalogWorkFlowList[0]
                .data?[0].requestID
                .toString()}");
      }
    }
  }

  Future<void> getAllRequestList(hrCode) async {
    emit(state.copyWith(
      getCatalogRespondRequestsHistoryList: [],
    ));
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      try {
        emit(state.copyWith(
          catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates.loading,
        ));
        await requestRepository.getCatalogGetDataHr(hrCode).then((groupNoValue) async{
          List<ItemCatalogUserInfo> inFoList=groupNoValue;
          await requestRepository.getCatalogRespondRequestsItems(inFoList[0].data?[0].groupID)
              .then((respondListValue) async {
                if(respondListValue.isNotEmpty){
                  emit(state.copyWith(
                    catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates.success,
                    getCatalogRespondRequestsHistoryList: respondListValue,
                  ));
                }else{
                  emit(state.copyWith(
                    catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates.noDataFound,
                    getCatalogRespondRequestsHistoryList: respondListValue,
                  ));
                }

          }).catchError((error) {
            emit(state.copyWith(
              catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates.failed,
              message: error
            ));
          });
        });

      } catch (e) {

        if(isClosed){
           // print("emits closed and failed to emit faild");
        }else{
          emit(state.copyWith(
            catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates.failed,
              message: e.toString(),
          ));
        }

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