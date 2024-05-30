import 'package:feranta_franchise/approuter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'static/themedata_style.dart';
import 'view_model/allRecordViewmodel/all-record_viewmodel.dart';
import 'view_model/auth/login-viewmodel.dart';
import 'view_model/profile/profile_viewmodel.dart';
import 'view_model/resister/all_resister_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewmodel()),
        ChangeNotifierProvider(create: (_) => ResisterViewmodel()),
        ChangeNotifierProvider(create: (_) => RecordViewmodel()),
        // ChangeNotifierProvider(create: (_) => TabViewmodel()),
        // ChangeNotifierProvider(create: (_) => MytripViewwModel()),
        // ChangeNotifierProvider(create: (_) => BookingtaxiViewmodel()),
        // ChangeNotifierProvider(create: (_) => LoginViewmodel()), //
        ChangeNotifierProvider(create: (_) => ProfileViewmodel()), //
        // ChangeNotifierProvider(create: (_) => NotificationViewmodel()),
      ],
      child: MaterialApp.router(
        title: 'FERANTA FRANCHISE',
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoute.router,
        // onGenerateRoute: AppRoute.generateRoute,
        theme: CustomTheme().themedata, // home: SplashScreen(),
        // home: HomeScreen(),
        // home: SplashScreen(),
      ),
    );
  }
}
