import 'package:chatme/models/chat_user.dart';
import 'package:chatme/providers/authentication_provider.dart';
import 'package:chatme/providers/users_page.dart';
import 'package:chatme/widgets/custom_input_field.dart';
import 'package:chatme/widgets/custom_list_view_tile.dart';
import 'package:chatme/widgets/rounded_button.dart';
import 'package:chatme/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  double? _deviceHeight, _deviceWidth;
  AuthenticationProvider? _auth;
  final TextEditingController _searchController = TextEditingController();
  UsersPageProvider? _pageProvider;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersPageProvider>(
            create: (_) => UsersPageProvider(_auth!))
      ],
      child: Builder(builder: (_context) {
        _pageProvider = _context.watch<UsersPageProvider>();
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: _deviceWidth! * 0.03,
              vertical: _deviceHeight! * 0.02),
          height: _deviceHeight! * 0.98,
          width: _deviceWidth! * 0.97,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopBar(
                'Users',
                primaryAction: IconButton(
                  onPressed: () {
                    _auth!.logOut();
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Color.fromRGBO(0, 82, 218, 1.0),
                  ),
                ),
              ),
              CustomTextField(
                onEdiditngComplete: (_value) {
                  _pageProvider!.getUsers(name: _value);
                  FocusScope.of(context).unfocus();
                },
                hintText: "Serach...",
                obscureText: false,
                controller: _searchController,
                icon: Icons.search,
              ),
              _usersList(),
              _createChatButton(),
            ],
          ),
        );
      }),
    );
  }

  Widget _usersList() {
    List<ChatUser>? _users = _pageProvider!.users;
    return Expanded(child: () {
      if (_users != null) {
        if (_users.length != 0) {
          return ListView.builder(
            itemCount: _users.length,
            itemBuilder: (_context, _index) {
              return CustomListViewTileUser(
                height: _deviceHeight! * 0.10,
                title: _users[_index].name,
                subTitile: "Last Active : ${_users[_index].last_active}",
                imagePath: _users[_index].image,
                isActive: _users[_index].wasRecentlyActive(),
                isSelected:
                    _pageProvider!.selectedUsers.contains(_users[_index]),
                onTap: () {
                  _pageProvider!.updateSelectedUser(_users[_index]);
                },
              );
            },
          );
        } else {
          return Center(
            child: Text(
              "Users Not Found",
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
    }());
  }

  Widget _createChatButton() {
    return Visibility(
      visible: _pageProvider!.selectedUsers.isNotEmpty,
      child: RoundedButton(
          name: _pageProvider!.selectedUsers!.length == 1
              ? "Chat With ${_pageProvider!.selectedUsers.first.name}"
              : "Chat With Group",
          height: _deviceHeight! * 0.08,
          width: _deviceWidth! * 0.6,
          onPressed: () {
            _pageProvider!.createChat();
          }),
    );
  }
}
