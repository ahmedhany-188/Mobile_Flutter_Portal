import 'package:formz/formz.dart';

enum RequestDateError { empty }

class RequestDate extends FormzInput<String, RequestDateError> {
  const RequestDate.pure([String value = '']) : super.pure(value);
  const RequestDate.dirty([String value = '']) : super.dirty(value);

  @override
  RequestDateError? validator(String? value) {
    return value?.isNotEmpty == true ? null : RequestDateError.empty;
  }

}