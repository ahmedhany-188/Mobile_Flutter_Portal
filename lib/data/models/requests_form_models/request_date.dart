import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/models/get_location_model/location_data.dart';


enum RequestDateError { empty }

class RequestDate extends FormzInput<String, RequestDateError> {
  const RequestDate.pure([String value = '']) : super.pure(value);
  const RequestDate.dirty([String value = '']) : super.dirty(value);

  @override
  RequestDateError? validator(String? value) {
    return value?.isNotEmpty == true ? null : RequestDateError.empty;
  }
}

class LocationDataCheck extends FormzInput<LocationData, RequestDateError> {
  const LocationDataCheck.pure({LocationData value = LocationData.empty,this.type = 0}) : super.pure(value);
  const LocationDataCheck.dirty({required this.type, required LocationData value}) : super.dirty(value);
  final int type;
  @override
  RequestDateError? validator(LocationData? value) {
    // print(type);
    if(type != 4){
      return value?.projectId != 0 ? null : RequestDateError.empty;
    }else{
      return null;
    }

  }
}

class CommentCharacterCheck extends FormzInput<String, RequestDateError> {
  const CommentCharacterCheck.pure([String value = '']) : super.pure(value);
  const CommentCharacterCheck.dirty([String value = '']) : super.dirty(value);

  @override
  RequestDateError? validator(String? value) {

    var length = value?.length;

    return length! > 20 ? null : RequestDateError.empty;
  }
}