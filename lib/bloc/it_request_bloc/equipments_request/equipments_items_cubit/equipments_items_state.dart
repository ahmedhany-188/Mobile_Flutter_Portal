part of 'equipments_items_cubit.dart';

abstract class EquipmentsItemsState extends Equatable {
  const EquipmentsItemsState();
}

enum EquipmentsItemsEnumState { initial, success, failed }

class EquipmentsItemsInitial extends EquipmentsItemsState {
  final EquipmentsItemsEnumState equipmentsItemsEnumState;
  final List<EquipmentsItemModel> listEquipmentsItem;
  final String elementPrice;
  final String count;

  const EquipmentsItemsInitial({
    this.equipmentsItemsEnumState = EquipmentsItemsEnumState.initial,
    this.listEquipmentsItem = const<EquipmentsItemModel>[],
    this.elementPrice = '0',
    this.count = '1'
  });


  EquipmentsItemsInitial copyWith({
    EquipmentsItemsEnumState? equipmentsItemsEnumState,
    List<EquipmentsItemModel>? listEquipmentsItem,
    String? elementPrice,
    String? count
  }) {
    return EquipmentsItemsInitial(
      equipmentsItemsEnumState: equipmentsItemsEnumState ?? this.equipmentsItemsEnumState,
      listEquipmentsItem: listEquipmentsItem ?? this.listEquipmentsItem,
      elementPrice: elementPrice ?? this.elementPrice,
      count: count ?? this.count,
    );
  }

  @override
  List<Object> get props => [equipmentsItemsEnumState,listEquipmentsItem,elementPrice,count];
}
