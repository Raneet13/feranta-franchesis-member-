import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isTapped = false;
  bool textShow = false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
          Duration(seconds: 1),
          () => setState(() {
                isTapped = !isTapped;
                Future.delayed(
                    Duration(milliseconds: 1500),
                    () => setState(() {
                          textShow = !textShow;
                        }));
                Future.delayed(Duration(seconds: 5), () async {
//       await Provider.of<MapLoadViewmodel>(context, listen: false)
//           .locationEnabledndPermission()
//           .catchError((_) {
//         ShowToast(msg: "Something WEnt Wrong");
//       }).then((_) async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
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
              }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AnimatedContainer(
              height: isTapped ? 220.0 : 50.0,
              width: isTapped ? 220 : 50.0,
              duration: Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/logo/feranta_new_logo_.png"),
                  opacity: isTapped ? 1.0 : 0.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Animated Text
          Visibility(
            visible: textShow,
            child: AnimatedTextKit(isRepeatingAnimation: false, animatedTexts: [
              TyperAnimatedText('Feranta Team'.toUpperCase(),
                  textStyle: GoogleFonts.anta(
                    textStyle: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        // textCapitalization: TextCapitalization.characters,
                        fontSize: 24),
                  ),
                  speed: Duration(milliseconds: 200)),
              // TyperAnimatedText('something you know.But if you listen,',
              //     speed: Duration(milliseconds: 100)),
            ]),
          ),
        ],
      )
          //  SizedBox(
          //     height: 200,
          //     width: 200,
          //     child: Image.asset("assets/logo/feranta_new_logo_.png")),
          ),
    );
  }
}
