import 'package:flutter/material.dart';

class CustomTextFromField extends StatelessWidget {
  const CustomTextFromField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this._controller,
    this.maxLines = 1,
  });
  final String hintText;
  final int maxLines;
  final Widget? prefixIcon;
  final Function(String?)? validator;
  final TextEditingController? _controller;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
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
