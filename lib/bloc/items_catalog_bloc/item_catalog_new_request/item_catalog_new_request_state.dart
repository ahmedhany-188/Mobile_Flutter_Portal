
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_image_model.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_new_request_model.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date.dart';

abstract class NewRequestCatalogState extends Equatable{
  const NewRequestCatalogState();

  const NewRequestCatalogState.copyWith({
    required itemName,required itemDescription, required itemAttach,required selectedCategory,
  required FormzStatus status,});
}

enum NewRequestCatalogEnumState { initial, success, failed, loading,noConnection,valid,noDataFound }

class NewRequestCatalogInitial extends NewRequestCatalogState {
  const NewRequestCatalogInitial({

    this.newRequestCatalogEnumState = NewRequestCatalogEnumState.initial,
    this.status = FormzStatus.pure,

    this.listCatalogRequests = const<NewRequestCatalogModel>[],
    this.catalogNewRequests,

    this.newRequestDate = const RequestDate.pure(),
    this.itemName = const RequestDate.pure(),
    this.itemDescription = const RequestDate.pure(),
    this.itemAttach = const [],
    this.selectedCategory = const RequestDate.pure(),
    this.errorMessage = "",

    this.newRequestEntity=false,
    this.newRequestQuality=false,

  });

  final NewRequestCatalogEnumState newRequestCatalogEnumState;
  final FormzStatus status;

  final List<NewRequestCatalogModel> listCatalogRequests;
  final NewRequestCatalogModel ?catalogNewRequests;

  final RequestDate newRequestDate;
  final RequestDate itemName;
  final RequestDate itemDescription;
  final List<ItemImageCatalogModel> itemAttach;
  final RequestDate selectedCategory;
  final String errorMessage;
  final bool newRequestQuality,newRequestEntity;

  @override
  List<Object> get props => [newRequestCatalogEnumState,status,
    listCatalogRequests,newRequestDate,itemName,
    itemDescription,itemAttach,selectedCategory,errorMessage,newRequestQuality,newRequestEntity];


  NewRequestCatalogInitial copyWith({
    NewRequestCatalogEnumState? newRequestCatalogEnumState,
    FormzStatus ?status,

    List<NewRequestCatalogModel>? listCatalogRequests,
    NewRequestCatalogModel? newCatalogRequests,
    RequestDate? newRequestDate,
    RequestDate? itemName,
    RequestDate? itemDescription,
    bool? newRequestQuality,newRequestEntity,
    List<ItemImageCatalogModel>? itemAttach,
    RequestDate? selectedCategory,
    String? errorMessage,
  }) {
    return NewRequestCatalogInitial(
      newRequestCatalogEnumState: newRequestCatalogEnumState ?? this.newRequestCatalogEnumState,
      status:status??this.status,

      listCatalogRequests: listCatalogRequests ?? this.listCatalogRequests,
      catalogNewRequests:catalogNewRequests?? catalogNewRequests,

      newRequestDate:newRequestDate??this.newRequestDate,
      itemName:itemName??this.itemName,
      itemDescription:itemDescription??this.itemDescription,
      itemAttach:itemAttach??this.itemAttach,
      selectedCategory:selectedCategory??this.selectedCategory,
        errorMessage:errorMessage??this.errorMessage,
      newRequestQuality:newRequestQuality??this.newRequestQuality,
      newRequestEntity:newRequestEntity??this.newRequestEntity,
    );
  }


}
