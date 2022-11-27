import 'package:equatable/equatable.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_requestCatalog_reponse.dart';

enum CatalogRequestsHistoryEnumStates {loading, success, failed,noConnection,initial,valid}

abstract class CatalogRequestsHistoryState  extends Equatable {

  const CatalogRequestsHistoryState();

  const CatalogRequestsHistoryState.copyWith({
    required getCatalogRequestsHistoryList,});
}

class CatalogRequestsHistoryInitial extends CatalogRequestsHistoryState{


  final CatalogRequestsHistoryEnumStates catalogRequestsHistoryEnumStates;
  final  List<NewRequestCatalogModelResponse> getCatalogRequestsHistoryList;
  final String message;

  const CatalogRequestsHistoryInitial({
    this.catalogRequestsHistoryEnumStates = CatalogRequestsHistoryEnumStates.loading,
    this.getCatalogRequestsHistoryList = const[],
    this.message="",
  });

  @override
  List<Object> get props => [
    catalogRequestsHistoryEnumStates,getCatalogRequestsHistoryList,message
  ];

  CatalogRequestsHistoryInitial copyWith({
    CatalogRequestsHistoryEnumStates? catalogRequestsHistoryEnumStates,
    List<NewRequestCatalogModelResponse>? getCatalogRequestsHistoryList,
    String? message,
  }) {
    return CatalogRequestsHistoryInitial(
      catalogRequestsHistoryEnumStates: catalogRequestsHistoryEnumStates ?? this.catalogRequestsHistoryEnumStates,
      getCatalogRequestsHistoryList: getCatalogRequestsHistoryList ?? this.getCatalogRequestsHistoryList,
        message:message??this.message,
    );
  }



  static CatalogRequestsHistoryInitial? fromMap(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return const CatalogRequestsHistoryInitial(
        catalogRequestsHistoryEnumStates: CatalogRequestsHistoryEnumStates.loading,
        getCatalogRequestsHistoryList: [],
          message:"",
      );
    }
    int val = json['catalogRequestsHistoryEnumStates'];
    return CatalogRequestsHistoryInitial(
        catalogRequestsHistoryEnumStates: CatalogRequestsHistoryEnumStates.values[val],
      getCatalogRequestsHistoryList: List<NewRequestCatalogModelResponse>.from(
            json['getCatalogRequestsHistoryList']?.map((p) =>
                NewRequestCatalogModelResponse.fromJson(p))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'catalogRequestsHistoryEnumStates':catalogRequestsHistoryEnumStates.index,
      'getCatalogRequestsHistoryList': getCatalogRequestsHistoryList,
      'message' : message
    };
  }

}

