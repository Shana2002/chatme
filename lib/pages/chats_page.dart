import 'package:chatme/models/chat.dart';
import 'package:chatme/models/chat_message.dart';
import 'package:chatme/models/chat_user.dart';
import 'package:chatme/providers/chats_page_provider.dart';
import 'package:chatme/widgets/custom_list_view_tile.dart';
import 'package:chatme/widgets/top_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Providers
import 'package:chatme/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  double? _deviceHieght, _deviceWidth;
  AuthenticationProvider? _auth;
  ChatsPageProvider? _pageProvider;

  @override
  Widget build(BuildContext context) {
    _deviceHieght = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatsPageProvider>(
            create: (_) => ChatsPageProvider(_auth!)),
      ],
      child: Builder(
        builder: (BuildContext _context) {
          _pageProvider = _context.watch<ChatsPageProvider>();
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: _deviceWidth! * 0.03,
                vertical: _deviceHieght! * 0.02),
            height: _deviceHieght! * 0.98,
            width: _deviceWidth! * 0.97,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TopBar(
                  "Chats",
                  primaryAction: IconButton(
                    onPressed: () {
                      _auth!.logOut();
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Color.fromRGBO(0, 82, 218, 1.0),
                    ),
                  ),
                ),
                _chatList(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _chatList() {
    List<Chat>? _chats = _pageProvider!.chats;
    print(_chats);
    return Expanded(child: (() {
      if (_chats != null) {
        if (_chats.length != 0) {
          print("hello  ${_chats[0].members[0].name}");
          print("hello2  ${_chats[1].is_group}");
          return ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (BuildContext _context, int _index) {
                return _chatTile(_chats[_index]);
              });
        } else {
          return Center(
            child: Text(
              "No chats Founded",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      }
    })());
  }

  Widget _chatTile(Chat _chats) {
    List<ChatUser> _recepeindts = _chats.recepiants();
    bool _isActive = _recepeindts.any((_d) => _d.wasRecentlyActive());
    String _subtitle = _chats.messages.isNotEmpty
        ? _chats.messages.first.type != MessageType.TEXT
            ? "Media Attachement"
            : _chats.messages.first.content
        : "";
    return CustomListViewTile(
        height: _deviceHieght! * 0.1,
        title: _chats.title(),
        subTitile: _subtitle,
        imagePath: _chats.imageUrl(),
        isActive: _isActive,
        isActivity: _chats.is_activity,
        onTap: () {});
  }
}
