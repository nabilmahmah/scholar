import 'package:flutter/material.dart';

class customTextFormField extends StatelessWidget {
  customTextFormField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.obscureText = false,
  });
  final String hintText;
  final Function(String)? onChanged;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'this field is required';
        } else if (value.contains(
          r'[a-zA-Z0-9._%]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}',
        )) {
          return 'this field is email';
        } else if (value.length < 8) {
          return 'password must be at least 8 characters';
        }
        return null;
      },
      // {

      //   return null;
      // },
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.5),
        ),
      ),
    );
  }
}
