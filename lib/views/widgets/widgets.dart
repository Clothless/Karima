import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final Alignment alignment;
  final height;
  final double separator;

  const CustomText({
    this.text = "Hello World",
    this.fontSize = 16,
    this.color = Colors.black,
    this.alignment = Alignment.topLeft,
    this.height = null,
    this.separator = 1.0,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      height: height,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          height: separator,
          ),
          ),
    );
  }
}