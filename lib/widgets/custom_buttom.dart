import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  CustomButtom({super.key, required this.text, this.onTap});
  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        height: 40,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Color.fromARGB(255, 38, 67, 95),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
