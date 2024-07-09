import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/services.dart';

import '../../static/flutter_toast_message/toast_messge.dart';

class backTocloseApp {
  DateTime? _lastBackPressed;
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    DateTime now = DateTime.now();
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > Duration(seconds: 2)) {
      _lastBackPressed = now;
      //ScaffoldMessenger.of(context).showSnackBar(
      ShowToast(msg: "Press back again to exit");
      // SnackBar(
      //   content: Text("Press back again to exit"),
      //   duration: Duration(seconds: 2),
      // ),
      // );
      return true; // Do not exit the app
    }
    SystemNavigator.pop();
    return false; // Exit the app
  }
}
