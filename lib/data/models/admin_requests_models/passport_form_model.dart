import 'package:formz/formz.dart';

enum PassportError { empty }

class PassportNumber extends FormzInput<String, PassportError> {
  const PassportNumber.pure([String value = '']) : super.pure(value);
  const PassportNumber.dirty([String value = '']) : super.dirty(value);

  @override
  PassportError? validator(String? value) {

    if(value?.isNotEmpty == true){
      RegExp regex =
      RegExp(r'^(?!^0+$)[a-zA-Z0-9]{3,20}$');
      return regex.hasMatch(value!) == true ? null : PassportError.empty;
    }else{
      return PassportError.empty;
    }

  }

}