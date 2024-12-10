import 'package:chatme/pages/chats_page.dart';
import 'package:chatme/pages/users_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final List<Widget> _pages = [
    ChatsPage(),
    UsersPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: const Color.fromARGB(90, 255, 255, 255),
        backgroundColor: Color.fromRGBO(37, 36, 56, 1),
        items: const [
          BottomNavigationBarItem(
              label: "Chats", icon: Icon(Icons.chat_bubble)),
          BottomNavigationBarItem(
              label: "Users", icon: Icon(Icons.supervised_user_circle)),
        ],
        currentIndex: _currentPage,
        onTap: (_index) {
          setState(() {
            _currentPage = _index;
          });
        },
      ),
      body: _pages[_currentPage],
    );
  }
}
