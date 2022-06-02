import 'package:formz/formz.dart';

enum TimeToError { empty }

class TimeTo extends FormzInput<String, TimeToError> {
  const TimeTo.pure([String value = '']) : super.pure(value);
  const TimeTo.dirty([String value = '']) : super.dirty(value);

  @override
  TimeToError? validator(String? value) {
    return value?.isNotEmpty == true ? null : TimeToError.empty;
  }
}