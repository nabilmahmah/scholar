import 'package:flutter/material.dart';
import 'package:scholar/constans.dart';
import 'package:scholar/models/message.dart';

class buble extends StatelessWidget {
  const buble({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(left: 20, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(message.message, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

class bublefriend extends StatelessWidget {
  const bublefriend({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(left: 20, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(message.message, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
