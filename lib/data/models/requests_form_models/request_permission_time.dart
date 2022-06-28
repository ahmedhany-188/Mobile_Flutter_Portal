import 'package:formz/formz.dart';

enum PermissionTimeError { empty }

class PermissionTime extends FormzInput<String, PermissionTimeError> {
  const PermissionTime.pure([String value = '']) : super.pure(value);
  const PermissionTime.dirty([String value = '']) : super.dirty(value);

  @override
  PermissionTimeError? validator(String? value) {
    return value?.isNotEmpty == true ? null : PermissionTimeError.empty;
  }
}