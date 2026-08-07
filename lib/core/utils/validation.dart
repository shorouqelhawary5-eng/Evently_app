import 'package:flutter/material.dart';

class Validator {
  // String input;

  // Validator({required this.input});
  static String? nameValidation(String input) {
    if (input == null || input.trim().isEmpty) {
      return 'Enter your name';
    }
    return null;
  }

  static String? emailValidation(String input) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (input == null || input.trim().isEmpty) {
      return 'Please, enter your email';
    }

    if (!emailRegex.hasMatch(input.trim())) {
      return 'Please, enter a valid email';
    }

    return null;
  }

  static String? passwordValidation(String input) {
    final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$');
    if (input == null || input.isEmpty) {
      return 'Please, enter your password';
    }

    if (!passwordRegex.hasMatch(input)) {
      return 'Password not valid';
    }

    return null;
  }

  static String? confirmPasswordValidation(
    String input,
    TextEditingController password,
  ) {
    if (input.isEmpty) {
      return 'Please, confirm your password';
    }

    if (input != password.text) {
      return 'Passwords do not match';
    }

    return null;
  }
}
