import 'package:chatme/models/chat_message.dart';
import 'package:chatme/models/chat_user.dart';

class Chat {
  final String uid;
  final String currentUserId;
  final bool is_activity;
  final bool is_group;
  final List<ChatUser> members;
  List<ChatMessage> messages;
  late final List<ChatUser> _recepiants;

  Chat({
    required this.uid,
    required this.currentUserId,
    required this.members,
    required this.messages,
    required this.is_activity,
    required this.is_group,
  }) {
    _recepiants = members.where((_i) => _i.uid != currentUserId).toList();
  }

  List<ChatUser> recepiants() {
    return _recepiants;
  }

  String title() {
    return !is_group
        ? _recepiants.first.name
        : _recepiants.map((_user) => _user.name).join(",");
  }

  String imageUrl() {
    return !is_group
        ? _recepiants.first.image
        : "https://e7.pngegg.com/pngimages/380/670/png-clipart-group-chat-logo-blue-area-text-symbol-metroui-apps-live-messenger-alt-2-blue-text.png";
  }
}
