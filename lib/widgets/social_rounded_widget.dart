import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../consts.dart';
class SocialRoundedWidget extends StatelessWidget {
  SocialRoundedWidget({this.iconData});
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: ShapeDecoration(
          color: kSecondaryBlueColorHex,
          shape: CircleBorder(),
        ),
        child: Icon(
          iconData,
          color: Colors.white,
        ),
      ),
    );
  }
}
