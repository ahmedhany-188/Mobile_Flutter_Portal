import 'package:equatable/equatable.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_request_work_flow.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_respond_requests_model.dart';

enum CatalogRespondRequestsHistoryEnumStates {loading, success, failed,noConnection,initial,valid}

abstract class CatalogRespondRequestsHistoryState  extends Equatable {

  const CatalogRespondRequestsHistoryState();

  const CatalogRespondRequestsHistoryState.copyWith({
    required getCatalogRespondRequestsHistoryList,required getCatalogWorkFlowList,});
}

class CatalogRespondRequestsHistoryInitial extends CatalogRespondRequestsHistoryState{


  final CatalogRespondRequestsHistoryEnumStates catalogRespondRequestsHistoryEnumStates;
  final  List<ItemCatalogRespondRequests> getCatalogRespondRequestsHistoryList;
  final List<CatalogRequestWorkFlow> getCatalogWorkFlowList;
  final String message;

  const CatalogRespondRequestsHistoryInitial({
    this.catalogRespondRequestsHistoryEnumStates = CatalogRespondRequestsHistoryEnumStates.loading,
    this.getCatalogRespondRequestsHistoryList = const[],
    this.getCatalogWorkFlowList = const[],
    this.message="",
  });

  @override
  List<Object> get props => [
    catalogRespondRequestsHistoryEnumStates,getCatalogRespondRequestsHistoryList,getCatalogWorkFlowList,message
  ];

  CatalogRespondRequestsHistoryInitial copyWith({
    CatalogRespondRequestsHistoryEnumStates? catalogRespondRequestsHistoryEnumStates,
    List<ItemCatalogRespondRequests>? getCatalogRespondRequestsHistoryList,
    List<CatalogRequestWorkFlow>? getCatalogWorkFlowList,
    String? message,
  }) {
    return CatalogRespondRequestsHistoryInitial(
      catalogRespondRequestsHistoryEnumStates: catalogRespondRequestsHistoryEnumStates ?? this.catalogRespondRequestsHistoryEnumStates,
      getCatalogRespondRequestsHistoryList: getCatalogRespondRequestsHistoryList ?? this.getCatalogRespondRequestsHistoryList,
      getCatalogWorkFlowList: getCatalogWorkFlowList ?? this.getCatalogWorkFlowList,
      message:message??this.message,
    );
  }



  static CatalogRespondRequestsHistoryInitial? fromMap(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return const CatalogRespondRequestsHistoryInitial(
        catalogRespondRequestsHistoryEnumStates: CatalogRespondRequestsHistoryEnumStates.loading,
        getCatalogRespondRequestsHistoryList: [],
        getCatalogWorkFlowList: [],
        message:"",
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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'catalogRespondRequestsHistoryEnumStates':catalogRespondRequestsHistoryEnumStates.index,
      'getCatalogRespondRequestsHistoryList': getCatalogRespondRequestsHistoryList,
      'getCatalogWorkFlowList' : getCatalogWorkFlowList,
      'message' : message
    };
  }

}

