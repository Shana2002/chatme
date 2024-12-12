import 'dart:async';
import 'package:chatme/models/chat_message.dart';
import 'package:chatme/providers/authentication_provider.dart';
import 'package:chatme/services/cloud_storage_service.dart';
import 'package:chatme/services/database_service.dart';
import 'package:chatme/services/media_service.dart';
import 'package:chatme/services/navigation_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ChatProvide extends ChangeNotifier {
  DatabaseService? _db;
  CloudStorageService? _storage;
  MediaService? _mediaService;
  NavigationService? _navigation;

  AuthenticationProvider _auth;
  ScrollController _messageListViewController;

  String _chatID;
  List<ChatMessage>? messages;

  String? _message;

  String get message {
    return message;
  }

  ChatProvide(this._chatID, this._auth, this._messageListViewController) {
    _db = GetIt.instance.get<DatabaseService>();
    _storage = GetIt.instance.get<CloudStorageService>();
    _mediaService = GetIt.instance.get<MediaService>();
    _navigation = GetIt.instance.get<NavigationService>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void goBack() {
    _navigation!.goBack();
  }
}
