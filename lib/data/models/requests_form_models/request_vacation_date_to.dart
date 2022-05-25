import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_permission_date.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_vacation_date.dart';

enum VacationDateToError { empty }

class VacationDateTo extends FormzInput<String, VacationDateToError> {
  const VacationDateTo.pure({this.vacationDateFrom = '' }) : super.pure('');
  const VacationDateTo.dirty({required this.vacationDateFrom, String value = ''}) : super.dirty(value);
  final String vacationDateFrom;
  @override
  VacationDateToError? validator(String? value) {

    if (value?.isNotEmpty == true && vacationDateFrom.isNotEmpty == true){
      try{
        final toDate = DateFormat("EEEE dd-MM-yyyy").parse(value ?? "");
        final fromDate = DateFormat("EEEE dd-MM-yyyy").parse(vacationDateFrom);

        if (toDate.isBefore(fromDate)) {
          return VacationDateToError.empty;
        }

      }catch(_){
        return VacationDateToError.empty;
      }
      return null;
    }else{
      return VacationDateToError.empty;
    }
  }
}