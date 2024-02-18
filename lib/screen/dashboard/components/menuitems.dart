import 'package:flutter/material.dart';
import 'dart:math' as math;

class BuildMenuItems extends StatelessWidget {
  BuildMenuItems({
    Key? key,
    required this.title,
    required this.icons,
    this.tap,
    this.transform
  }): super(key: key);

  String title;
  Widget icons;
  VoidCallback? tap;
  bool? transform;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: tap,
            child: ListTile(
              leading:
                  transform == true?
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: icons,
              ) :  icons,
              title: Text(title),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              height: 1,
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
