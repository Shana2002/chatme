import 'package:chatme/models/chat.dart';
import 'package:chatme/models/chat_user.dart';
import 'package:chatme/pages/chat_page.dart';
import 'package:chatme/providers/authentication_provider.dart';
import 'package:chatme/services/database_service.dart';
import 'package:chatme/services/navigation_service.dart';
import 'package:chatme/widgets/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UsersPageProvider extends ChangeNotifier {
  AuthenticationProvider _auth;

  DatabaseService? _db;
  NavigationService? _navigationService;

  List<ChatUser>? users;
  late List<ChatUser> _selectedUsers;

  List<ChatUser> get selectedUsers {
    return _selectedUsers;
  }

  UsersPageProvider(this._auth) {
    _selectedUsers = [];
    _db = GetIt.instance.get<DatabaseService>();
    _navigationService = GetIt.instance.get<NavigationService>();
    getUsers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getUsers({String? name}) async {
    _selectedUsers = [];
    try {
      _db!.getUsers(name: name).then((_snapshot) {
        users = _snapshot.docs.map((_doc) {
          Map<String, dynamic> _data = _doc.data() as Map<String, dynamic>;
          _data["uid"] = _doc.id;
          return ChatUser.fromJSON(_data);
        }).toList();
        notifyListeners();
      });
    } catch (e) {}
  }

  void updateSelectedUser(ChatUser _user) {
    if (_selectedUsers.contains(_user)) {
      _selectedUsers.remove(_user);
    } else {
      _selectedUsers.add(_user);
    }
    notifyListeners();
  }

  void createChat() async {
    try {
      // Create chat
      List<String> _membersIds =
          _selectedUsers.map((_user) => _user.uid).toList();
      _membersIds.add(_auth.user.uid);
      bool _isGroupChat = _selectedUsers.length > 2;
      DocumentReference? _doc = await _db!.createChat(
        {
          "is_group": _isGroupChat,
          "is_activity": false,
          "members": _membersIds,
        },
      );
      // Navigate to chat page
      List<ChatUser> _members = [];
      for (var _uid in _membersIds) {
        DocumentSnapshot _userSnapshot = await _db!.getUser(_uid);
        Map<String, dynamic> _userData =
            _userSnapshot.data() as Map<String, dynamic>;
        _userData["uid"] = _userSnapshot.id;
        _members.add(
          ChatUser.fromJSON(
            _userData,
          ),
        );
      }
      ChatPage _chatPage = ChatPage(
        chat: Chat(
            uid: _doc!.id,
            currentUserId: _auth.user.uid,
            members: _members,
            messages: [],
            is_activity: false,
            is_group: _isGroupChat),
      );
      _selectedUsers = [];
      notifyListeners();
      _navigationService!.navigateToPage(_chatPage);
    } catch (e) {
      print(e);
    }
  }
}
