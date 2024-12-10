import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  String _barTitle;
  Widget? primaryAction;
  Widget? secondAction;
  double? fontSize;
  TopBar(this._barTitle,
      {this.primaryAction, this.secondAction, this.fontSize=35});
  double? _deviceHieght, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHieght = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: _deviceHieght! * 0.1,
      width: _deviceWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (secondAction != null) secondAction!,
          _titleBar(),
          if (primaryAction != null) primaryAction!,
        ],
      ),
    );
  }

  Widget _titleBar() {
    return Text(
      _barTitle,
      style: TextStyle(
          color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.w700),
      overflow: TextOverflow.ellipsis,
    );
  }
}
