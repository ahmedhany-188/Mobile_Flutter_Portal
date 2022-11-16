import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_new_request_model.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date.dart';

abstract class NewRequestCatalogState extends Equatable{
  const NewRequestCatalogState();

  const NewRequestCatalogState.copyWith({
  required FormzStatus status, });
}

enum NewRequestCatalogEnumState { initial, success, failed, loading }

class NewRequestCatalogInitial extends NewRequestCatalogState {
  const NewRequestCatalogInitial({
    this.newRequestCatalogEnumState = NewRequestCatalogEnumState.initial,
    this.listCatalogRequests = const<NewRequestCatalogModel>[],
    this.catalogNewRequests,
    this.newRequestDate = const RequestDate.pure(),
    this.status = FormzStatus.pure,
  });

  final NewRequestCatalogEnumState newRequestCatalogEnumState;
  final List<NewRequestCatalogModel> listCatalogRequests;
  final NewRequestCatalogModel? catalogNewRequests;
  final RequestDate newRequestDate;
  final FormzStatus status;



  NewRequestCatalogInitial copyWith({
    NewRequestCatalogEnumState? newRequestCatalogEnumState,
    List<NewRequestCatalogModel>? listCatalogRequests,
    NewRequestCatalogModel? newCatalogRequests,
    FormzStatus ?status,
    RequestDate? newRequestDate,
  }) {
    return NewRequestCatalogInitial(
      newRequestCatalogEnumState: newRequestCatalogEnumState ?? this.newRequestCatalogEnumState,
      listCatalogRequests: listCatalogRequests ?? this.listCatalogRequests,
        catalogNewRequests:catalogNewRequests??this.catalogNewRequests,
        newRequestDate:newRequestDate??this.newRequestDate,
        status:status??this.status,
    );
  }

  @override
  List<Object> get props => [newRequestCatalogEnumState,listCatalogRequests,newRequestDate,status];
}
