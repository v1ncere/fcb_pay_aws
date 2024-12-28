import 'package:formz/formz.dart';

enum UsernameValidationError { required, invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([super.value = '']) : super.dirty();
  
  @override
  UsernameValidationError? validator(String? value) {
    return value?.isEmpty == true
      ? UsernameValidationError.required
      : null;
  }
}

extension UsernameValidationErrorX on UsernameValidationError {
  String text() {
    switch (this) {
      case UsernameValidationError.required:
        return 'Username is required';
      case UsernameValidationError.invalid:
        return 'Username is invalid. Please try again.';
    }
  }
}