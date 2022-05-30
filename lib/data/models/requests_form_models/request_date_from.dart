import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:formz/formz.dart';
enum DateFromError { empty }

class DateFrom extends FormzInput<String, DateFromError> {
  const DateFrom.pure() : super.pure('');
  const DateFrom.dirty([String value = '']) : super.dirty(value);

  @override
  DateFromError? validator(String? value) {
    if (value?.isNotEmpty == true){
      try{
        DateFormat("EEEE dd-MM-yyyy").parse(value!);
      }catch(_){
        return DateFromError.empty;
      }
      return null;
    }else{
      return DateFromError.empty;
    }
    // return value?.isNotEmpty == true ? null : PermissionDateError.empty;
  }
}