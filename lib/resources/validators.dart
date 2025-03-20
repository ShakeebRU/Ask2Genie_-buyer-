import 'package:get/get.dart';

class Validators {
  static String? password(dynamic password) {
    if (password is String) {
      // bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
      // bool hasDigits = password.contains(new RegExp(r'[0-9]'));
      // // bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
      // bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      // bool hasMinLength = password.length >= 8;

      // bool allChecked = hasDigits && hasUppercase && hasSpecialCharacters && hasMinLength;
      if (password.length < 8) {
        return "Password's length must than 8 or more characters";
      }
    }
    return null;
  }

  static String? requiredValidator(dynamic value) {
    if (value is String) {
      if (value.isEmpty) {
        return 'This field is required';
      }
    }
    return null;
  }

  static String? phoneValidator(dynamic value) {
    RegExp regexp = RegExp(r"03\d{2}(-|\s)?\d{7}$", caseSensitive: false);
    if (value is String) {
      if (!regexp.hasMatch(value)) {
        return "Invalid Phone Provided";
      }
    }
    return null;
  }

  static String? emailValidator(dynamic value) {
    if (value is String && !value.isEmail) {
      return 'Enter a valid email';
    }
    return null;
  }
}
