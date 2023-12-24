import 'constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'show_alert_screen.dart';

class Spinner extends StatelessWidget {
  const Spinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: SpinKitCircle(color: appSpinColor));
  }
}

class WSpinner extends StatelessWidget {
  const WSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: SpinKitCircle(color: appWhite));
  }
}

class SpinnerBG extends StatelessWidget {
  const SpinnerBG({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12.withOpacity(0.3),
      child: const Center(
        child: WSpinner(),
      ),
    );
  }
}

extension ColorExtension on String {
  toColor() {
    try {
      var hexString = this;
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return primaryAppColor;
    }
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

extension StringExtension on String {
  String capitalize() {
    return isEmpty ? this : this[0].toUpperCase() + substring(1);
  }
}

showMsgBox(BuildContext context, String content, String title,
    {String? btnName}) {
  showDialog(
      context: context,
      builder: (context) {
        return Showdialoguebox(
          content: content,
          title: title,
          actions1: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                  alignment: Alignment.center,
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: btnName != null
                          ? Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 60,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: ShapeDecoration(
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                color: primaryAppColor,
                              ),
                              child: Text(
                                btnName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                            ))),
            )
          ],
        );
      });
}

BoxDecoration backgroundDecoration() {
  return const BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/background.jpg'), fit: BoxFit.cover));
}
