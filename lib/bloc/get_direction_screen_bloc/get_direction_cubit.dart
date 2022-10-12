import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/models/get_location_model/location_data.dart';
import '../../data/data_providers/general_dio/general_dio.dart';
import '../../data/data_providers/requests_data_providers/request_data_providers.dart';

part 'get_direction_state.dart';

class GetDirectionCubit extends Cubit<GetDirectionInitial> {
  GetDirectionCubit(this._generalDio)
      : super(const GetDirectionInitial.loading()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        try {
          getDirection();
        } catch (e) {
          emit(GetDirectionInitial.failure(e.toString()));
        }
      } else if (connectivityResult == ConnectivityResult.none) {
        emit(const GetDirectionInitial.failure("No internet Connection"));
      }
    });
  }
  // ignore: constant_identifier_names
  static const GOOGLE_API_KEY = 'AIzaSyAbkday4kMNt8-gG5Y-j2CDRKmpZXzkqeA';

  static GetDirectionCubit get(context) => BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();
  final GeneralDio _generalDio;

  late List<LocationData> getDirectionList;
  void getSelectedDirections() {}
  void getDirection() {
    emit(const GetDirectionInitial.loading());

    _generalDio.getGetDirectionData().then((value) {
      if (value.data != null && value.statusCode == 200) {
        getDirectionList = List<LocationData>.from(value.data
            .where((element) =>
                element['latitude'].toString().contains('.') &&
                element['longitude'].toString().contains('.'))
            .map((model) => LocationData.fromJson(model)));
        var valueData = List<LocationData>.from(
            value.data.map((model) => LocationData.fromJson(model)));
        emit(GetDirectionInitial.success(valueData, getDirectionList));
      } else {
        throw RequestFailureApi.fromCode(value.statusCode!);
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      emit(GetDirectionInitial.failure(error.toString()));
    });
  }

  LocationData getLocationByID(String id) {
    // if(state.status == GetDirectionStatus.success){

    var location =
        state.items.where((element) => element.projectId.toString() == id);
    if (location.isNotEmpty) {
      return location.first;
    } else {
      var emptyLocation = LocationData(projectId: -1, projectName: id);
      return emptyLocation;
    }
    // return
    // }else{
    //   return LocationData.empty;
    // }
  }
  // void getAllDirections() {
  //   emit(const GetDirectionInitial.loading());
  //
  //   GeneralDio.getGetDirectionData().then((value) {
  //
  //     // var values = value.data.where((element) =>
  //     // element['latitude'].toString().contains('.') &&
  //     //     element['longitude'].toString().contains('.')).toList();
  //     getDirectionList = List<LocationData>.from(value.data.map((model) =>LocationData.fromJson(model)
  //     ));
  //
  //     emit(GetDirectionInitial.success(getDirectionList));
  //   }).catchError((error) {
  //     if (kDebugMode) {
  //       print(error);
  //     }
  //     emit(GetDirectionInitial.failure(error.toString()));
  //   });
  // }

  Future<void> clearAll() async {
    emit(GetDirectionInitial.success(state.items, state.mappedItems));
  }

  Future<void> searchForLocations(String value) async {
    try {
      List<LocationData> searchList = [];
      List<LocationData> contacts = state.items;
      for (int i = 0; i < contacts.length; i++) {
        LocationData locationData = contacts[i];
        if (locationData.projectName != null) {
          if (locationData.projectName!
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              locationData.departmentName!
                  .toLowerCase()
                  .contains(value.toLowerCase())) {
            // print(locationData.name );
            searchList.add(locationData);
          }
        }
      }
      emit(GetDirectionInitial.successSearching(searchList, state.items));
    } catch (e) {
      emit(GetDirectionInitial.failure(e.toString()));
    }
  }
}
