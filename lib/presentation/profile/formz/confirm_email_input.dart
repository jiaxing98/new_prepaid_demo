import 'package:formz/formz.dart';

enum ConfirmEmailValidationError { empty, notMatched }

class ConfirmEmailInput extends FormzInput<String, ConfirmEmailValidationError>
    with FormzInputErrorCacheMixin {
  final String toVerify;

  ConfirmEmailInput.pure({this.toVerify = ''}) : super.pure('');

  ConfirmEmailInput.dirty({required this.toVerify, String value = ''}) : super.dirty(value);

  @override
  ConfirmEmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return ConfirmEmailValidationError.empty;
    } else if (value != toVerify) {
      return ConfirmEmailValidationError.notMatched;
    }

    return null;
  }
}

extension ConfirmEmailValidationErrorExt on ConfirmEmailValidationError {
  String text() {
    switch (this) {
      case ConfirmEmailValidationError.empty:
        return 'This field cannot be empty';
      case ConfirmEmailValidationError.notMatched:
        return 'The value is not matched';
    }
  }
}
