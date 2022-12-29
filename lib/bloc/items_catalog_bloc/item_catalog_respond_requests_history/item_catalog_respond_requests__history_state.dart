import 'package:equatable/equatable.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_request_work_flow.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_respond_requests_model.dart';

enum CatalogRespondRequestsHistoryEnumStates {loading, success, failed,noConnection,initial,valid,noDataFound}

abstract class CatalogRespondRequestsHistoryState  extends Equatable {

  const CatalogRespondRequestsHistoryState();

  const CatalogRespondRequestsHistoryState.copyWith({
    required getCatalogRespondRequestsHistoryList,required getCatalogWorkFlowList,});
}

class CatalogRespondRequestsHistoryInitial extends CatalogRespondRequestsHistoryState{


  final CatalogRespondRequestsHistoryEnumStates catalogRespondRequestsHistoryEnumStates;
  final  List<ItemCatalogRespondRequests> getCatalogRespondRequestsHistoryList;
  final List<CatalogRequestWorkFlow> getCatalogWorkFlowList;
  final List<ItemCatalogRespondRequests> getCatalogWorkFlowSearchList;
  final String message;
  final bool filter;
  final String searchCatalogWorkFlow;

  const CatalogRespondRequestsHistoryInitial({
    this.catalogRespondRequestsHistoryEnumStates = CatalogRespondRequestsHistoryEnumStates.loading,
    this.getCatalogRespondRequestsHistoryList = const[],
    this.getCatalogWorkFlowList = const[],
    this.getCatalogWorkFlowSearchList=const[],
    this.message="",
    this.searchCatalogWorkFlow="",
    this.filter=false,
  });

  @override
  List<Object> get props => [
    catalogRespondRequestsHistoryEnumStates,getCatalogRespondRequestsHistoryList,getCatalogWorkFlowList,getCatalogWorkFlowSearchList,searchCatalogWorkFlow,filter,message
  ];

  CatalogRespondRequestsHistoryInitial copyWith({
    CatalogRespondRequestsHistoryEnumStates? catalogRespondRequestsHistoryEnumStates,
    List<ItemCatalogRespondRequests>? getCatalogRespondRequestsHistoryList,
    List<CatalogRequestWorkFlow>? getCatalogWorkFlowList,
    List<ItemCatalogRespondRequests>? getCatalogWorkFlowSearchList,
    String? searchCatalogWorkFlow,
    bool? filter,
    String? message,
  }) {
    return CatalogRespondRequestsHistoryInitial(
      catalogRespondRequestsHistoryEnumStates: catalogRespondRequestsHistoryEnumStates ?? this.catalogRespondRequestsHistoryEnumStates,
      getCatalogRespondRequestsHistoryList: getCatalogRespondRequestsHistoryList ?? this.getCatalogRespondRequestsHistoryList,
      getCatalogWorkFlowList: getCatalogWorkFlowList ?? this.getCatalogWorkFlowList,
      getCatalogWorkFlowSearchList:getCatalogWorkFlowSearchList??this.getCatalogWorkFlowSearchList,
      message:message??this.message,
        searchCatalogWorkFlow:searchCatalogWorkFlow??this.searchCatalogWorkFlow,
      filter:filter??this.filter,
    );
  }



  static CatalogRespondRequestsHistoryInitial? fromMap(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return const CatalogRespondRequestsHistoryInitial(
        catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates.loading,
        getCatalogRespondRequestsHistoryList: [],
        getCatalogWorkFlowList: [],
        getCatalogWorkFlowSearchList:[],
        message:"",
          searchCatalogWorkFlow:"",
        filter:false,
      );
    }
    int val = json['catalogRespondRequestsHistoryEnumStates'];
    return CatalogRespondRequestsHistoryInitial(
      catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates.values[val],
      getCatalogRespondRequestsHistoryList: List<ItemCatalogRespondRequests>.from(
          json['getCatalogRespondRequestsHistoryList']?.map((p) =>
              ItemCatalogRespondRequests.fromJson(p))),
      getCatalogWorkFlowList: List<CatalogRequestWorkFlow>.from(
          json['getCatalogWorkFlowList']?.map((p) =>
              CatalogRequestWorkFlow.fromJson(p))),
      getCatalogWorkFlowSearchList: List<ItemCatalogRespondRequests>.from(
          json['getCatalogWorkFlowSearchList']?.map((p) =>
              ItemCatalogRespondRequests.fromJson(p))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'catalogRespondRequestsHistoryEnumStates':catalogRespondRequestsHistoryEnumStates.index,
      'getCatalogRespondRequestsHistoryList': getCatalogRespondRequestsHistoryList,
      'getCatalogWorkFlowList' : getCatalogWorkFlowList,
      'getCatalogWorkFlowSearchList' : getCatalogWorkFlowSearchList,
      'message' : message,
      'searchCatalogWorkFlow' : searchCatalogWorkFlow,
      'filter' : filter,
    };
  }

}

