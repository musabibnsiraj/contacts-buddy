import '../constant.dart';
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

class UserInput extends StatelessWidget {
  final TextEditingController textEditingControllerl;
  final bool isPass;
  final TextInputType textInputType;
  final String hintText;
  final dynamic endicon;
  final dynamic enabled;
  const UserInput({
    Key? key,
    required this.textEditingControllerl,
    required this.textInputType,
    required this.hintText,
    this.isPass = false,
    this.endicon,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: inputTextColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      controller: textEditingControllerl,
      decoration: InputDecoration(
        suffixIcon: endicon,
        labelStyle: const TextStyle(),
        prefixIconColor: inputTextColor,
        fillColor: primaryTextFillColor,
        hintText: hintText,
        suffixIconColor: inputTextColor,
        hintStyle: TextStyle(
          color: hintTextColor,
          fontStyle: FontStyle.italic,
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
        border: OutlineInputBorder(
          borderSide: Divider.createBorderSide(context),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: Divider.createBorderSide(context),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: Divider.createBorderSide(context),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        contentPadding:
            const EdgeInsets.only(left: 15, right: 8, top: 8, bottom: 8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
      enabled: enabled,
    );
  }
}

class UserFormInput extends StatelessWidget {
  final TextEditingController textEditingControllerl;
  final bool isPass;
  final TextInputType textInputType;
  final String hintText;
  final dynamic inputIcon;
  final Icon? endIcon;
  final dynamic maxCharacter;
  final bool showPrefixIcon;

  const UserFormInput(
      {Key? key,
      required this.textEditingControllerl,
      required this.textInputType,
      required this.hintText,
      this.isPass = false,
      this.inputIcon,
      this.endIcon,
      this.maxCharacter = 0,
      this.showPrefixIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value != null &&
            maxCharacter != 0 &&
            value.trim().length <= maxCharacter) {
          return 'This field is required! Please type at least $maxCharacter character(s).';
        }

        return null;
      },
      style: TextStyle(color: inputTextColor, fontSize: 16),
      controller: textEditingControllerl,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: inputTextColor),
        prefixIcon: showPrefixIcon
            ? Icon(
                inputIcon,
                color: inputTextColor,
              )
            : null,
        prefixIconColor: inputTextColor,
        fillColor: primaryTextFillColor,
        hintText: hintText,
        suffixIcon: endIcon,
        suffixIconColor: statsUnselectedcolor,
        hintStyle: TextStyle(
          color: hintTextColor,
          fontStyle: FontStyle.italic,
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
        border: OutlineInputBorder(
          borderSide: Divider.createBorderSide(context),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: Divider.createBorderSide(context),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: Divider.createBorderSide(context),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
