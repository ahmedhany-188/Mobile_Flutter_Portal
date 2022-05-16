import 'package:formz/formz.dart';

enum RequestDateError { empty }

class PermissionTime extends FormzInput<String, RequestDateError> {
  const PermissionTime.pure([String value = '']) : super.pure(value);
  const PermissionTime.dirty([String value = '']) : super.dirty(value);

  @override
  RequestDateError? validator(String? value) {
    return value?.isNotEmpty == true ? null : RequestDateError.empty;
  }
}