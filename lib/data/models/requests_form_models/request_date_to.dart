import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

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