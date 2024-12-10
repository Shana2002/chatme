import 'package:chatme/widgets/custom_list_view_tile.dart';
import 'package:chatme/widgets/top_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    _deviceHieght = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth! * 0.03, vertical: _deviceHieght! * 0.02),
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
                )),
          ),
          CustomListViewTile(
              height: _deviceHieght! * 0.1,
              title: "Hansaka Ravishan",
              subTitile: "Helllo",
              imagePath: "https://i.pravatar.cc/300",
              isActive: true,
              isActivity: true,
              onTap: () {})
        ],
      ),
    );
  }
}
