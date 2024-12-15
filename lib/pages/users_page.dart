import 'package:chatme/providers/authentication_provider.dart';
import 'package:chatme/widgets/custom_input_field.dart';
import 'package:chatme/widgets/custom_list_view_tile.dart';
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
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth! * 0.03, vertical: _deviceHeight! * 0.02),
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
              onPressed: () {},
              icon: Icon(
                Icons.logout,
                color: Color.fromRGBO(0, 82, 218, 1.0),
              ),
            ),
          ),
          CustomTextField(
            onEdiditngComplete: (_value) {},
            hintText: "Serach...",
            obscureText: false,
            controller: _searchController,
            icon: Icons.search,
          ),
          _usersList(),
        ],
      ),
    );
  }

  Widget _usersList() {
    return Expanded(child: () {
      return ListView.builder(
          itemCount: 10,
          itemBuilder: (_context, _index) {
            return CustomListViewTileUser(
                height: _deviceHeight! * 0.10,
                title: "title",
                subTitile: "subTitile",
                imagePath: "https://i.pravatar.cc/300",
                isActive: false,
                isSelected: true,
                onTap: () {});
          });
    }());
  }
}
