import 'package:chatme/services/database_service.dart';
import 'package:chatme/services/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class AuthenticationProvider extends ChangeNotifier {
  FirebaseAuth? _auth;
  NavigationService? _navigationService;
  DatabaseService? _databaseService;

  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();
  }

  
}
