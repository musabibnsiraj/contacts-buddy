import 'package:contacts_buddy/constant.dart';
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
}
