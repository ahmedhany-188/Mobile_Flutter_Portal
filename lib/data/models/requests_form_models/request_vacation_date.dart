import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_permission_date.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_vacation_date_to.dart';

enum VacationDateError { empty }

class VacationDate extends FormzInput<String, VacationDateError> {
  const VacationDate.pure() : super.pure('');
  const VacationDate.dirty([String value = '']) : super.dirty(value);

  @override
  VacationDateError? validator(String? value) {
    // return password == value ? null : ConfirmedPasswordValidationError.invalid;
    if (value?.isNotEmpty == true){
      try{
        DateFormat("EEEE dd-MM-yyyy").parse(value!);
      }catch(_){
        return VacationDateError.empty;
      }
      return null;
    }else{
      return VacationDateError.empty;
    }
    // return value?.isNotEmpty == true ? null : PermissionDateError.empty;
  }
}