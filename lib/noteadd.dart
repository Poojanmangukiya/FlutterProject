import 'package:flutter/material.dart';

class CustomDilog extends StatefulWidget {
  final String title;
  final IconData button;
  const CustomDilog({Key? key, required this.title, required this.button})
      : super(key: key);

  @override
  State<CustomDilog> createState() => _CustomDilogState();
}

class _CustomDilogState extends State<CustomDilog> {
  @override
  Widget build(BuildContext context) {
    return Text('data');
  }
}
