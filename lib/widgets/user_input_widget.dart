import 'package:flutter/material.dart';
import '../widgets/constant.dart';

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
