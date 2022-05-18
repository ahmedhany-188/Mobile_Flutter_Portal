import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:formz/formz.dart';

enum PermissionDateError { empty }

class PermissionDate extends FormzInput<String, PermissionDateError> {
  const PermissionDate.pure([String value = '']) : super.pure(value);
  const PermissionDate.dirty([String value = '']) : super.dirty(value);

  @override
  PermissionDateError? validator(String? value) {

    if (value?.isNotEmpty == true){
      try{
        DateFormat("EEEE dd-MM-yyyy").parse(value!);
      }catch(_){
        return PermissionDateError.empty;
      }
      return null;
    }else{
      return PermissionDateError.empty;
    }
    // return value?.isNotEmpty == true ? null : PermissionDateError.empty;
  }
}