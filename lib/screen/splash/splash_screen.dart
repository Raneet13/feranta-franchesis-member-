import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(Duration(seconds: 3), () async {
//       await Provider.of<MapLoadViewmodel>(context, listen: false)
//           .locationEnabledndPermission()
//           .catchError((_) {
//         ShowToast(msg: "Something WEnt Wrong");
//       }).then((_) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String? userId = await prefs.getString("userId");
//         bool? onScreen = await prefs.getBool('onScreen');
        if (userId != null) {
          context.pushReplacement('/home', extra: {'id': "0"});
        } else {
//           // context.go('/login');
//           if (onScreen == true) {
          context.pushReplacement('/login');
//           } else
//             context.go('/on');
//         }
//       });

//       // context.go('/home', extra: {'id': "0"});

//       // Navigator.of(context).pushNamedAndRemoveUntil(
//       //     AppRoute.onboardScreen, (Route<dynamic> route) => false);\
//       // Navigator.pushReplacement(
//       //     context, MaterialPageRoute(builder: (context) => Onboarding()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
            height: 200,
            width: 200,
            child: Image.asset("assets/logo/feranta_new_logo_.png")),
      ),
    );
  }
}
