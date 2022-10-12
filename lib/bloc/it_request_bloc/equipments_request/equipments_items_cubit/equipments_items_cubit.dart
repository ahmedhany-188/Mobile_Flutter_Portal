import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../../data/data_providers/general_dio/general_dio.dart';
import '../../../../data/data_providers/requests_data_providers/request_data_providers.dart';
import '../../../../data/models/it_requests_form_models/equipments_models/equipments_items_model.dart';

part 'equipments_items_state.dart';

class EquipmentsItemsCubit extends Cubit<EquipmentsItemsInitial> {
  EquipmentsItemsCubit(this._generalDio) : super(const EquipmentsItemsInitial()) {
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
  final GeneralDio _generalDio;

  static EquipmentsItemsCubit get(context) => BlocProvider.of(context);

  setElementPrice({String? elementPrice, String? count}){
    emit(state.copyWith(elementPrice: elementPrice,count: count));
  }

  getEquipmentsItems({String id = '0'}) {
    emit(state.copyWith(
      equipmentsItemsEnumState: EquipmentsItemsEnumState.initial,
    ));
    _generalDio.getEquipmentsItems(id).then((value) {
      if(value.data != null && value.statusCode == 200){
        List<EquipmentsItemModel> equipmentsItemsList;
        equipmentsItemsList = List<EquipmentsItemModel>.from(
            value.data.map((model) => EquipmentsItemModel.fromJson(model)));
        emit(state.copyWith(
            equipmentsItemsEnumState: EquipmentsItemsEnumState.success,
            listEquipmentsItem: equipmentsItemsList));
      }else{
        throw RequestFailureApi.fromCode(value.statusCode!);
      }
    }).catchError((err) {
      emit(state.copyWith(
          equipmentsItemsEnumState: EquipmentsItemsEnumState.failed));
    });
  }
}
