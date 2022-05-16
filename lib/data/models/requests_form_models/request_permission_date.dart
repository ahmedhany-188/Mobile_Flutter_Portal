import 'package:formz/formz.dart';

enum RequestDateError { empty }

class PermissionDate extends FormzInput<String, RequestDateError> {
  const PermissionDate.pure([String value = '']) : super.pure(value);
  const PermissionDate.dirty([String value = '']) : super.dirty(value);

  @override
  RequestDateError? validator(String? value) {
    return value?.isNotEmpty == true ? null : RequestDateError.empty;
  }
}