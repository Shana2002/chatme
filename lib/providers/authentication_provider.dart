import 'package:chatme/services/cloud_storage_service.dart';
import 'package:chatme/services/database_service.dart';
import 'package:chatme/services/navigation_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// Models
import 'package:chatme/models/chat_user.dart';

class AuthenticationProvider extends ChangeNotifier {
  FirebaseAuth? _auth;
  NavigationService? _navigationService;
  DatabaseService? _databaseService;
  CloudStorageService? _cloudStorageService;

  late ChatUser user;

  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _cloudStorageService = GetIt.instance.get<CloudStorageService>();
    _databaseService = GetIt.instance.get<DatabaseService>();

    // _auth!.signOut(); // Optional: For testing purposes
    _auth!.authStateChanges().listen((_user) async {
      if (_user != null) {
        try {
          // Ensure user data exists before navigating
          final _snapshot = await _databaseService!.getUser(_user.uid);
          if (_snapshot.exists) {
            Map<String, dynamic> _userData =
                _snapshot.data()! as Map<String, dynamic>;
            print(_userData);
            user = ChatUser.fromJSON({
              "uid": _user.uid,
              "name": _userData['name'],
              "email": _userData['email'],
              "image": _userData['image'],
              "last_active": _userData['last_active'],
            });
            notifyListeners();
            _navigationService!.removeAndNavigateToRoute('/home');
          }
        } catch (e) {
          print("Error in authStateChanges: $e");
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
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException in login: $e");
    } catch (e) {
      print("Error in login: $e");
    }
  }

  Future<void> registerUserUsingEmailAndPAssword(String email, String password,
      String name, PlatformFile _profileImage) async {
    try {
      UserCredential _userCredential = await _auth!
          .createUserWithEmailAndPassword(email: email, password: password);

      // Upload profile image and create user document
      String? imageUrl = await _cloudStorageService!.saveUserImage(
        _userCredential.user!.uid,
        _profileImage,
      );

      await _databaseService!.createUser(
        _userCredential.user!.uid,
        email,
        name,
        imageUrl!,
      );

      print("User registered successfully!");
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException in register: $e");
    } catch (e) {
      print("Error in register: $e");
    }
  }

  Future<void> logOut() async {
    try {
      await _auth!.signOut();
      _navigationService!.removeAndNavigateToRoute('/login');
    } catch (e) {
      print("Error in logOut: $e");
    }
  }
}
