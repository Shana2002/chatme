import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  void removeAndNavigateToRoute(String _page) {
    navigator.currentState!.popAndPushNamed(_page);
  }

  void navigateToRoute(String _page) {
    navigator.currentState!.pushNamed(_page);
  }

  void navigateToPage(Widget _page) {
    navigator.currentState!.push(
      MaterialPageRoute(
        builder: (BuildContext _context) {
          return _page;
        },
      ),
    );
  }

  void goBack() {
    navigator.currentState!.pop();
  }
}
