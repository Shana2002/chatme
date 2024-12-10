import 'dart:io';

// Pacakges
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

const String USER_COLLECTION = "Users";

class CloudStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  CloudStorageService() {}

  Future<String?> saveUserImage(String uid, PlatformFile _file) async {
    try {
      Reference _ref = _firebaseStorage
          .ref()
          .child("images/Users/$uid/profile.${_file.extension}");
      UploadTask _task = _ref.putFile(File(_file.path!));
      return await _task.then((_result) => _result.ref.getDownloadURL());
    } catch (e) {
      print(e);
    }
  }

  Future<String?> saveChatImage(
      String chatID, String uid, PlatformFile _file) async {
    try {
      Reference _ref = _firebaseStorage.ref().child(
          "images/chats/$chatID/${uid}_${Timestamp.now().millisecondsSinceEpoch}.${_file.extension}");
      UploadTask _task = _ref.putFile(File(_file.path!));
      return await _task.then((_result) => _result.ref.getDownloadURL());
    } catch (e) {
      print(e);
    }
  }
}
