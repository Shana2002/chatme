import 'package:chatme/providers/authentication_provider.dart';
import 'package:flutter/material.dart';

// Service
import 'package:chatme/services/navigation_service.dart';

// Pages
import 'package:chatme/pages/login_page.dart';
import 'package:chatme/pages/splash_page.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
            create: (BuildContext _context) {
          return AuthenticationProvider();
        })
      ],
      child: MaterialApp(
        title: "ChatMe",
        theme:
            ThemeData(scaffoldBackgroundColor: Color.fromRGBO(36, 35, 49, 1.0)),
        home: Scaffold(body: Container()),
        navigatorKey: NavigationService().navigator,
        initialRoute: "/login",
        routes: {
          "/login": (BuildContext _context) => LoginPage(),
        },
      ),
    );
  }
}
