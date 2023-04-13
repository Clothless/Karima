import 'package:flutter/material.dart';
import 'package:karima/views/widgets/widgets.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color foreground;
  final Color background;
  final double fontsize;
  final Function onPress;

  const CustomButton({
    this.text = "",
    this.foreground = Colors.white,
    this.background = Colors.green,
    this.fontsize = 16,
    this.onPress,
    });

  @override
  Widget build(BuildContext context) {
    return TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16),
              backgroundColor: background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                                
              )
              ),
              onPressed: () {
                onPress();
                },
              child: CustomText(
                text: text,
                alignment: Alignment.center,
                color: foreground,
                fontSize: fontsize,
              ),
            );
  }
}