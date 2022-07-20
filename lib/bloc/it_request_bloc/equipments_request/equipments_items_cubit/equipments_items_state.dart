part of 'equipments_items_cubit.dart';

abstract class EquipmentsItemsState extends Equatable {
  const EquipmentsItemsState();
}

enum EquipmentsItemsEnumState { initial, success, failed }

class EquipmentsItemsInitial extends EquipmentsItemsState {
  final EquipmentsItemsEnumState equipmentsItemsEnumState;
  final List<EquipmentsItemModel> listEquipmentsItem;

  const EquipmentsItemsInitial({
    this.equipmentsItemsEnumState = EquipmentsItemsEnumState.initial,
    this.listEquipmentsItem = const<EquipmentsItemModel>[],
  });


  EquipmentsItemsInitial copyWith({
    EquipmentsItemsEnumState? equipmentsItemsEnumState,
    List<EquipmentsItemModel>? listEquipmentsItem,
  }) {
    return EquipmentsItemsInitial(
      equipmentsItemsEnumState: equipmentsItemsEnumState ?? this.equipmentsItemsEnumState,
      listEquipmentsItem: listEquipmentsItem ?? this.listEquipmentsItem,
    );
  }

  @override
  List<Object> get props => [equipmentsItemsEnumState,listEquipmentsItem];
}
