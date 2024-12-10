import 'package:chatme/services/database_service.dart';
import 'package:chatme/services/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// Models
import 'package:chatme/models/chat_user.dart';

class AuthenticationProvider extends ChangeNotifier {
  FirebaseAuth? _auth;
  NavigationService? _navigationService;
  DatabaseService? _databaseService;

  late ChatUser user;

  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();
    _auth!.authStateChanges().listen((_user) {
      if (_user != null) {
        print("hi");
        _databaseService!.printHello();
        try {
          _databaseService!.updateUserLastSeen(_user.uid);
          _databaseService!.getUser(_user.uid).then(
            (_snapshot) {
              Map<String, dynamic> _userData =
                  _snapshot.data()! as Map<String, dynamic>;
              user = ChatUser.fromJSON({
                "uid": _user.uid,
                "name": _userData['name'],
                "email": _userData['email'],
                "image": _userData['image'],
                "last_active": _userData['last_active'],
              });
              _navigationService!.removeAndNavigateToRoute('/home');
              print("object1");
            },
          );
        } catch (e) {
          print("error is ${e}");
        }
      } else {
        print("Not Authenticated");
      }
    });
  }

  Future<void> loginUsingEmailAndPassword(
      String _email, String _password) async {
    try {
      await _auth!
          .signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException {
      print("Error using login firebase");
    } catch (e) {
      print(e);
    }
  }
}
