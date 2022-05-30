import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_permission_date.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date_from.dart';

enum DateToError { empty,isBefore}

class DateTo extends FormzInput<String, DateToError> {
  const DateTo.pure({this.dateFrom = '' }) : super.pure('');
  const DateTo.dirty({required this.dateFrom, String value = ''}) : super.dirty(value);
  final String dateFrom;
  @override
  DateToError? validator(String? value) {

    if (value?.isNotEmpty == true && dateFrom.isNotEmpty == true){
      try{
        final toDate = DateFormat("EEEE dd-MM-yyyy").parse(value ?? "");
        final fromDate = DateFormat("EEEE dd-MM-yyyy").parse(dateFrom);

        if (toDate.isBefore(fromDate)) {
          return DateToError.isBefore;
        }


      }catch(_){
        return DateToError.empty;
      }
      return null;
    }else{
      return DateToError.empty;
    }
  }
}