import 'package:formz/formz.dart';

enum TimeFromError { empty }

class TimeFrom extends FormzInput<String, TimeFromError> {
  const TimeFrom.pure([String value = '']) : super.pure(value);
  const TimeFrom.dirty([String value = '']) : super.dirty(value);

  @override
  TimeFromError? validator(String? value) {
    return value?.isNotEmpty == true ? null : TimeFromError.empty;
  }
}