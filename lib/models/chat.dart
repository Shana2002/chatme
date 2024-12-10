import 'package:chatme/models/chat_message.dart';
import 'package:chatme/models/chat_user.dart';

class Chat {
  final String uid;
  final String currentUserId;
  final bool activity;
  final bool group;
  final List<ChatUser> members;
  List<ChatMessage> messages;
  late final List<ChatUser> _recepiants;

  Chat({
    required this.uid,
    required this.currentUserId,
    required this.members,
    required this.messages,
    required this.activity,
    required this.group,
  }) {
    _recepiants = members.where((_i) => _i.uid != currentUserId).toList();
  }

  List<ChatUser> recepiants() {
    return _recepiants;
  }

  String title() {
    return !group
        ? _recepiants.first.name
        : _recepiants.map((_user) => _user.name).join(",");
  }

  String imageUrl() {
    return !group
        ? _recepiants.first.image
        : "https://e7.pngegg.com/pngimages/380/670/png-clipart-group-chat-logo-blue-area-text-symbol-metroui-apps-live-messenger-alt-2-blue-text.png";
  }
}
