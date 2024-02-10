import 'package:flutter/material.dart';

class TextFieldStyling extends StatelessWidget {
  final String labelText;
  final bool? isObscureText;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const TextFieldStyling({
    super.key,
    required this.labelText,
    this.isObscureText,
    this.textInputType,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: textInputType,
      obscureText: isObscureText ?? false,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.grey[200],
        ),
        focusColor: Colors.white,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: .5,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
        ),
        errorStyle: const TextStyle(
          color: Color(0xFFa8dadc),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFa8dadc),
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFa8dadc),
          ),
        ),
      ),
    );
  }
}
