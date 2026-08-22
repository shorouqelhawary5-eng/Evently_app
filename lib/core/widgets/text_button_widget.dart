import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({super.key, required this.buttonText, this.onPressed});
  final String buttonText;
  final VoidCallback? onPressed;
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
