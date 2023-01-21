import 'package:flutter/material.dart';
import 'package:test_1/models/form_validator.dart';

class InputTextForm extends StatelessWidget {
  final FormValidator formValidator;
  final IconData? suffixIcon;
  final IconData prefixIcon;
  final bool showText;
  final VoidCallback? suffixPressed;

  const InputTextForm(
      {Key? key,
      required this.formValidator,
      this.suffixIcon,
      required this.prefixIcon,
      this.suffixPressed,
      this.showText = true})
      : super(key: key);

  Widget? _getSuffixIcon() {
    if (suffixIcon == null) return null;
    return IconButton(
      onPressed: suffixPressed,
      icon: Icon(suffixIcon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.red,
      ),
      validator: formValidator.validator,
      controller: formValidator.controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: formValidator.hint,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: _getSuffixIcon(),
      ),
      obscureText: !showText,
    );
  }
}
