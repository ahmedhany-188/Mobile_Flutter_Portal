import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../../data/data_providers/general_dio/general_dio.dart';
import '../../../../data/models/it_requests_form_models/equipments_models/equipments_items_model.dart';

part 'equipments_items_state.dart';

class EquipmentsItemsCubit extends Cubit<EquipmentsItemsInitial> {
  EquipmentsItemsCubit() : super(const EquipmentsItemsInitial()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.equipmentsItemsEnumState == EquipmentsItemsEnumState.failed) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            getEquipmentsItems();
          } catch (e) {
            emit(state.copyWith(
              equipmentsItemsEnumState: EquipmentsItemsEnumState.failed,
            ));
          }
        } else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            equipmentsItemsEnumState: EquipmentsItemsEnumState.failed,
          ));
        }
      }
    });
  }
  final Connectivity connectivity = Connectivity();

  static EquipmentsItemsCubit get(context) => BlocProvider.of(context);

  getEquipmentsItems({String id = '0'}) {
    emit(state.copyWith(
      equipmentsItemsEnumState: EquipmentsItemsEnumState.initial,
    ));
    GeneralDio.getEquipmentsItems(id).then((value) {
      List<EquipmentsItemModel> equipmentsItemsList;
      equipmentsItemsList = List<EquipmentsItemModel>.from(
          value.data.map((model) => EquipmentsItemModel.fromJson(model)));
      emit(state.copyWith(
          equipmentsItemsEnumState: EquipmentsItemsEnumState.success,
          listEquipmentsItem: equipmentsItemsList));
    }).catchError((err) {
      emit(state.copyWith(
          equipmentsItemsEnumState: EquipmentsItemsEnumState.failed));
    });
  }
}
