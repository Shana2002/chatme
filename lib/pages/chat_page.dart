import 'package:chatme/models/chat.dart';
import 'package:chatme/providers/authentication_provider.dart';
import 'package:chatme/providers/chat_provide.dart';
import 'package:chatme/services/navigation_service.dart';
import 'package:chatme/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;
  const ChatPage({super.key, required this.chat});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  double? _deviceHight, _deviceWidth;
  AuthenticationProvider? _auth;
  GlobalKey<FormState> _messageFormState = GlobalKey<FormState>();
  ScrollController? _messageListViewController;
  NavigationService? _navigationService;

  ChatProvide? _chatProvide;

  @override
  void initState() {
    super.initState();
    _messageListViewController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigationService = GetIt.instance.get<NavigationService>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatProvide>(
          create: (_) => ChatProvide(
              this.widget.chat.uid, _auth!, _messageListViewController!),
        )
      ],
      child: Builder(builder: (context) {
        _chatProvide = context.watch<ChatProvide>();
        return Scaffold(
          body: SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.symmetric(
                vertical: _deviceHight! * 0.02,
                horizontal: _deviceWidth! * 0.03),
            height: _deviceHight,
            width: _deviceHight! * 0.97,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TopBar(
                  this.widget.chat.title(),
                  fontSize: 15,
                  primaryAction: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: Color.fromRGBO(0, 82, 218, 1.0),
                    ),
                  ),
                  secondAction: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color.fromRGBO(0, 82, 218, 1.0),
                    ),
                  ),
                ),
              ],
            ),
          )),
        );
      }),
    );
  }
}
