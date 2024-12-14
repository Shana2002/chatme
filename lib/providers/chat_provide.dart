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
  StreamSubscription? _messageStream;

  String get message {
    return message;
  }

  void set message(String _value) {
    _message = _value;
  }

  ChatProvide(this._chatID, this._auth, this._messageListViewController) {
    _db = GetIt.instance.get<DatabaseService>();
    _storage = GetIt.instance.get<CloudStorageService>();
    _mediaService = GetIt.instance.get<MediaService>();
    _navigation = GetIt.instance.get<NavigationService>();
    listenToMessages();
  }

  @override
  void dispose() {
    _messageStream!.cancel();
    super.dispose();
  }

  void goBack() {
    _navigation!.goBack();
  }

  void listenToMessages() {
    try {
      _messageStream = _db!.getChats(_chatID).listen(
        (_snapshot) {
          List<ChatMessage> _message = _snapshot.docs.map(
            (_m) {
              Map<String, dynamic> _messageData =
                  _m.data() as Map<String, dynamic>;
              return ChatMessage.fromJSON(_messageData);
            },
          ).toList();
          messages = _message;
          notifyListeners();
          // ass acroll to bottom call
          WidgetsBinding.instance!.addPersistentFrameCallback((_) {
            if (_messageListViewController.hasClients) {
              _messageListViewController
                  .jumpTo(_messageListViewController.position.maxScrollExtent);
            }
          });
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void deleteChat() {
    goBack();
    _db!.deleteChat(_chatID);
  }

  void sendTextMessage() {
    if (_message != null) {
      ChatMessage _messagetoSend = ChatMessage(
          sender_id: _auth.user.uid,
          type: MessageType.TEXT,
          content: _message!,
          sent_time: DateTime.now());

      _db!.addMessageToChat(_chatID, _messagetoSend);
    }
  }

  void sentImageMessage() async {
    try {
      PlatformFile? _file = await _mediaService!.pickImageFromLibrabry();
      if (_file != null) {
        String? _downloadUrl =
            await _storage!.saveChatImage(_chatID, _auth.user.uid, _file);
        ChatMessage _messageToSend = ChatMessage(
            sender_id: _auth.user.uid,
            type: MessageType.IMAGE,
            content: _downloadUrl!,
            sent_time: DateTime.now());

        _db!.addMessageToChat(_chatID, _messageToSend);
      }
    } catch (e) {}
  }
}
