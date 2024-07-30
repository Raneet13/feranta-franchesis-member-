import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../static/flutter_toast_message/toast_messge.dart';

class backTocloseApp {
  DateTime? _lastBackPressed;
  BuildContext context;
  backTocloseApp(this.context);
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    DateTime now = DateTime.now();
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > Duration(seconds: 2)) {
      _lastBackPressed = now;
      // var currentRoute =
      //     BackButtonInterceptor.getCurrentNavigatorRouteName(context);
      // if (currentRoute == "Home" ||
      //     currentRoute == "pastRecord" ||
      //     currentRoute == "attendance" ||
      //     currentRoute == "profie") {
      ShowToast(msg: "Press back again to exit");
      // }
      // else {
      //   context.pop();
      // }
      return true; // Do not exit the app
    }
    SystemNavigator.pop();
    return false; // Exit the app
  }
}
