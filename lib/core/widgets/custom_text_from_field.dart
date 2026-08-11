import 'package:flutter/material.dart';

class CustomTextFromField extends StatelessWidget {
  CustomTextFromField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this._controller,
  });
  String hintText;
  Widget? prefixIcon;
  Function(String?)? validator;
  TextEditingController? _controller;
  Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      validator: validator != null ? (value) => validator!(value) : null,
      controller: _controller,
    );
  }
}
