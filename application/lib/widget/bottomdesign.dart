import 'package:flutter/material.dart';

class BottomDesign extends StatelessWidget {
  final double width;
  final double height;
  const BottomDesign({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -(height * 0.075),
      child: Hero(
        tag: "bottomDesign",
        child: Image.asset(
          "assets/images/background_cloud.png",
          width: width,
        ),
      ),
    );
  }
}
