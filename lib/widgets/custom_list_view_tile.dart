import 'package:chatme/models/chat_message.dart';
import 'package:chatme/models/chat_user.dart';
import 'package:chatme/widgets/message_bubble.dart';
import 'package:chatme/widgets/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomListViewTile extends StatelessWidget {
  final double height;
  final String title;
  final String subTitile;
  final String imagePath;
  final bool isActive;
  final bool isActivity;
  final Function onTap;

  CustomListViewTile({
    required this.height,
    required this.title,
    required this.subTitile,
    required this.imagePath,
    required this.isActive,
    required this.isActivity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(),
      minVerticalPadding: height * 0.20,
      leading: RounderNetworkImageWithIndicator(
          key: UniqueKey(),
          imagePath: imagePath,
          size: height / 2,
          isActive: isActive),
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
      ),
      subtitle: isActivity
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SpinKitThreeBounce(
                  color: Colors.white54,
                  size: height * 0.1,
                ),
              ],
            )
          : Text(
              subTitile,
              style: const TextStyle(
                  color: Colors.white54, fontWeight: FontWeight.w400),
            ),
    );
  }
}

class CustomChatListViewTile extends StatelessWidget {
  final double width;
  final double deviceHeight;
  final bool isOwned;
  final ChatMessage message;
  final ChatUser sender;
  const CustomChatListViewTile(
      {required this.width,
      required this.deviceHeight,
      required this.isOwned,
      required this.message,
      required this.sender});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      width: width,
      child: Row(
        mainAxisAlignment:
            isOwned ? MainAxisAlignment.end : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          !isOwned
              ? RoundedImage(
                  key: UniqueKey(), imagePath: sender.image, size: width * 0.07)
              : Container(),
          SizedBox(
            width: width * 0.05,
          ),
          message.type == MessageType.TEXT
              ? MessageBubble(
                  isOwned: isOwned,
                  message: message,
                  hieght: deviceHeight * 0.06,
                  width: width)
              : ImageMessageBubble(
                  isOwned: isOwned,
                  message: message,
                  width: width * 0.55,
                  height: deviceHeight * 0.3),
        ],
      ),
    );
  }
}

class CustomListViewTileUser extends StatelessWidget {
  final double height;
  final String title;
  final String subTitile;
  final String imagePath;
  final bool isActive;
  final bool isSelected;
  final Function onTap;
  CustomListViewTileUser(
      {super.key,
      required this.height,
      required this.title,
      required this.subTitile,
      required this.imagePath,
      required this.isActive,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: isSelected
          ? Icon(
              Icons.check,
              color: Colors.white,
            )
          : null,
      onTap: () => onTap(),
      minVerticalPadding: height * 0.2,
      leading: RounderNetworkImageWithIndicator(
        key: UniqueKey(),
        imagePath: imagePath,
        size: height / 2,
        isActive: false,
      ),
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subTitile,
        style: const TextStyle(
            color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w400),
      ),
    );
  }
}
