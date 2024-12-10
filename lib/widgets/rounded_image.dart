import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  final String imagePath;
  final double size;
  const RoundedImage(
      {required Key key, required this.imagePath, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(imagePath), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(size)),
          color: Colors.black),
    );
  }
}

class RoundedImageFile extends StatelessWidget {
  final PlatformFile imagePath;
  final double size;
  const RoundedImageFile(
      {required Key key, required this.imagePath, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(File(imagePath.path!)), // Use FileImage here
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(size),
          ),
          color: Colors.black),
    );
  }
}
