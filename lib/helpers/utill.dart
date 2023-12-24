import 'package:contacts_buddy/widgets/constant.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utill {
  static void showError(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: appRemoveColor,
        textColor: appWhite,
        fontSize: 16.0);
  }

  static void showInfo(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        // timeInSecForIosWeb: 1,
        backgroundColor: infoColor,
        textColor: appWhite,
        fontSize: 16.0);
  }

  static void showSuccess(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        // timeInSecForIosWeb: 1,
        backgroundColor: primaryColor,
        textColor: appWhite,
        fontSize: 16.0);
  }
}