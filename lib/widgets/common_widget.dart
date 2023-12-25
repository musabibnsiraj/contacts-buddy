import 'constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Spinner extends StatelessWidget {
  const Spinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: SpinKitCircle(color: appSpinColor));
  }
}

AppBar appBar(String title, {List<Widget>? actionsWidget, double? elevation}) {
  return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: appBarText,
          fontSize: 28,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: appBarBgColor,
      elevation: elevation ?? 0,
      actions: actionsWidget ?? []);
}

class PrimaryBtn extends StatelessWidget {
  final String data;
  final Color color;
  final Color textColor;

  const PrimaryBtn(
      {Key? key,
      required this.data,
      required this.color,
      this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 60,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: ShapeDecoration(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        color: color,
      ),
      child: Text(
        data,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

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
