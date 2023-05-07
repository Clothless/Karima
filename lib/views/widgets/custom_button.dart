import 'package:flutter/material.dart';
import 'package:karima/views/widgets/widgets.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color foreground;
  final Color background;
  final double fontsize;
  final Function? onPress;
  final double pad;

  const CustomButton({
    this.text = "",
    this.foreground = Colors.white,
    this.background = Colors.green,
    this.fontsize = 16,
    this.onPress,
    this.pad = 16.0,
    });

  @override
  Widget build(BuildContext context) {
    return TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(pad),
              backgroundColor: background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                                
              )
              ),
              onPressed: () {
                onPress!();
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