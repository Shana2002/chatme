import 'dart:async';

// packages
import 'package:chatme/models/chat_message.dart';
import 'package:chatme/models/chat_user.dart';
import 'package:chatme/providers/authentication_provider.dart';
import 'package:chatme/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Services

// Providers

// models
import 'package:chatme/models/chat.dart';

class ChatsPageProvider extends ChangeNotifier {
  AuthenticationProvider _auth;
  late DatabaseService _db;

  List<Chat>? chats;

  late StreamSubscription _chatsStraem;

  ChatsPageProvider(this._auth) {
    _db = GetIt.instance.get<DatabaseService>();
    getChats();
  }

  @override
  void dispose() {
    _chatsStraem.cancel();
    super.dispose();
  }

  void getChats() async {
    try {
      _chatsStraem = _db.getChatsForUser(_auth.user.uid).listen(
        (_snapshot) async {
          chats = await Future.wait(
            _snapshot.docs.map(
              (_d) async {
                // print(chats != null ? chats![0].is_activity : "wow121");
                Map<String, dynamic> _chatData =
                    _d.data() as Map<String, dynamic>;
                // Get users data
                print("hello  $_chatData");
                List<ChatUser> _members = [];
                for (var _uid in _chatData['members']) {
                  DocumentSnapshot _userSnapshot = await _db.getUser(_uid);
                  Map<String, dynamic> _userData =
                      _userSnapshot.data() as Map<String, dynamic>;
                  _userData['uid'] = _userSnapshot.id;
                  _members.add(ChatUser.fromJSON(_userData));
                }
                print(_members[0].uid);
                // get last message of chats
                List<ChatMessage> _messages = [];
                QuerySnapshot _chatMessage =
                    await _db.getLastMessageForChat(_d.id);
                if (_chatMessage.docs.isNotEmpty) {
                  print("hello");
                  print(_chatMessage.docs.first.data());
                  Map<String, dynamic> _messageData =
                      _chatMessage.docs.first.data() as Map<String, dynamic>;
                  ChatMessage _message = ChatMessage.fromJSON(_messageData);
                  _messages.add(_message);
                  print("hello12331231");
                }
                // print(_members);
                // print(_messages);
                // print(_d.id +
                //     _auth.user.uid +
                //     _chatData['is_activity'] +
                //     _chatData['is_group']);
                return Chat(
                    uid: _d.id,
                    currentUserId: _auth.user.uid,
                    members: _members,
                    messages: _messages,
                    is_activity: _chatData['is_activity'],
                    is_group: _chatData['is_group']);
              },
            ).toList(),
          );
          notifyListeners();
        },
      );
    } catch (e, stackTrace) {
      print("Error getting chats $e");
      print(stackTrace);
    }
  }
}
