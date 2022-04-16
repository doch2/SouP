import 'package:flutter/material.dart';
import 'package:soup/themes/color_theme.dart';

class SoupButton extends StatelessWidget {
  const SoupButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.text,
      this.onTap})
      : super(key: key);
  final double width;
  final double height;
  final String text;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: width * 0.45,
          height: height * 0.05,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(blurRadius: 10, spreadRadius: 3, color: blueTwo)
              ]),
          child: Center(child: Text(text))),
    );
  }
}
