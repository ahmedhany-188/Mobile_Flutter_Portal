import '../../../../data/models/contacts_related_models/contacts_data_from_api.dart';
import '../../../../data/models/it_requests_form_models/equipments_models/equipments_items_model.dart';

class SelectedEquipmentsModel {
  ContactsDataFromApi? selectedContact;
  EquipmentsItemModel? selectedItem;
  int? quantity;
  String? requestFor;

  SelectedEquipmentsModel({
    this.selectedContact,
    this.selectedItem,
    this.quantity,
    this.requestFor,
  });
}
