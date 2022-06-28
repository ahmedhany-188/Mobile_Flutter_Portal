import 'package:formz/formz.dart';

enum RequestDateError { empty }

class PermissionType extends FormzInput<String, RequestDateError> {
  const PermissionType.pure([String value = '']) : super.pure(value);
  const PermissionType.dirty([String value = '']) : super.dirty(value);

  @override
  RequestDateError? validator(String? value) {
    return value?.isNotEmpty == true ? null : RequestDateError.empty;
  }
}