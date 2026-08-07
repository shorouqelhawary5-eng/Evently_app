import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  TextButtonWidget({super.key, required this.buttonText, this.onPressed});
  String buttonText;
  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed?.call();
      },
      child: Text(buttonText),
    );
  }
}
