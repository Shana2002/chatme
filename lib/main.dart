import 'package:flutter/material.dart';

// Service
import 'package:chatme/services/navigation_service.dart';

// Pages
import 'package:chatme/pages/splash_page.dart';

void main() {
  runApp(SplashPage(
      key: UniqueKey(),
      onInitializationComplete: () {
        runApp(const MyApp());
      }));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ChatMe",
      theme:
          ThemeData(scaffoldBackgroundColor: Color.fromRGBO(36, 35, 49, 1.0)),
      home: Scaffold(body: Container()),
      // navigatorKey: NavigationService().navigator,
    );
  }
}
