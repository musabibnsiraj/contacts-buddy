import 'constant.dart';
import 'package:flutter/material.dart';

class Showdialoguebox extends StatelessWidget {
  const Showdialoguebox(
      {Key? key,
      required this.title,
      required this.content,
      required this.actions1})
      : super(key: key);

  final String title;
  final String content;
  final List<Widget> actions1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: primaryAppColor,
          fontSize: 24,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      backgroundColor: alertBoxBgColor,
      actions: actions1,
    );
  }
}
