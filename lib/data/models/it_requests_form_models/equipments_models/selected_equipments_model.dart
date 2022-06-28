import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../../../data/models/contacts_related_models/contacts_data_from_api.dart';
import '../../../../data/models/it_requests_form_models/equipments_models/equipments_items_model.dart';

class SelectedEquipmentsModel extends Equatable {
  final ContactsDataFromApi? selectedContact;
  final EquipmentsItemModel? selectedItem;
  final int? quantity;
  final String? requestFor;
  final Widget? icon;
  // final String? id;
  // final String? equipmentsName;

  const SelectedEquipmentsModel({
    this.selectedContact,
    this.selectedItem,
    this.quantity,
    this.requestFor,
    this.icon,
    // this.id,
    // this.equipmentsName
  });

  @override
  List<Object?> get props => [
        selectedContact,
        selectedItem,
        quantity,
        requestFor,
        icon,
        // id,
        // equipmentsName,
      ];
}
