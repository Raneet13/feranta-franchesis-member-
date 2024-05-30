import 'package:feranta_franchise/static/color.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  ThemeData themedata = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade200,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.amber, //Color(0xfffac50e),
        // onPrimary: Colors.green,
        // primaryContainer: Colors.yellow.shade100,
        // onPrimaryContainer: Colors.green,
        // onSecondaryContainer: Colors.red,
        // secondary: Colors.green,
        // onSecondary: Colors.green,
        // tertiary: Colors.amber,
        // onTertiary: Colors.green,
        // brightness: Brightness.light,
        // primary: Colors.white,
        // error: Colors.red,
        // onError: Colors.white,
        background: Colors.white70,
        onBackground: Colors.white,
        // surface: Colors.white,
        // onSurface: Colors.black54),
      ),
      useMaterial3: true,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(
            color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(),
        headlineMedium: TextStyle(),
        headlineSmall: TextStyle(),
        titleLarge: TextStyle(
            color: Colors.black, fontSize: 21, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(),
        titleSmall: TextStyle(),
        bodyLarge: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
        labelLarge: TextStyle(
            color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
        labelMedium: TextStyle(
            color: Colors.black38,
            fontSize: 14,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.3),
        labelSmall:
            TextStyle(color: Colors.black26, fontSize: 12, letterSpacing: 0.3),
      ),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white70),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide.none)),
              foregroundColor: MaterialStatePropertyAll(Colo.white),
              backgroundColor: MaterialStatePropertyAll(Colo.yellowshade300))),
      textButtonTheme: const TextButtonThemeData(style: ButtonStyle()));
}
