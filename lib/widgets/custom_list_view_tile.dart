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
